//: [Previous](@previous)

import Foundation

let age : Int
age = 100

let num = 200

//错误的写法 不指定类型
//let age1
//age1 = 100

/*:
### let
- 只能赋值一次
- 不要求值在编译时期就确定，但使用之前一定要赋值一次

*/
var v1 = 40;
v1 += 100;

let assignNum = v1;

func getAge() -> Int {
	return 27
}

let manAge = getAge();


//元组
let error = (404,"not found")
let (statusCode,statusMessage) = error
let (statusCode1,_) = error
print(statusCode)
print(statusMessage)
let http200Status = (statusCode:200,description:"ok")
print(http200Status.statusCode)
print(http200Status.description)







