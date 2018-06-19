//: Playground - noun: a place where people can play

import UIKit

/**
    GCD is a C-Based low level API for managing concurrent operations. It helps to improve performence of the Application and adding to the point it will make your application smooth and responsive. We use GCD to do multiple task at the same time. Moreover, it managed tasks into first in first out order.
 */


/**
    There are three purposes task execution into the DispatchQueue.
 
        • Concurrent: The tasks added to the queue, are executed concurrently. how many task will execute that depends on the System core services. it's not guranteed whichever task added in which the order, in same order the task will be executed.[Global Dispatch Queue]
        • Serial: It's executing one task at a time. execute one task at a time in which they are added to the queue. [Private dispatch Queue]
 
        • Main: Main dispatch queue are globally available serial queue that executes on applications main thread. The queue runs with the applications run loop to interleave the execution of the queued tasks.
 */


/** Two types of execution of the task. Synchronous and Asynchronous.

            • Sync - The program waits until the execution finishes before the method call returns.
            • Async - The method call returns immediately.
*/


func syncTask(){
    let queue1 = DispatchQueue(label: "queue1")
    let queue2 = DispatchQueue(label: "queue2")
    
    queue1.sync {
        for number in 1...3 { print("queue1 \(number)")}
    }
    
    queue2.sync {
        for numbers in 1...3 { print("queue2 \(numbers)")}
    }
}

syncTask()

print("")

func asyncTask(){
    let queue3 = DispatchQueue(label: "queue3")
    let queue4 = DispatchQueue(label: "queue4")
    
    queue3.async {
        for numberd in 1...3 { print("queue3 \(numberd)")}
    }
    
    queue4.async {
        for numbersd in 1...3 { print("queue4 \(numbersd)")}
    }
}

asyncTask()

/**
        • In Main queue we update the UI related tasks and
        • In background we do the non UI related work.
 */

DispatchQueue.global(qos: .background).async {
    //do the background task
    DispatchQueue.main.async {
        // do the UI update
    }
}

DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    // DispatchQueue with delay.
}

/**
        Dispatch groups are the way to block a thread until one or more tasks finish executing.
        Use this behaviour in places where you can't make a progress until all of the specified tasks are complete.
 */

let dispatchGroup = DispatchGroup()

func abc(a: Int, b: Int, completion: @escaping () -> Void) -> Int{
    return a + b
}

func def(d: Int, f: Int, completion: @escaping () -> Void) -> Int{
    return d * f
}

func groupA(){
    dispatchGroup.enter()
    abc(a: 2, b: 3) {
        dispatchGroup.leave()
    }
}

func groupB(){
    dispatchGroup.enter()
    def(d: 2, f: 3) {
        print("d")
        dispatchGroup.leave()
    }
}

groupA()
groupB()

dispatchGroup.notify(queue: DispatchQueue.main) {
    print("All done")
}
print("a")







func mergeSorted<T:Comparable>(_ x: [T], _ y: [T], inOrder cmp: (T, T) -> Bool = (<) ) -> [T] {
    var z = [T]()
    var i = 0, j = 0
    while i < x.count || j < y.count {
        if j == y.count || cmp(x[i], y[j]) {
            z.append(x[i])
            print(z)
            i += 1
        } else {
            z.append(y[j])
            j += 1
        }
    }
    return z
}

let a, b: [Int]
a = [3,5,7,20,21]
// a = [5,3]
b = [1,7,9,11]
// b = [4]
print(mergeSorted(a,b))












