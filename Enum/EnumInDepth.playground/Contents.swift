//: Playground - noun: a place where people can play

import UIKit

enum Days{
    case Sunday, Monday, Tuesday, Wednesday
}

let days = Days.Monday // this is how we create enum object.

switch days {
case .Sunday:
    print("Sunday")
default:
    print("default")
}

print("")

/**
    Swift supports four types for enum:
        Float
        String
        Bool
        Int
 */

enum AssociatedValue{
    case intType(Int, Int)
    case stringType(String)
}

let myIntType = AssociatedValue.intType(0, 1)
let myStringType = AssociatedValue.stringType("A")


// Mutating Enum methods

enum MyName: String{
    case realName, nickname
    
    var description: String{
        return self.rawValue
    }
    
    mutating func nextName(){
        print("Current Name is \(self.description)")
        
        switch self {
        case .nickname:
            self = .realName
            print("Mine \(self.rawValue)")
        case .realName:
            self = .nickname
            print("Mine \(self.rawValue)")
        }
    }
}

var names = MyName.realName
names.nextName()
print("A")


// Static Enum methods

enum AppleDevices: String {
    case iWatch, iPhone, iMac, MacPro
    
    static func getProduct(name: String) -> AppleDevices? {
        return AppleDevices(rawValue: name)
    }
    
    static func getAppleDevice(enterName: String) -> AppleDevices? {
        switch enterName {
        case "iWatch", "iPhone", "iMac", "MacPro":
            return getProduct(name: enterName)
        default:
            return nil
        }
    }
}

let device = AppleDevices.getProduct(name: "iWatch")


enum HttpError: String {
    case Code400 = "Bad Request"
    case Code401 = "Unauthorized"
    case Code402 = "Payment Required"
    case Code403 = "Forbidden"
    case Code404 = "Page Not Found"
    
    var description: String {
        return self.rawValue
    }
}

HttpError.Code400.description

//nested Enum

enum Enum1{
    enum Enum2{
        case enum2
    }
    enum Enum3{
        case enum3
    }
}

let e = Enum1.Enum2.enum2


//Enum is also Protocol oriented, Enum supports recursion.

struct MathOperation{
    static let addOperation: (Int, Int) -> Int = { $0 + $1 }
}

MathOperation.addOperation(3, 4)

// Generic Enum

enum MyOptional<T>{
    case none
    case some(T)
    
    init(_ anyValue: T){
        self = .some(anyValue)
    }
}




















































