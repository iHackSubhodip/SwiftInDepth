//: Playground - noun: a place where people can play

import UIKit
import Foundation

print(" Convenience Init \n")

class MyClass{
    var className: String
    init(name: String) { // Designated Init
        self.className = name
    }
    
    convenience init() {
        self.init(name: "Convenience Init.") // Convenience Init initializes the Designated Init.
    }
}

let conClass = MyClass()
print(conClass.className) // it's initialized the Convenience Init.


extension UIColor{
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}


let myColor = UIColor(r: 0.1, g: 0.1, b: 0.1)

/**
    Application:
        • Quick initialization for open source projects
        • Custom convenience inits with UIKit
 */


print("\n Computed property \n")

/**
    Computed property is calculated property
    It's of two types - Gettable Property & Settable property
    Gettable property can be read, but can't be modified.
 
 */

var side: Double = 10.0

var area: Double{
    get {
        return side * side
    }
    
    set{
        side = sqrt(newValue)
    }
}

area = 16
print(side)

/**
        Applications:
            • Grabbing and storing data the server
            • Propagating relationships between properties
            • Preventing others from manipulating your code
 */


print("\n Property Observers \n")

/**
        willSet is called just before the property value is stored.
        didSet is called after the property value is stored.
        it's always recalculated
 */


var isSelectedValue: Bool = false{
    willSet(newValue){
        print("changed the value")
    }
    didSet{
        if isSelectedValue{
            print("It's changed from \(oldValue) to \(isSelectedValue)")
        }
    }
}

isSelectedValue = false
print("\n")
isSelectedValue = true
print("\n")
isSelectedValue = true

/**
  Why it's different:
    There's is a default value as it declares the stored property[implicit/explicit] or optional type, so it's observed rather than calculated.
    willSet and didSet will not get called when you initialize it.
 
 */

print("\n Failable Init \n")

class FailableInit{
    var name: String
    
    init?(name: String) { // as we are returning nil, it's a failable init. so need to use init?
        if name.isEmpty{
            return nil
        }
        self.name = name
    }
}

var abc = FailableInit(name: "")
//var def = abc! // it will crash as failable init.

print("\n Override Method \n")


class BaseClass{
    func baseMethod(){
        print("base Method.")
    }
}


class InheritedClass: BaseClass{
    
    override func baseMethod() {
        print("Override changes everything in the super class")
        super.baseMethod()
    }
}

print(InheritedClass().baseMethod())



print("\n Override Init \n")


class BaseInit{
    var name: String
    init(name: String) {
        self.name = name
    }
}

class OverrideInit: BaseInit{
    override init(name: String) {
        //super.init(name: "name")
        super.init(name: name)
    }
}

let oInit = OverrideInit(name: "K")
print(oInit.name) // as in line 156 it's written as "name", so it's not changing, uncomment the line to check.


print("\n Two Phase Init \n")


struct NuclearRocket {
    var meters: Double
    var liters: Double
    
    // Init for 🇰🇷
    init(meters: Double, liters: Double) {
        self.meters = meters
        self.liters = liters
    }
    
    // Init for 🇺🇸
    init(ft: Double, gallons: Double) {
        let convertedMeters = ft / 3.28
        let convertedLiters = gallons * 3.79
        self.init(meters: convertedMeters, liters: convertedLiters)
    }
}

var rocket = NuclearRocket(meters: 20, liters: 20)
rocket.liters // 20
rocket.meters // 20

var newRocket = NuclearRocket(ft: 300, gallons: 2)
newRocket.liters // 7.56
newRocket.meters // 91.4

//Using the second init method, you may initialize the properties using ft and gallon. Yet, you've initalized the meters and liters properties by callingself.init.



print("\n Type property and Methods \n")


// Using Type property you're longer used to init object to access methods and properties.

// for Struct we use Static


struct MyTypeStruct{
    static var name = "M"
    
    static var compProperty: Int{
        get{
            return 10
        }
        set{
            print(newValue)
        }
    }
    
    static func hi(){ // class methods are only allowed within classes; use 'static' to declare a static method
        print("Hi")
    }
}


MyTypeStruct.compProperty
MyTypeStruct.name
MyTypeStruct.hi() // In the above examples notice that we didnt make any object for the struct. like MyTypeStruct()


// for Class we use Static & Class

/**
    So what's the difference of static and class.
        Static can't be overridden.
        Class can be overridden.
 */

class ABC{
    static func hiFunc(){
        print("hi")
    }
    
    class func helloFunc(){
        print("hello")
    }
    
    final func heyFunc(){
        print("hey")
    }
}

class DEF: ABC{
    override class func helloFunc(){
        print("hello Overridden")
    }
    
//    override func heyFunc(){
//        print("hey") // instance method overrides a 'final' instance method
//    }
    
//    override static func hiFunc(){
//        print("hi") // cannot override static method
//    }
}

struct MyConstants{
    struct nameConstants{
        static var name = "Riju"
    }
}

print(MyConstants.nameConstants.name) // Alternative way is enum, but in enum we use rawvalue so bettwr to use struct.



print("\n Singleton Pattern \n")



/**
    Singleton is an object which is used only used once.
 */

class MySingletonManager{
    static let sharedInstance = MySingletonManager()
    private init() {} // this private prevents the initialization outside the class.
    
    var managerDetails = (id: "abc", pass: 1234)
}

MySingletonManager.sharedInstance.managerDetails.id // Try to use less Singleton when you're in the team.

// UIApplication, UserDefaults, NSNotification are all singleton pattern. The iOS ecosystem often use the singleton pattern for developers to access the universal object.













