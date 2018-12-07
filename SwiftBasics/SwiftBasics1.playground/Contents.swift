//: Playground - noun: a place where people can play

import UIKit

/**
Rules:

 • Every variable in swift must be defined (Implicit/ Explicit)
 • The type can be inferred based on the value.
 • Every normal type should have value associated.
 
 Based on the rules, Swift is declared as a type safe language.
 
*/

// Explicit Type:

let myName: String = "Subh"

// Implicit type:

let myNickName = "Riju"

/**
let yourName // As per rule 1 it must be defined, so it will throw an error of "Type annotation missing pattern".
print(yourName)
*/

// Optional type allows you to storing nil value. Suppose you're fetching an photo of the user so sometimes it may not be present. for that kind of variable we declare variable as an Optional.

var myPhoto: String? = nil
var myCoverPhoto: String? = "https://..."

print(myPhoto ?? "")
print(myCoverPhoto ?? "")

/**
 Optional Rules:
 
    • Optional do not interact with each other.
    • Convert Optionals to normal type and use it, this is known as unwrapping.
 
 Optional Unwrapping:
 
    • Implicit unwrapping
    • Force unwrapping
 
 */

// Force unwrapping:

var myImage: String? = nil
//print(myImage!) It will crash, be very cautious before you unwrap any optional value forcefully.

// Implicit unwrapping:

if let myGivenImage = myImage{
    print(myGivenImage)
}else{
    print("There is a nil value")
}



/**
    Optional Chainings:
        Why do we see ? and ! when accessing methods and properties?
 
 Let's design a class over here.
 */


class Human{
    var nameHuman: String
    
    init(name: String) {
        self.nameHuman = name
    }
    
    func humanMethod(){
        print("My Name is \(nameHuman)")
    }
}

class Apartment{
    var human: Human?
}

var bangaloreApartment = Apartment()
bangaloreApartment.human = Human(name: "Subh")
bangaloreApartment.human?.humanMethod() // here ? automatically added to the end of human?. if human property is nil then bangaloreApartment.human?.humanMethod() can be nil.
// If you put ! after human property It means you're declaring human property as a non optional type. Like the following:

let humanName = bangaloreApartment.human!.nameHuman // here humanName is a String type with the non optional value. As ! is declares human property as non optional and it will exsists. If human is nil value, you can't forcefully unwrap it. This is called force unwrapping for the optional chaining.

// Implicit unwrapping // Safe unwrapping.

if let name = bangaloreApartment.human?.nameHuman{
    print("Name is \(name)")
}else{
    print("Name is not there")
}

/**
    Guard:
        • Guard only runs if the condition fails.
        • Guard provides early exits and fewer brackets.
        • It's better to convert else-if statement with guard.
 */


let myNameVisible = true

func checkVisiblity(){
    guard myNameVisible else{
        print("Not Visible")
        return
    }
    print("It is \(myNameVisible).")
}

checkVisiblity()


// Multiple optionals Unwrap with Guard and if-let

var myOptionalName: String? = "Riju"
var myNationality: String? = "Indian"
var myLanguage: String? = "Swift"

func checkWithIfLet(){
    if let name = myOptionalName, let nationality = myNationality, let language = myLanguage{
        print("My Name is \(name), nationality \(nationality), language \(language)")
    }else{
        print("Something is wrong.")
    }
}

checkWithIfLet()

func checkWithGuardLet(){
    guard let name = myOptionalName, let nationality = myNationality, let language = myLanguage else{
        print("Something is wrong.")
        return
    }
    print("My Name is \(name), nationality \(nationality), language \(language) with GuardLet")
}

checkWithGuardLet()
print("\nDefer Statement\n")

/**
    Defer:
        • It means, put off any action or event later.
 */


for i in 0...2{
    defer {
        print("deferred \(i)")
    }
    print("Current \(i)")
}

// try to avoid using defer, as it may create a confusion to your team.

/**
     Error Handling:
     • Error Handling is just additional way to write an else-if statement to not only deal with the error messages but also respond after them in a separate block.
*/

print("\nError Handling\n")

enum APIError: Error{
    case failed
    case noResponse
}

func parseAPI(statusCode: Int) throws {
    
    if statusCode == 200{
        print("Success")
    } else if statusCode == 400 {
        throw APIError.failed
    }else{
        throw APIError.noResponse
    }
}

do {
    try parseAPI(statusCode: 200)
} catch APIError.failed {
    print("failed")
} catch APIError.noResponse {
    print("no Response")
}


print("\nError Handling With Object")

enum StringError: Error{
    case stringError
}

class StringName{
    var stringName: String
    
    init(name: String) throws {
        if name.isEmpty{
            throw StringError.stringError
        }else{
            stringName = name
            print("Name Init with \(stringName)")
        }
    }
}

do{
    let myStirng = try StringName(name: "My String")
    print(myStirng)
} catch StringError.stringError{
    print("Name De - Init")
}

// try is only used with do catch block, try? and try! used without it.

/**
    try? returns an optional type
 */

let anotherString = try? StringName(name: "another String")

let nilString = try? StringName(name: "") // nil

/**
    try! returns an normal type, Be aware if the method throws error, it will crash.
 */

let normalOptionalString = try! StringName(name: "normal OptionalString") // returns normal type

//let nilOptionalString = try! StringName(name: "") // it will crash.


print("\nType Casting\n")


class ParentClass{
    func parentMethod(){
        print("I am the parent")
    }
}


class InheritedClass: ParentClass{
    func inheritedClassMethod(){
        print("I am the base class")
    }
}


let inheritedC = InheritedClass()
inheritedC.parentMethod()
inheritedC.inheritedClassMethod()

// Now upcast it. Upcasting means converting the object into the next top level.

let newInheritedC = inheritedC as ParentClass // so here the upcasting happens newInheritedC is now ParentClass type. So basically upcasting converts its type to the base class.

// Now downcast it. Downcasting is opposite to upcasting. It may be dangerous as it may not work.

// Downcasting is two types - Explicit/ Force downcasting.

var stringNum = "aa" as Any
var intNum = 0 as Any

var anyArray = [stringNum, intNum]

//Force downcasting.

let anArray = anyArray[1] as! Int
//let anArray = anyArray[0] as! Int // it will crash, as 0 th index is String not any.

//Explicit downcasting.

let anExplicitArray = anyArray[1] as? Int
let anExplicitIntArray = anyArray[0] as? Int // now it didnot crash as it's a safe downcasting.

//print(anExplicitIntArray) // if you forcefully unwrap it, it will lead to crash.

/**
    Up/Downcasting for Struct. As it doesn't support inheritance it will not happen.
 */
struct ABC{
    func abc(){
        print("a")
    }
}

struct DEF{
    func def(){
        print("def")
    }
}

let a = ABC()
//let k = a as DEF // it will compile time error.
//let b = a as? DEF // it will fail
//let c = a as! DEF // it will crash










