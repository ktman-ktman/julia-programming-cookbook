# 14.1
`ls -latr`
`ls src`
`ls -lh src`

cmd = "ls"
args = "src"
`$(cmd) $(args)`

# 14.2
toplogger = pipeline(
    pipeline(`top -b`, stdout=`head -1`),
    stdout="log.txt",
    append=true,
)
for _ in 1:10
    run(toplogger)
    sleep(1)
end