module Othello

export User, RandomAI, popdisplay

const Disk = Char
const DISK_EMPTY = '\u22c5'
const DISK_BLACK = '\u25cf'
const DISK_WHITE = '\u25cb'
const Position = Tuple{Char,Int}
const N = 8
const ROWS = 1:N
const COLS = 'a':('a'+N-1)

isblack(disk::Disk) = disk == DISK_BLACK
iswhite(disk::Disk) = disk == DISK_WHITE

flip(disk::Disk) =
    isblack(disk) ? DISK_WHITE :
    iswhite(disk) ? DISK_BLACK :
    throw(ArgumentError("not flippable"))

pos2idx(pos::Position) = (pos[2], pos[1] - 'a' + 1)
isonboard(pos::Position) = pos[2] in ROWS && pos[1] in COLS

struct Board
    data::Matrix{Disk}
end

function Board()
    board = Board(fill(DISK_EMPTY, (N, N)))
    board[('d', 5)] = board[('e', 4)] = DISK_BLACK
    board[('d', 4)] = board[('e', 5)] = DISK_WHITE
    return board
end

Base.getindex(board::Board, pos::Position) = board.data[pos2idx(pos)...]

function Base.setindex!(board::Board, disk::Disk, pos::Position)
    board.data[pos2idx(pos)...] = disk
    return board
end

function Base.show(output::IO, board::Board)
    disks = countdisks(board)
    print(output, "Board with $(disks.black) blacks")
    print(output, " and $(disks.white) whites:\n")
    print(output, " ")
    for c in COLS
        print(output, ' ', c)
    end
    for r in ROWS
        print(output, "\n", r)
        for c in COLS
            print(output, ' ', board[(c, r)])
        end
    end
end

function countdisks(board::Board)
    black = white = 0
    for c in COLS, r in ROWS
        disk = board[(c, r)]
        isblack(disk) && (black += 1)
        iswhite(disk) && (white += 1)
    end
    return (black=black, white=white)
end

function flips(board::Board, disk::Disk, pos::Position, dir::NTuple{2,Int})
    dir == (0, 0) && return nothing
    nflips = 0
    next = pos .+ dir
    while isonboard(next) && board[next] == flip(disk)
        nflips += 1
        next = next .+ dir
    end
    if nflips > 0 && isonboard(next) && board[next] == disk
        return next
    else
        return nothing
    end
end

function isvalidmove(board::Board, disk::Disk, pos::Position)
    isonboard(pos) &&
        !isblack(board[pos]) &&
        !iswhite(board[pos]) || return false
    dirs = ((u, v) for u in -1:1 for v in -1:1 if !(u == v == 0))
    return !all(isnothing, flips(board, disk, pos, dir) for dir in dirs)
end

function move!(board::Board, disk::Disk, pos::Position)
    isvalidmove(board, disk, pos) || throw(ArgumentError("invalid move"))
    board[pos] = disk
    for u in -1:1, v in -1:1
        dir = (u, v)
        pair = flips(board, disk, pos, dir)
        isnothing(pair) && continue
        next = pos .+ dir
        while next != pair
            board[next] = disk
            next = next .+ dir
        end
    end
    return board
end

abstract type Player end

"""
An interactive human player.
"""
struct User <: Player
    name::String
end

name(user::User) = user.name

function move(::User, ::Disk, ::Board)
    while true
        input = prompt("move>")
        if isnothing(input) || lowercase(input) == "resign"
            return nothing
        elseif contains(input, r"^[a-h][1-8]$"i)
            c = lowercase(input[1])
            r = input[2] - '0'
            return (c, r)
        end
        println("Invalid input; try again (e.g. f5)")
    end
end

function prompt(msg::String)
    print(msg)
    input = readline(stdin)
    return isopen(stdin) ? strip(input) : nothing
end

"""
A foolish AI player playing random moves.
"""
struct RandomAI <: Player
    name::String
end

name(ai::RandomAI) = ai.name

function move(::RandomAI, disk::Disk, board::Board)
    moves = Position[]
    for c in COLS, r in ROWS
        pos = (c, r)
        if isvalidmove(board, disk, pos)
            push!(moves, pos)
        end
    end
    return rand(moves)
end

struct Result
    board::Board
    black::Player
    white::RandomAI
    resigned::Union{Disk,Nothing}
end

using Printf: @printf

function Base.show(output::IO, result::Result)
    report(disk, count, player) =
        @printf output "%sx%2d %s\n" disk count name(player)
    disks = countdisks(result.board)
    report(DISK_BLACK, disks.black, result.black)
    report(DISK_WHITE, disks.white, result.white)
    resigned = result.resigned
    if isnothing(resigned)
        x = cmp(disks.black, disks.white)
        msg = x < 0 ? "white won" :
              x > 0 ? "black won" : "draw"
    else
        @assert isblack(resigned) || iswhite(resigned)
        color = isblack(resigned) ? "black" : "white"
        msg = "$(color) resigned"
    end
    print(output, msg)
end

"""
    play(; black, white)

Start playing a game.

# Arguments
- `black`:
    a player making the first move.
    `User` with a random name is the default.

- `white`:
    a player making the second move.
    `RandomAI` with a random name is the default.
"""
function play(;
    black::Player=User(randomname(DISK_BLACK)),
    white::Player=RandomAI(randomname(DISK_WHITE))
)
    print("$(DISK_BLACK) $(name(black)) vs ")
    print("$(DISK_WHITE) $(name(white))\n")
    board = Board()
    nextdisk = alternativedisks(board)
    while true
        println('\n', board)
        disk = nextdisk()
        if isnothing(disk)
            return Result(board, black, white, nothing)
        end
        player = isblack(disk) ? black : white
        playername = name(player)
        println("$(disk) $(playername)'s turn")
        pos = getmove(player, disk, board)
        if isnothing(pos)
            println(playername, " has resigned.")
            return Result(board, black, white, disk)
        else
            @assert isvalidmove(board, disk, pos)
            move!(board, disk, pos)
            println("$(playername) placed at $(pos[1])$(pos[2]).")
        end
    end
end

function getmove(player::Player, disk::Disk, board::Board)
    while true
        pos = move(player, disk, board)
        if isnothing(pos) || isvalidmove(board, disk, pos)
            return pos
        end
        println("You cannot move that position.")
    end
end

const BLACK_NAMES = ("Panther", "Hawk", "Stingray")
const WHITE_NAMES = ("Tiger", "Parrot", "Shark")

randomname(disk::Disk) =
    isblack(disk) ? "Black $(rand(BLACK_NAMES))" :
    iswhite(disk) ? "Black $(rand(WHITE_NAMES))" :
    throw(ArgumentError("invalid disk"))


function alternativedisks(board::Board)
    next = DISK_BLACK
    canmove() =
        any(isvalidmove(board, next, (c, r))
            for c in COLS, r in ROWS)
    return function ()
        if !canmove()
            next = flip(next)
            canmove() || return nothing
        end
        disk = next
        next = flip(next)
        return disk
    end
end

end