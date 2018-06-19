//: Playground - noun: a place where people can play

import UIKit

var myClosure: [() -> Void] = []

func myClousreFunction(closure: @escaping () -> Void){
  myClosure.append(closure) // If we append the closure block the function should be escaping
  
  print("Closure Done")
}

func networkingClosure(closure: @escaping () -> Void){ // this closure block will not be deallocated from the RAM, by that time function returns. If there is an escaping watch out for memory management.
  DispatchQueue.global().async {
    closure() // this closure will run asynchronously after the function execution is done. So that's why @escaping added.
  }
  print("Closure execution is done.")
}

networkingClosure {
  for _ in 1...2 {
    print("Networking ...")
  }
}

// As it's async it will execute on the background thread, in the ouptput you can see as it's escaping closure, print statement executed first and then later print statement in the closure block got executed.

class NormalClosure{
  let className = "NormalClosure"
  
  func normalClosure(closure: (String) -> Void){ //this closure block will be deallocated from the RAM, by that time function returns, so it's non-escaping, by default function/closures are non escaping.
    closure(self.className)
    //closure(self.className) it also works without self.
  }
}

/* Benefits of non-escaping
  1. There is no retain cycle for non-escaping function/closures.
  2. use self it will not create any memory leak
*/

// Auto Closure

func simpleClosure(simpleClosureBoolType: () -> Bool){
  if simpleClosureBoolType(){
    print(" simpleClosure true")
  }
}

simpleClosure(simpleClosureBoolType: { return true })
simpleClosure(simpleClosureBoolType: { true })
simpleClosure { true }

func autoClosure(autoClosureBool: @autoclosure () -> Bool){
  if autoClosureBool(){
    print(" ------------------autoClosureBool true----------------")
  }
}

autoClosure(autoClosureBool: true)
// here you're not writing of any closure only simply returning true.
// if declare any property as lazy there will be no retain cycle. Lazy var is non-escaping type by default.









