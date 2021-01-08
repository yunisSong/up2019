//: [Previous](@previous)

import Foundation


/// 注释的快捷键是 alt + command + /
/// - Parameter x: 参数1
/// - Parameter y: 参数2
func t(x : Int ,y : Int) -> Int {
	x + y
}
//a 是外部参数名称 x 用于函数内部
func t1(a x : Int ,b y : Int) -> Int {
	x + y
}

// _ 下划线省略参数名称

//参数可以有默认值，默认值可以不传
func yuns(a : String,b : String = "Yunis")
{
	print("\(a) \(b)" )
}
yuns(a:"hhhhh")
//: [Next](@next)

//可变参数
// 一个函数最多只能有一个可变参数。z
//紧跟在可变参数后面的参数，参数便签不能省略。


func sum(_ numbers : Int ...) -> Int {
	var tatal = 0
	for number in numbers {
		tatal += number
	}
	return tatal
}

sum(10,20)
sum(10,20,30,40)

 
print("1","2","3",separator:"-----")

//inout 在函数内部 修改外部参数的值
// 函数的参数默认是 let ，只能是常量，不能是变量
// 可变参数不能标记为 inout
// inout 不能有默认值】
// inout 的本质就是 地址传递（引用传递，参数地址），直接通过参数地址，在函数内部修改参数地址指向的值。
// inout 参数只能传入可以多次赋值的参数。譬如 var 或者 数组的一部分 arr0]

func outAdd(_ num : inout Int) {
	num += 10
}

var inoutNumber = 10

outAdd(&inoutNumber)
print(inoutNumber)

// 函数重载
// 重载 函数名称相同。函数个数不同、参数不同、参数标签不同
// 重写 继承后覆盖
// OC 不支持重载吗？
// 多态 虚标？

//函数类型
// 返回值类型是函数类型的函数 称为高阶函数
func add(a : Int,b : Int) -> Int {
	a + b
}
func subtraction(a : Int,b : Int) -> Int {
	a - b
}

var typeFunc : (Int,Int) -> Int = add

typeFunc(1,2)

func printResoult (_ fun: (Int,Int) -> Int, _ x : Int,_ y : Int) {
	print("Resoult \(fun(x,y))")
}
printResoult(add,10,5)
printResoult(subtraction,10,5)

// 根据传入的参数不同，返回不同的函数调用
typealias IntFunType = (Int,Int) -> Int

func forward(_ forward:Bool) -> (Int,Int) -> Int {
	forward ? add : subtraction
}
func forward1(_ forward:Bool) -> IntFunType {
	forward ? add : subtraction
}

forward(true)(10,5)
forward(false)(10,5)
