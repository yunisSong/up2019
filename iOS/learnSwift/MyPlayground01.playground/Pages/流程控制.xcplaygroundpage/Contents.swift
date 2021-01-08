//: [Previous](@previous)

import Foundation

var age = 20

if age >= 22 {
	print(">= 22")
}else if age >= 18 {
	print(">= 18")
}else{
	print("----")
}


while age > 0 {
	print(age)
	age -= 1
}


var num = -1

repeat {
	print(num)
	num += 1
} while num < 10

//闭区间运算符 a...b  代表 a <= 值 <= b
for i in 1...3 {
	print(i)
}
let range = 1...3

for i in range {
	print(i)
}

for var i in 1...3 {
	i *= 10
	print(i)
}


for  _ in 1...3 {
	print("没用到参数 可以使用 _ 代替")
}

//版闭区间运算符 a..<b  代表 a <= 值 < b

for  i in 1..<3 {
	print("半闭区间 \(i)")
}

//u区间运算符用在数组

let names = ["a","b","c","d"];

for name in names[0...3]
{
	print(name)
}

for name in names[0...2]
{
	print(name)
}

//单侧区间 让区间向一个方向尽可能的远

for name in names[1...]
{
	print("单侧区间1 \(name)")
}
for name in names[...3]
{
	print("单侧区间2 \(name)")
}
for name in names[..<3]
{
	print("单侧区间3 \(name)")
}

//字符窜也能用于区间 运算

let string1 = "a"..."d"

string1.contains("a")
string1.contains("c")
string1.contains("e")
string1.contains("ba")
string1.contains("cc")
string1.contains("be")


let string2 = "bb"..."dd"

string2.contains("ba")
string2.contains("bc")
string2.contains("cc")

//带有间隔的区间值
let hours = 11
let hourInterval = 2

//从 4 开始，每次循环累加 （hourInterval）2 不超过 （hours）11
for tickMark in stride(from: 4, to: hours, by: hourInterval)
{
	print(tickMark)
}


//switch
//fallthrough 穿透效果 当前这种case成立后，直接到下面的 case
// 支持 char 和 string  类型
var snum = 1

switch snum {
case 1:
	print("--- \(snum)")
	fallthrough
case 2:
	print("--- 2")
default:
	print("默认值")
}


enum Answer {
	case Right,Wrong
}

let answer = Answer.Right
switch answer {
case Answer.Right:
	print(answer)
case .Wrong:
	print(answer)
}


let string = "jack"

switch string {
case "jack":
	fallthrough
case "rose":
	print("hhhh")
default:
	print("other")
}
switch string {
case "jack","rose":
	print("hhhh")
default:
	print("other")
}

// where  限制条件

let numbers = [10,20,39,-49,-59]
var total = 0
for num in numbers where num > 0 {
	total += num
}

print(total)

let point = (1,1)

switch point {
case (_,0):
	print("Y == 0")
case (0,_):
	print("x == 0")
case let (x,y) where x == y :
	print("x == y \(x) \(y)")
default:
	break
}






//: [Next](@next)

