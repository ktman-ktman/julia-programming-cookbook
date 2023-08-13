# 13.1
joinpath("path", "to", "file.txt")
path = "path/to/file.txt"
splitpath(path)

splitdir(path)
dirname(path)
basename(path)
splitext("file.txt")
splitext("file")

pwd()
rpath = "./path/to/file.txt"
apath = abspath(rpath)

relpath(apath)
isabspath(rpath)
isabspath(apath)

normpath("foo//../file.txt")
expanduser("~/.julia")

pwd()
isdir(pwd())
isfile(pwd())

for (root, dirs, files) in walkdir(pwd())
    for dir in dirs
        println("d: ", joinpath(root, dir))
    end
    for file in files
        println("f: ", joinpath(root, file))
    end
end

filepath = "./src.jl"
s = stat(filepath)
s.size
s.mode
s.mtime
s.ctime

filesize(filepath)
filemode(filepath)
ctime(filepath)
mtime(filepath)

old = pwd()
cd(expanduser("~/.config"))
tmp = pwd()
cd(old)

line = "this is a pen!"
println(stdout, line)
println(stderr, line)

pwd()
file = open("./program/chapter13/data.csv")
header = readline(file)
close(file)

file = open("./program/chapter13/message.txt", "w")
println(file, "hello")
close(file)

using Serialization

buf = IOBuffer()
serialize(buf, 42)
serialize(buf, "文字列")
serialize(buf, [1, 2, 3])

seekstart(buf)
deserialize(buf)
deserialize(buf)
deserialize(buf)

using JSON

langs = JSON.parse(
    """
    {
        "julia": {
            "first-release": 2012,
            "creators": [
                "Jeff Benzanson",
                "Stefen Karpinski",
                "Viral Shah"
            ]
        },
        "python": {
            "first-release": 1991,
            "creators": [
                "Guido van Rossum"
            ]
        }
    }
    """
)
JSON.json(langs)

JSON.parse(JSON.json([0xff, 'c', missing]))

using DataFrames

data = DataFrame(
    x=randn(100),
    y=rand(0:9, 100),
    z=rand(Bool, 100),
)

using CSV

CSV.write("data.csv", data)
data = CSV.read("data.csv", DataFrame)

using HDF5

A = randn(100, 100)
B = randn(100, 100, 100)

h5write("data.h5", "./array/A", A)
h5write("data.h5", "./array/B", B)

A = h5read("data.h5", "/array/A")
B = h5read("data.h5", "/array/B")

using Dates

DateTime(2009, 7)
DateTime(2009, 7, 22, 20)
DateTime(2009, 7, 22, 20, 39, 6)

Date(2009)
Date(2009, 7)
Date(2009, 7, 22)

Time(1)
Time(1, 2, 3)
Time(1, 2, 3, 4, 5, 6)

now()
today()

datetime = DateTime(2009, 7, 22, 20, 39, 6)
day = Date(2009, 7, 22)

month(datetime)
month(day)

hour(datetime)
hour(day)

dt = DateTime(2009, 8, 22, 20, 39, 6)
dt + Day(2)
dt + Month(5)
dt - Year(1)
dt - Millisecond(120)

dt1 = DateTime(2009, 8, 22, 20, 39, 6)
dt2 = DateTime(2009, 7, 23, 2, 2, 49)
dt1 - dt2

canonicalize(Dates.CompoundPeriod(dt1 - dt2))

Dates.format(Date(2009, 7, 22), "Y/m/d")
Dates.format(Date(794), "Y")
Dates.format(Date(794), "YYYYY")
Dates.format(Date(2009), "yy")

s = "2009/7/22 20:39:06"

Date(s[1:9], "Y/m/d")

DateTime(s, "Y/m/d H:M:S")

DateTime(s, dateformat"Y/m/d H:M:S")

unix2datetime(1)
datetime2unix(now())

using TimeZones

localzone()

tz"Asia/Tokyo"
tx"EST"
tz"UTC"

using Dates, TimeZones

datetime = DateTime(2018, 12, 19, 13, 27, 46)
zoneddt = ZonedDateTime(datetime, tz"Asia/Tokyo")

DateTime(zoneddt, Local)
DateTime(zoneddt, UTC)

## 13.5
@error "error message"
@warn "warning message"
@info "info message"
@debug "debug message"

x = 100
y = 200

@warn "x is smaller than y" x y

using Logging

logger = current_logger()
typeof(logger)
logger === global_logger()

mylogger = ConsoleLogger()
with_logger(mylogger) do
    current_logger() === mylogger
end
current_logger() === mylogger

@error "Error!";
@warn "Warn!";
@info "Info!";

disable_logging(Logging.Warn)

@error "Error!";
@warn "Warn!";
@info "Info!";