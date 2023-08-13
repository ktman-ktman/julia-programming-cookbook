# 6.1
## 6.1.2
'a'

'響'

'\u61' === '\u0061' === 'a'
'\u97ff' === '\u0097ff'

## 6.1.3
'b' - 1
'b' + 1
'd' - 'a'
'Z' - 'A' + 1
'a' < 'b'
'd' > 'g'

sort(['d', 'e', 'c', 'a', 'b'])

uppercase('a')
lowercase('A')
isuppercase('A')

convert(Char, 0x97ff)
convert(Int, '響')

Char(0x97ff)
Int('響')
Char(38911)
UInt32('響')

codepoint('a')
codepoint('響')

## 6.1.4
'a'
'響'
'2'
'['
']'

# 6.2
## 6.2.1
"string"

"文字列"

"かき
くけ
こ"

"\0 \n \" \u61 \U97ff"

"ダブルクオート \" "

"""不要 " """

raw"C:\Pro"

## 6.2.2
favlang = "julia"

"I love $(favlang)"

x = 3
"√$(x) + √$(x + 1) ≈ $(sqrt(x) + sqrt(x+1))"

## 6.2.3
"Julia" == "Julia"

"Julia" == "julia"

"Julia" < "Julietta"

## 6.2.4
length("Julia")
length("julia言語")
sizeof("julia")
sizeof("julia言語")

## 6.2.5
isvalid("abc")
isvalid("\xc0\xaf")

## 6.2.6
s = "Julia"
s[4]

s = "julia言語"
s[7]
nextind(s, 5)
nextind(s, 6)
nextind(s, 8)
nextind(s, 9)
prevind(s, 12)

function printchars(s)
    fi, li = firstindex(s), lastindex(s)
    i = fi
    while i <= li
        i > fi && print("/")
        print("$(s[i])")
        i = nextind(s, i)
    end
end
printchars("julia言語")

for char in s
    @show char
end

codeunit(s, 1)
codeunit(s, 7)

## 6.2.7
s[1:5]
s[6:9]

@time s[1:5]
@time s[6:9]

SubString(s, 1:5)
SubString(s, 6:9)

@time SubString(s, 1:5)
@time SubString(s, 6:9)

@view s[1:5]
@view s[6:9]

@time @view s[1:5]
@time @view s[6:9]

line = chomp("some string\n")
typeof(line)

## 6.2.8
s1 = "\u304c"
s2 = "\u304b\u3099"

s1 == s2

length(s1)
sizeof(s1)
length(s2)
sizeof(s2)

using Unicode

s1 == Unicode.normalize(s2, :NFC)

s2 == Unicode.normalize(s1, :NFD)

s = "㍻３０年"
Unicode.normalize(s, :NFC)
Unicode.normalize(s, :NFKC)

# 6.3
## 6.3.1

pattern = r"Julia"
occursin(pattern, "The Ruby Language.")
occursin(pattern, "The Julia Language.")
occursin(pattern, "The Python Language.")

pattern = r"Julia|Python"
occursin(pattern, "The Ruby Language.")
occursin(pattern, "The Julia Language.")
occursin(pattern, "The Python Language.")

occursin(r"julialang\.org", "julialang.org")

occursin(r"^Julia$", "Julia")
occursin(r"^Julia$", "Juli")

occursin(r"J...a", "Julia")
occursin(r"J...a", "Jenga")
occursin(r"J...a", "Juia")

occursin(r"a.c", "abc")
occursin(r"a.c", "a\nc")

occursin(r"[Jj]ulia", "julia")
occursin(r"[Jj]ulia", "Julia")
occursin(r"[0-9A-Fa-f]", "4")
occursin(r"[0-9A-Fa-f]", "B")
occursin(r"[0-9A-Fa-f]", "g")

pattern = r"^(google|microsoft|netflix)\.com"
occursin(pattern, "google.com")
occursin(pattern, "google")
occursin(pattern, "microsoft.com")
occursin(pattern, "microsoft")

occursin(r"AB*C", "AC")
occursin(r"AB*C", "ABC")
occursin(r"AB*C", "ABBC")

occursin(r"AB+C", "AC")
occursin(r"AB+C", "ABC")
occursin(r"AB+C", "ABBC")

occursin(r"AB?C", "AC")
occursin(r"AB?C", "ABC")
occursin(r"AB?C", "ABBC")

occursin(r"(AB)+C", "AC")
occursin(r"(AB)+C", "ACBC")
occursin(r"(AB)+C", "ABABC")

hex = r"^0x([0-9A-Fa-f]_?)*[0-9A-Fa-f]$"
occursin(hex, "0x123456789abcdef")
occursin(hex, "0xDEAD_BEEF")
occursin(hex, "0x0x")
occursin(hex, "1234")

## 6.3.2
text = """
住所は東京都新宿区神楽坂2丁目です。
郵便番号は、162-0825です。
"""

pattern = r"[0-9]{3}-[0-9]{4}"
m = match(pattern, text)
m.match
m.offset
text[m.offset:end]
match(pattern, text, m.offset + 1)
nothing

pattern = r"([0-9]{3})-([0-9]{4})"
m = match(pattern, text)
m.captures
m.offsets

pattern = r"(?<proto>[a-z]+)://(?<host>[\w.]+)/(?<path>[\w/]+)"
m = match(pattern, "https://en.wikipedia.org/wiki/Stockholm")
m[:proto]
m[:host]
m[:path]

## 6.3.3
pattern = r"julia"i
occursin(pattern, "julia")
occursin(pattern, "Julia")
occursin(pattern, "JuLiA")

m = match(r"foo(?=bar)", "foobar")
m.match

m = match(r"(?<=foo)bar", "foobar")
m.match

pattern = r"(?<!mutable )struct"
occursin(pattern, "struct Foo")
occursin(pattern, "mutable struct Foo")

match(r"a*", "aaa").match
match(r"a*?", "aaa").match

match(r"a+", "aaa").match
match(r"a+?", "aaa").match

match(r"a?", "aaa").match
match(r"a??", "aaa").match

# 6.4
## 6.4.1

parse(Bool, "true")
parse(Bool, "false")

parse(Int, "1984")
parse(Int, "-273")

parse(Int, "deadbeef")
parse(Int, "deadbeef", base=32)
parse(Int, "8badf00d", base=16)

parse(Float64, "-273")
parse(Float64, "3.141592")
parse(Float64, "56.022e23")

parse(Complex{Float32}, "2.9 - 1.2i")
parse(Complex{Float32}, "2.9 - 1.2im")

parse(Int, "1Q84")
tryparse(Int, "1Q84")
tryparse(Int, "1984")

## 6.4.2
text = "The Julia language"
contains(text, 'J')
contains(text, "Julia")
contains(text, r"J...a")

startswith(text, "T")
startswith(text, "The")
startswith(text, r"[Tt]he")

endswith(text, 'e')
endswith(text, "age")
endswith(text, r"l.*age")

count('a', text)
count("Julia", text)
count(r"[a-z]+"i, text)

findfirst("J", text)
findfirst("Julia", text)
findfirst(r"J...a", text)
findfirst('Z', text)

i = findnext('a', text, 1)
i = findnext('a', text, i + 1)
i = findnext('a', text, i + 1)
i = findnext('a', text, i + 1)

findfirst('e', text)
findlast('e', text)

findall('a', text)
findall("a", text)
findall(r"[a-z]+"i, text)

count(isspace, text)
findfirst(isspace, text)
findnext(isspace, text, 5)
findall(isspace, text)

replace("abracadabra", 'a' => 'X')
replace("abracadabra", "bra" => "XXX")
replace("abracadabra", r".a" => "XX")

replace("<tag>", r"<([a-z]+?)>" => s"[\1]")

strip("    Story of Your Life \n")
lstrip("    Story of Your Life \n")
rstrip("    Story of Your Life \n")

chomp("    Story of Your Life \n")
chomp("    Story of Your Life \r\n")

## 6.4.4

string(299, ' ', "addiction")

"Just" * ' ' * "Alright"

'-'^5

"foo"^3

words = ["Killer", "rock", "and", "roll"]
join(words)

join(words, ",")

join(words, ',', ';')

split("Killer,rock,and,roll", ",", limit=3)
split("Killer,rock,and,,roll", ",", keepempty=false)

## 6.4.6

buf = IOBuffer()
print(buf, 299)
print(buf, ' ')
print(buf, "addiction")
String(take!(buf))