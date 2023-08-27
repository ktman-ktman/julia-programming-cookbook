function sleeper()
    sleep(1)
    for i in 1:5
        sleep(0.1)
    end
    deepsleeper(5)
end

function deepsleeper(n)
    if n ≤ 1
        sleep(1)
    else
        deepsleeper(n - 1)
    end
end

using Profile

sleeper()
@profile sleeper()
Profile.print()