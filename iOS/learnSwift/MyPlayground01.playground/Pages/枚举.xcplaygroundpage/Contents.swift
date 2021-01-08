//: [Previous](@previous)

import Foundation

enum EnumName {
	case top
	case bottom
}

enum EnumName1 {
	case left,right
}

//枚举的关联值
//枚举的成员值可以和其他类型的关联存储在一起
enum Score {
	case points(Int)
	case grade(Character)
}

var scoreA = Score.points(98)
scoreA = .grade("A")
//digit 数字 string 字符串™
enum Date {
	case digit(y : Int,m:Int,d:Int)
	case string(String)
}
var date1 = Date.digit(y:2021,m:1,d:8)
date1 = .string("20210108")

switch date1 {
	case .digit(let y,let m,let d):
		print(y,m,d)
	case let .string(value):
		print(value)
}


// 枚举的原始值
// 枚举成员可以使用相同类型的默认值预先关联，这个默认值叫做：原始值

enum Pk : Character {
	case A = "A"
	case B = "B"
	case C = "C"

}
var pk1 = Pk.A
print(pk1)
print(pk1.rawValue)
print(Pk.B.rawValue)

// 隐式原始值
// 如果枚举的原始值类型是 Int ，String  ，会自动分配原始值
// Int  由 0 开始累加。String 就是类型的 String 名称


// 枚举递归

indirect enum ListMap {
	case index(Int)
	case body(ListMap)
}

// 内存占用
// alignment 内存对齐参数，分配的内存空间必须为这个参数的倍数
// size 实际占用的内存空间
// stride 分配的内存空间
date1 = .string("1")
MemoryLayout.size(ofValue: pk1)
MemoryLayout.size(ofValue: date1)
MemoryLayout.stride(ofValue: date1)
MemoryLayout.alignment(ofValue: date1)

// enum 实际占用的内存
// 关联值 枚举值绑定的数值，会存储在 枚举的内存模型中
// 原始值 必不会存储到枚举的内存中 ，与枚举占用的内存没有关系 rowValue 返回的一个 16字节的数据（应该是地址）
// Int 64位 8 个字节 32为 4个字节
// String 16 个字节
// 枚举实际占用的内存值是 选项中占用最大的内存的值
/*
	rg：
enum As {
	case A(Int) Int 8 位 +  本身占用 1位 =  9
	case B(String) String 占用 16 位  + 本身占用1位  = 17
}

所以 As 实际占用 17 为，但是 他分配的内存要为 对起数（8 ）的倍数，所以实际占用内存为 24


enum As1 {
	case A(Int,Int,Int) Int 8 位 + Int 8 位 + Int 8 位 + 本身占用 1位 =  25
	case B(String) 占用 16 位  + 本身占用1位  = 17
}
所以 As1 实际占用 25 为，但是 他分配的内存要为 对起数（8 ）的倍数，所以实际占用内存为 32

*/

enum As {
	case A(Int,Int,Int)
	case B(String)
}
var As1 = As.A(1,2,3)
var As2 = As.B("1pp")

MemoryLayout.size(ofValue: As1)
MemoryLayout.stride(ofValue: As1)
MemoryLayout.alignment(ofValue: As1)
//: [Next](@next)
