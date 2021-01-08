//: [Previous](@previous)

import Foundation

var letter : String?

print(letter ?? "为nil")
letter = "Yunis"
print(letter ?? "为nil")

//对值为 nil 的可选项进行强制捷豹，将产生运行时错误
//var letter1 : String?
//letter1! //Fatal error

//判断是否为nil
// 这种做法叫做 可选项绑定
var s1  = "100"
if let num = Int(s1) {
	print(num)
}else {
	print("转换失败")
}


s1  = "ss"
if let num = Int(s1) {
	print(num)
}else {
	print("转换失败")
}

s1  = "23"
s1  = "101"
if let num = Int(s1),
	num > 100
	{
	print(num)
}else {
	print("转换失败 或者值小于等于 100")
}

// 循环中使用可选项绑定
// eg:求数组中 大于0 的数字和,如果遇到负数或者不是数字的字符串就退出循环
var strs = ["100","2","ss","11","-2",]
var index = 0
var tatal = 0

while let num = Int(strs[index]),num > 0 {
	tatal += num
	index += 1
}
print(tatal)

// 空合并运算符
// a ?? b
// a 为可选项 b 为可选项或者不是可选项
// b 跟 a 的存储类型必须相同
// 如果 a 为 nil 返回 b
// 如果 a 不为 nil 返回 a
// 如过b 为不是可选项，返回 a 时 会自动解包

//3-1 1小时27分
//: [Next](@next)
