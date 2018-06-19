//: Playground - noun: a place where people can play

import UIKit

/**
        Why Protocols?
                • When you subclass, you have to inherit properties and methods which you may not need. The Object become unnecessarily bloated.
                • When you make a lot of super class, it's become tough to navigate b/w all the super classes and work.
                • since objects are referring the same place in memory, if you make a copy and create a small change in it's property, it can mess up.
 
        What's this?
                • Protocol provides a set of rules. you can consider it as a cricket team coach. who instructs all the rules.
 
 */


protocol MyProtocol{
    var myName: String { get set }
    func hi()
}

protocol MyInheritedProtcol: MyProtocol{
    var inheritedName: String { get set }
    func hello()
}

struct MyStruct: MyInheritedProtcol{
    var inheritedName: String
    var myName: String
    
    func hello() {
        print("hello")
    }
    
    func hi() {
        print("hi")
    }
    
}

// { get set } is only applicable for computed property.

/**
    Rule:
        • When you set the requirement as { get } you may make the property gettable or settable. If it is defined as { get set }, you must define the property as settable.
 */

print("Protocol extension\n")

protocol FindSquare{
    func findSquare(number: Int) -> Int
}

extension FindSquare{
    func findSquare(number: Int) -> Int{
        return number * number
    }
}


class AreaClass: FindSquare {} // no need to conform protocol as it's there protocol extension.

print(AreaClass().findSquare(number: 12))


print("\nProtocol as type")

protocol ProtocolType{
    var myType: Bool { get }
    var myAnotherType: String { get }
}

extension ProtocolType{
    //var myType = true // extension protocol may not contain stored property
    
    var myType: Bool {
        return true
    }
}

struct MyStruct1: ProtocolType{
    var myAnotherType: String = "1"
}
struct MyStruct2: ProtocolType{
    var myAnotherType: String = "2"
}
struct MyStruct3: ProtocolType{
    var myAnotherType: String = "3"
}


let protocolAsAType: [ProtocolType] = [MyStruct1(), MyStruct2(), MyStruct3()]

for aType in protocolAsAType{
    print("Type is \(aType.myAnotherType)")
}


// protocol as generic type

protocol MyTypeProtocol{
    var myType: String { get }
}

struct MyTypeStruct: MyTypeProtocol{
    var myType: String = "Struct type"
}

func typeProtocol<T: MyTypeProtocol>(enterType: T){
    print(enterType.myType)
}

typeProtocol(enterType: MyTypeStruct())

print("\nDelegate Pattern")

/**
        Delegate used to communicate/pass data between objects.
 */

protocol DelegateProtocol: class{
    func passData(name: String)
}

class SenderClass{
    weak var delegate: DelegateProtocol?
}

class ReceiverClass: DelegateProtocol{
    
    func passData(name: String) {
        print("It's \(name)")
    }
}

let rcVC = ReceiverClass()
let sVC = SenderClass()
sVC.delegate = rcVC
sVC.delegate?.passData(name: "A") // Delegated to the ReceiverClass()


print("\nData Source")

// Data source provides one directional(backward) communication pattern, If we declare as CEO - Secretary relation, delegate means ceo asks to Secretary and in return datasource, secretary gives the data to CEO.


print("\nGeneric Protocols")

// Design Generic Struct

struct GenericStruct<T>{
    var property: T?
}

let gStruct = GenericStruct<Int>() // explicitly

let gImplicitStruct = GenericStruct(property: true) // implicit

// Design Generic protocols

protocol GenericProtocol{
    associatedtype myType
    var genericType: myType {get} // in generic protocol we have to declare as associatedtype.
}

struct FirstStruct: GenericProtocol{
    var genericType = true // whereever it conforms you can declare it as your wish as it's generic type
}

struct SecondStruct: GenericProtocol{
    var genericType = "true"
}

struct ThirdStruct: GenericProtocol{
    typealias myType = Int // another way using typealias.
    var genericType = 0
}

extension GenericProtocol where Self == FirstStruct{
    func hi(){
        print("hi")
    }
}

FirstStruct.hi(FirstStruct())

protocol OverrideAssociatedType{
    associatedtype myAnotherType = Int
    var familyMembers: [myAnotherType] { get set }
}

struct StructOne<T>: OverrideAssociatedType{
    
    //typealias myAnotherType = String //overriding done.
    var familyMembers: [T] // changed to type T
    
}

print("\n Type Eraser")

// Design FileType
struct Folder {}
struct Cell {}

// Design Protocol
protocol Listable {
    associatedtype FileType
    func getFileType() -> String
}

// Design Classes
class FolderCell: Listable {
    typealias FileType = Folder
    func getFileType() -> String {
        return "FolderCell with \(FileType.self) type"
    }
}

class CollectionCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "CollectionCell with \(FileType.self) type"
    }
}

class ListCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "ListCell with \(FileType.self) type"
    }
}

// Any is a wrapper which contains string, int, double etc.
//let cell: Listable = CollectionCell() //protocol 'Listable' can only be used as a generic constraint because it has Self or associated type requirements
// to acheive protocol pitfalls we will design wrapper class.


class AnyCell<T>: Listable{
    typealias FileType = T
    private let _getFileType: () -> String
    init<U:Listable>(_ enterCell: U) where U.FileType == T {
        _getFileType = enterCell.getFileType
    }
    func getFileType() -> String {
        return _getFileType()
    }
}

//class AnyCell<T>: Listable {
//    typealias FileType = T
//
//    private let _getFileType: () -> String
//
//    init<U: Listable>(_ enterAnyCell: U) where U.FileType == T {
//        // T defined based on U
//        _getFileType = enterAnyCell.getFileType
//    }
//
//    func getFileType() -> String {
//        return _getFileType()
//    }
//}

let collectionCell: AnyCell = AnyCell(CollectionCell())
print("\n")
print("Type Erasing: Erase Abstract Type (associatetype, T) to Concrete Type (String, Int, File, Cell)")




































