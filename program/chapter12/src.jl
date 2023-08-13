# 12
## 12.1
task = current_task()
istaskstarted(task)
istaskdone(task)
istaskfailed(task)

task = Task(() -> nothing)
istaskstarted(task)
task = @task begin
    for i in 9:-1:1
        println(i)
        sleep(i)
    end
    println("zero!")
end

myname() = objectid(current_task())
printtaskid() = println(string(myname() % UInt16, base=16))
task = Task(printtaskid)

printtaskid()
yield(task)
printtaskid()

goodtask = Task(() -> 3 * 4)
yield(goodtask)
istaskdone(goodtask)
istaskfailed(goodtask)
istaskfailed(goodtask)
fetch(goodtask)

badtask = Task(() -> error("failed!"))
yield(badtask)
istaskdone(badtask)
istaskfailed(badtask)
fetch(badtask)

x, y, z = 15, 6, 0
busy = Task(() -> tarai(x, y, z))
lazy = Task(() -> (sleep(1); tarai(x, y, z)))

function tarai(x, y, z)
    if x > y
        return tarai(
            tarai(x - 1, y, z),
            tarai(y - 1, z, x),
            tarai(z - 1, x, y),
        )
    else
        return y
    end
end

@elapsed tarai(x, y, z)
@elapsed yield(busy)
@elapsed yield(lazy)

@time @sync begin
    @async sleep(3)
    @async sleep(3)
    @async sleep(3)
end

@time @sync for _ in 1:3
    @async sleep(3)
end

async_sleep(n) = @async sleep(n)
@sync async_sleep(3)

chan = Channel{Int}(8)

chan = Channel{Int}()

for i in 1:10
    put!(chan, i)
end
close(chan)

while isopen(chan) || isready(chan)
    data = take!(chan)
    @show data
end

chan = Channel{Int}() do chan
    for i in 1:10
        put!(chan, i)
    end
end

@sync for label in 'A':'E'
    @async for data in chan
        println(label, ": ", data)
    end
end

## 12.2
function cnt()
    counter = 0
    Threads.@threads for i in 1:1_000_000
        global counter
        counter += 1
    end
    @show counter
end

cnt()
counter = 0
Threads.@threads for i in 1:1_000_000
    global counter
    counter += 1
end
@show counter

Threads.nthreads()
Threads.threadid()

using .Threads: @threads, nthreads, threadid

@threads for i in 1:nthreads()
    @show threadid()
end


using .Threads: @spawn, nthreads, threadid

@sync for i in 1:nthreads()
    @spawn @show threadid()
end

chan = Channel{Int}(4) do chan
    for i in 0:9
        put!(chan, i)
    end
end

Threads.foreach(chan) do i
    @show threadid(), i
end

const N = 1000

function mandelbrot(c::Complex; maxiters=N)
    k = 0
    z = zero(c)
    while k < maxiters && abs2(z) <= 4
        z = z * z + c
        k += 1
    end
    return maxiters - k
end

function plot_seq(x, y; maxiters=N)
    m, n = length.((y, x))
    img = zeros(Int16, m, n)
    for j in 1:n, i in 1:m
        c = complex(x[j], y[i])
        img[i, j] = mandelbrot(c; maxiters)
    end
    return img
end

@time plot_seq(-2.0:0.1:0.8, -1.4:0.1:1.4)

function plot_par1(x, y; maxiters=N)
    m, n = length.((y, x))
    img = zeros(Int16, m, n)
    Threads.@threads :static for j in 1:n
        for i in 1:m
            c = complex(x[j], y[i])
            img[i, j] = mandelbrot(c; maxiters)
        end
    end
    return img
end

@time plot_par1(-2.0:0.1:0.8, -1.4:0.1:1.4)

counter = 0
mutex = ReentrantLock()
Threads.@threads for i in 1:1_000_000
    global counter
    lock(mutex)
    counter += 1
    unlock(mutex)
end
@show counter

## 12.3
using Distributed
myid()
workers()

futures = Future[]
for i in workers()
    push!(fuxtures, remotecall(myid, i))
end

for future in futures
    @show fetch(future)
end

x = 5
fetch(@spawnat 1 2x)
fetch(@spawnat :any 2x)

n = @distributed (+) for i in 1:1_000_000_000
    x = rand()
    y = rand()
    x*x + y*y < 1
end

pmap(n -> maximum(cumsum(randn(1 << n))), 11:15)

