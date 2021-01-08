//: [Previous](@previous)
import UIKit
import PlaygroundSupport
var str = "Hello, playground"
let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 200, height: 100);
view.backgroundColor = UIColor.red;

PlaygroundPage.current.liveView = view;


let imageView = UIImageView(image: UIImage(named: "003.jpg"));
PlaygroundPage.current.liveView = imageView;


let  vc = UITableViewController()
vc.view.backgroundColor = UIColor.green
PlaygroundPage.current.liveView = vc


//: [Next](@next)
