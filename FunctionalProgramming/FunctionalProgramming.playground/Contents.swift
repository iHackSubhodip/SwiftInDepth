//: Playground - noun: a place where people can play

import UIKit


/**
    A closure is a function without name and the func keyword.
    Quick and easy to carry around as a variable/constant or as just a parameter.
 */

// types of declaring closure.

var appened: (String, String) -> String = { $0 + $1 }

appened("hi", " Subh")


var addNumbers = { (n1: Int, n2: Int) in
    return n1 + n2
}

addNumbers(2, 3)

var myName: () -> String = {
    return "hey"
}

myName()

var withoutParamName = { "Hi Subh" }

withoutParamName()

// Pass closure Indirectly

func passClosure(closureBlock: () -> String){
    print(closureBlock())
}

passClosure(closureBlock: withoutParamName)



// Pass closure Directly

passClosure(closureBlock: { () in return "hey" })
passClosure(closureBlock: { return "hello" })
passClosure(closureBlock: { "cool" })


let evenNumber = Array(1...6).filter { $0 % 2 == 0}
print(evenNumber)

//Create view with closure

let view: UIView = {
    let view = UIView()
    view.backgroundColor = .black // making an object with closure
    return view
}()

let sqrtNumber: Double = {
    let sqrtNumber = Double() // not a computed property as it's a closure type
    return sqrt(sqrtNumber)
}()


//Lazy init
class LazyClass{
    lazy var calculate: Int = { // we declare it as lazy as it's required whenever it's accessed or needed, before that it will not gonna access property.
        2 * 2
    }()
}

var myLazyClass = LazyClass()
myLazyClass.calculate // as it's lazy it will not called everytime. reduce processing time.

//lazy var abc: String {
//    return "A" // no lazy for cmputed property as it's recalculated.
//}

/**
    lazy can't be used with let since there is no initial value.
    You can’t use it with a Computed property since computed property is always recalculated (requires CPU) when you modify any of the variables that has a relationship with the lazy property.
    lazy is only valid for members of a struct or class.
 */


print("\nCapture List\n")

/**
    Closure is reference type, Using capture list you can capture the value paramter in the closure, on every execution.
 */

var array: [() -> ()] = []

var j = 0

for _ in 1...3{
    array.append {
        print(j)
    }
    j += 1
}

array[0]()
array[1]()
array[2]() // it will print 3 as in closure we are not capturing the value. if we use capture list then in each execution it will capture the value.

print("\n")

var smartArray: [() -> ()] = []
var i = 0

for _ in 1...4{
    smartArray.append { [i] in // here we captured the value. used capture list
        print(i)
    }
    i += 1
}

smartArray[0]()
smartArray[1]()
smartArray[2]()
smartArray[3]()


print("\nTrailing Closure\n")

// If a function's last parameter requires a closure, beautify it using trailing closure.


func trailingClosure(number: Int, closure: (Int) -> Int){
    let n1 = closure(number)
    print(n1)
}

trailingClosure(number: 10) { (num) -> Int in
    num * num
}

trailingClosure(number: 2) { num in num * num }
trailingClosure(number: 19) { $0 * $0 }


print("\nCompletion Handlers\n")

// Comletion handler is nothing but to notify the user that something has been completed.

let closureBlock: (Bool) -> () = { (isSuccess) in
    if isSuccess{
        print(isSuccess)
    }
}


func download(completion: @escaping (Bool) -> Void) {
    for _ in 1...3{
        print("going on...")
    }
    completion(true)
}

download(completion: closureBlock)

print("\nFilter")

Array(1...4).filter { $0 % 2 == 0 } // Array is like generic struct only.

// design custom filter.

func myCustomFilter<T>(array: [T], operations: (T) -> Bool) -> [T]{
    var result: [T] = []
    for element in array{
        if operations(element){
            result.append(element)
        }
    }
    return result
}

print(myCustomFilter(array: ["A", "A", "C", "A", "B", "C"]) { $0 != "A" && $0 != "C" })


print("\nMap")

var numbers: [Int] = [1, 2, 3]

print(numbers.map { $0 * $0 })

// let's design generic map function.

func myCustomMap<T>(array: [T], operation: (T) -> T) -> [T]{
    var result: [T] = []
    
    for element in array{
        result.append(operation(element))
    }
    return result
}

print(myCustomMap(array: ["AA", "B", "C"]) { $0.lowercased() })


//extremely Generic


func myExtermeCustomMap<T,U>(array: [T], operation: (T) -> U) -> [U]{
    var result: [U] = []
    
    for element in array{
        result.append(operation(element))
    }
    return result
}

print(myExtermeCustomMap(array: ["A", "N", "K"]) { $0.lowercased() })

func convertToString(number: Int) -> String{
    return "Converted \(String(number))"
}

print(myExtermeCustomMap(array: [3, 4, 5], operation: convertToString))


print("\nReduce")


let myReduce = Array(1...8).reduce(0) { $0 + $1}
print(myReduce)

// generic reduce

func myReduce<U>(_ seed: U, numbers: [U], operation:(U, U) -> U)  -> U {
    var current = seed
    for item in numbers {
        current = operation(current, item )
    }
    return current
}

  /*
basic higher order functions:
 1. sort
 2. sorted
 3. foreach
 */

var names = ["ball11", "call111", "tall1", "mall"]
names.sort()
print(names.sorted(by: >))

let names1 = names.sorted { (v1, v2) -> Bool in
  return v1.count > v2.count
}

let names2 = names.sorted {
  return $0 < $1
}

names.enumerated().forEach { (tuple) in
  print(tuple.element + "->\(tuple.offset)")
}

let lengths = names.map { (value) -> Int in
  return value.count
}

let longerName = names.filter { (val) -> Bool in
  return val.count > 4
}

/*
 Compact map combines map and filter
 same definition as map but as an optional
 */

let lens2 = names.compactMap { (val) -> Int? in
  return val.count > 4 ? val.count : nil
}

let someVal: String? = "aa kkkk"
let someMap = someVal.flatMap { (val) -> Int? in
  return val.count > 4 ? val.count : nil
}

let reduceVal = names.reduce("") { (ongoing, val) -> String in
  return ongoing + val + " "
}

/*
 Takes the value and reduce to one (what reduce do)
 */

let longName = names.first { (val) -> Bool in
  return val.count > 6
}

var names11 = ["b", "c", "ta", "m"]

let reduceVal1 = names11.reduce(0) { $0 + $1.count }
print(reduceVal1)
// drop, split




































