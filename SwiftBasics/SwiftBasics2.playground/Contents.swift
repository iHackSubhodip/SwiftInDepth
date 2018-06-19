//: Playground - noun: a place where people can play

import UIKit

print("Intro to Generics\n")

/**
    Generic:
        • Generic code enables you to write flexible, reuseable functions and types that can work with any type, subject to requirements that you define.
 */


let genericIntArray = [1, 2, 3, 4, 5]
let genericStringArray = ["A", "D", "E"]

func genericFunction<T>(array: [T]){
    for element in array{
        print(element)
    }
}

genericFunction(array: genericIntArray)
print("\n")
genericFunction(array: genericStringArray) // so here as the function is declared as Generics type, any type can be called.


// let's play with Generic Struct

struct GenericStruct<T>{
    var genericParam = [T]()
    
    mutating func genericMethod(arrayMember: T){
        genericParam.append(arrayMember)
    }
}

var genericStruct = GenericStruct(genericParam: genericIntArray) // now it became generic Int

var genericAnotherStruct = GenericStruct<Int>() // another type of way it is.
genericAnotherStruct.genericMethod(arrayMember: 5)


extension GenericStruct{
    var first: T?{
        if genericParam.isEmpty{
            return nil
        }else{
            return genericParam[0]
        }
    }
}

genericAnotherStruct.first


// Type Constraint

class First{
    
}

class Second: First{
    
}

class Third {}

let sec = Second()
let first = First()

func typeConstraint<T:First>(array: [T]){}


typeConstraint(array: [first, sec]) // sec is inherited so it will upcast automatically. and type constraint didn't fail as T support First()

//typeConstraint(array: [Third(), Third()]) // It will throw error as T is only for support First().



print("\n Subscripts \n")

/**
    Subscripts:
        • Get the number of rows in table/collection.
        • Anything has to do with pair and value.
 
 */

struct MyName{
    var names = ["Subhodip", "Riju"]
    
    subscript(index: Int) -> String{
        return names[index]
    }
}

var name = MyName()
name[0] // here's how subscript, it's kind of shortcut.


// for Dictionary

struct MyDictionary{
    var dictionaryValue = ["noOfBiscuits": 50, "noOfChocolates": 100]
    
    subscript(key: String) -> Int{
        if let newValue = dictionaryValue[key]{
            return newValue
        }else{
            return 0
        }
    }
}

let infoDictionary = MyDictionary()
let noOfBiscuits = infoDictionary["noOfBiscuits"]
print(noOfBiscuits)
let noOfChocolates = infoDictionary["noOfChocolates"]
print(noOfChocolates)
let noExistance = infoDictionary["noExistance"] // return 0
print(noExistance)



print("\n Structs VS Class \n")


class Human{
    var name: String
    init(name: String) {
        self.name = name
    }
}

var humanObject = Human(name: "Human")
print("Firstly before changing, it's \(humanObject.name)")

var newAnimalObject = humanObject
newAnimalObject.name = "Animal"

print("now after changing humanObject, it's \(humanObject.name)") // // here humanObject & newAnimalObject are pointing to the same class. which two are trying to lookup it's reference only.


struct HumanStruct{
    var name: String
}


var humanStruct = HumanStruct(name: "Human Struct")
var newHumanStruct = humanStruct
newHumanStruct.name = "new human Struct"
print("\(humanStruct.name), it will never change") // here humanStruct & newHumanStruct are two different object. which is copying the value into another.

// why it's happening because, Struct is value type and class is reference type.



//Mutability difference

class MutableClass{
    var name = "Mutable"
}

let classType = MutableClass()
classType.name = "Change Mutable" // although it's let constant still we can change it, it's allowing because we are not changing the class itself but changing the classType object.
print(classType.name)


struct MutableStruct{
    var name = "Mutable Struct"
}

let structType = MutableStruct()
//structType.name = "Change Mutable" // it's let constant so it will no allowed to change the value. object should be changed to mutable var and then you can change it's value and it's because of struct is value type. When changing struct object [as it's a copy] Swift compiler thinks that we are changing the value type.


/**
    Struct over classes:
        • Structs are faster than classes
        • no mutability due to relationship between objects
        • non nested structure
 */


print("\n Set and Tuple \n")


// Array declaration. Array is nothing but generic struct. // array, dictionary, string etc are generic string, which are value type.

var array1: [Double] = []
var array2 = [Double]()
var array3: Array<Double> = Array()
var array4: Array<Double> = []
var array5 = Array([1, 23, 4])
var array6 = Array(1...10)
var array7 = Array(repeatElement("A", count: 2))

/**
    A set stores value of the same type in the collection with no defined oredering and no duplicate elements.
 */

var set1: Set<Int> = [1, 5, 3, 1, 2, 3, 4, 1, 4, 6]
print(set1) // Output is unordered

var oddNumbers: [Int] = []
var evenNumbers: [Int] = []

for number in 1...50 {
    (number % 2 == 0) ? evenNumbers.append(number) : oddNumbers.append(number)
}

var oddNumberSet = Set(oddNumbers)
let evenNumberSet = Set(evenNumbers)

let sortedArray = evenNumberSet.sorted()
print(sortedArray)

/**
    Why Set:
        • Finding unique letters
        • Finding unique visitors
 */



/**
    Tuple:
        • Using Tuple you can combine multiple types of value into let/var.
        • It helps to work with all kind of data structures.
 */


var httpCode = (code: 200, description: "success")

print(httpCode.description)
print(httpCode)


var names = ["Riju", "Subhodip"]


for (index, value) in names.enumerated(){ // enumerated helps to create the array like tuple. 
    print(index, value)
    
}
 
 
print("\n Extensions \n")

struct ExtensionStruct{
    var name = "Extension Struct" // stored properties, it's with equal sign
}

extension ExtensionStruct{
    var anotherName: String{
        let prevName = self.name // self means the object ExtensionStruct()
        return "my prevName \(prevName)"
    } // computed property, in extension you can't declare a stored property
}


/**
    Rules:
        • extension of Struct may not have a stored property
        • Add computed instance/type properties
        • provide new init
        • define subscript
        • define and use nested type with enum/struct
        • Make an exsisting time and conform to a protocol
 */


print("\n Operator \n")

let mySuccess = true

mySuccess ? print("Success") : print("fail")


var even: [Int] = []
var odd: [Int] = []

for i in 1...6{
    (i % 2) == 0 ? even.append(i) : odd.append(i) // write less produce more.
}

print(even)
print(odd)


print("\n TypeAlias \n")

typealias Name = String


func myName(name: Name){ // passing typeAlias, it's basically a fake name for anything
    print(name)
}

myName(name: "R")


class Names {}

typealias NamesClass = Names

func passNames(array: NamesClass){
    //print(array)
}

passNames(array: Names())


typealias TupleType = (Int, String)

func tupleFunc(type: TupleType){
    type.0
    type.1
}

tupleFunc(type: (1, "U"))

//array declare - Generic struct

var arr1: [Int] = [1, 2]
var arr2: Array<Int> = [3, 4]

// Dictionary - Generic Struct

var dict1: Dictionary<String, Int> = ["A": 1, "N": 1]
var dict2: [String : Int] = ["A": 1, "N": 1]


// Optional - Generic Enum

var myOptional: String?
var myOptional2: Optional<String>

































