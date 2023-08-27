diameter(r) = 2 * r
circumference(r) = diameter(r) * π
area(r) = π * r^2

function main(args)
    r = parse(Float64, args[1])
    println("       radius = $(r)")
    println("     diameter = $(diameter(r))")
    println("circumference = $(circumference(r))")
    println("         area = $(area(r))")
end

(abspath(PROGRAM_FILE) == @__FILE__) && main(ARGS)