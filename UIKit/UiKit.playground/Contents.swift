//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



let tableView = UITableView()
class ABC {}

//UITableView is a subclass of UIScrollView. It allows vertical scrolling only.
//UITableView caches table-view cells for visible rows.
//dequeueReusableCell(withIdentifier:) -> This method dequeues the exsisting cell if it's available or creates new one using the class or nib file previously registered. if no cell is available for reuse and you don't register any class or nib file, it returns nil.
//if any cell is available for reuse then it calls the prepareForReuse() method.
//The table view's delegate in tableView(_:cellForRowAt:) should always reset all content when reusing a cell.

let cache = NSCache<NSString, ABC>()
let myObject: ABC

if let cachedObject = cache.object(forKey: "myKey"){
    myObject = cachedObject
}else{
    myObject = ABC()
    cache.setObject(myObject, forKey: "myKey")
}
//Deque allows insert and delete at both ends. It supports both stack and queue operation.
// A regular queue add elements to the back and removes from the front.
// Deque Implementation.

public struct Deque<T>{
    private var array = [T]()
    
    public var isEmpty: Bool{
        return array.isEmpty
    }
    
    public var count: Int{
        return array.count
    }
    
    public mutating func enque(_ element: T){
        array.append(element)
    }
    
    public mutating func enqueFront(_ element: T){
        array.insert(element, at: 0)
    }
    
    public mutating func deque() -> T?{
        if isEmpty{
            return nil
        }else{
            return array.removeFirst()
        }
    }
    
    public mutating func dequeBack() -> T?{
        if isEmpty{
            return nil
        }else{
            return array.removeLast()
        }
    }
    
    public func peekFront() -> T?{
        return array.first
    }
    
    public func peekLast() -> T?{
        return array.last
    }
}


//var deque = Deque<Int>()
//deque.enque(1)
//deque.enque(2)
//deque.enque(3)
//deque.enque(4)
//
//deque.enqueFront(5)
//print(deque)
//deque.deque()
//print(deque)
//deque.dequeBack()
//print(deque)
//deque.peekFront()
//print(deque)


/**
 The main advantage to collectionview is to scroll horizontally as well as vertically.
 if you have multiple columns in the row it's best to have collectionview, it's possible with tableview also, but that's messy.
 Collectionview you can design any complex layout. you have UICollectionViewDelegateFlowLayout.
 It supports custom animation based on different layouts which can't be done with Tableview.
 It supports drag and drop feature.
 
 Main disadvantage is auto sizing of the cells. In tableview sets UITableViewAutomaticDimensions.
 */

print("")

let scroll = UIScrollView()

/**
    Implementing a Scrollview.
 
        We need to take UIGestureRecognizer on the top of UIView.
            For Dragging we will use panGestureRecognizer[UIPanGestureRecognizer]
            For zooming we will use pinchGestureRecognizer[UIPinchGestureRecognizer], both are subclass of UIGestureRecognizer.
 */











































