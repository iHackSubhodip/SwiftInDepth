//: Playground - noun: a place where people can play

import UIKit


class ClosureRetainCycle{
  var classClosure: (() -> ())?
/* this classClosure has reference to the property {
  print("Class Closure") - so it have the different memory location
}
*/
  var className: String = "Closure"
  
  init() {
    classClosure = { [weak self] in
     // print("\(self.className) Class") // Now we declared self.className, so the closure block has reference to self. See point 2
      //print("\(self?.className) Class") // Weak reference is an optional type, so there will be two values either some or nil
      //as it's weak self capture list, so self become optional
      guard let object = self else{
        return
      }
      print("\(object.className) Class") // Weak reference is an optional type, so there will be two values either some or nil
    }
  }
  
  deinit {
    print("De Init Class")
  }
}

var closureClass: ClosureRetainCycle? = ClosureRetainCycle() // closureClass has reference to ClosureRetainCycle Object
closureClass?.classClosure?()
closureClass = nil

/* It looks like -
 
 closureClass --has Reference--------> ClosureRetainCycle(Retain count 1) (classClosure ---has Reference----------> {print("Class Closure") = (Retain count 1)} )
 
 */

/* Point 2 looks like
 
    closureClass --has Reference--------> ClosureRetainCycle(Retain count 1)
 
    (classClosure [ClosureRetainCycle Class]---has Reference----------> {print("Class Closure")} )
    {print("Class Closure")}[ClosureRetainCycle Class] ---has Reference----------> var className [ClosureRetainCycle Class]
    remove [weak self] and uncomment line 16 and comment other lines in the closure to see the magic.
 So here's the retain cycle , ClosureRetainCycle Class deinit didnt get called, SO What's next?
 */

// Swift Engg. are designed like a way, that everything inside a closure block must be self. As It can create a retain cycle inside, so be careful before using self over closure block.



/*
 
 classClosure = { [unowned self] in // what the hack unowned???????

 print("\(self.className) Class") // As it's unowned self is not optional right now
 }
 
 //if you declare that closure as unowned, you have to be 100% sure that the ClosureRetainCycle class must exist.
 // If sure then use unowned, otherwise it will crash if the class doesn't exist.
 //It is safer to use weak
 */

print("\n======================= =======================UnOwned EX==============================================\n")

class Employer{
  var employeeType: Employee?
  deinit {
    print("Employer De Init")
  }
}

class Employee{
  unowned let employer: Employer
  init(employerE: Employer) {
    employer = employerE
  }
  deinit {
    print("Employee De Init")
  }
}

var employer: Employer? = Employer()
var employee: Employee? = Employee(employerE: employer!)

employer?.employeeType = employee

employer = nil // So Employer De init , now try to access employer property of Employee class
//employee?.employer // It will crash as employer property is unowned and it can't be nil. Line number 91 relationship is already broken, so in line 92 it will try to access , so it will crash.
// try to use weak as it is safer. when using unowned you never know when the properties got deallocated.
// So use wisely for unowned.





























