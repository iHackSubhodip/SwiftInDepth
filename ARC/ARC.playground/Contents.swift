//: Playground - noun: a place where people can play

import UIKit

class Developer{
  var project: Project?
  let name: String
  
  init(name: String) {
    self.name = name
    print("Developer \(name) adapted.")
  }
  
  deinit {
    print("Developer \(name) De-Init")
  }
}

class Project{
  //var developer: Developer?
  weak var developer: Developer?
  let projectName: String
  
  init(projectName: String) {
    self.projectName = projectName
    print("The Project Name \(projectName)")
  }
  
  deinit {
    print("The Project Name \(projectName) De-Init")
  }
}

// Now create instance of these above two classes.

var developer: Developer? = Developer(name: "Riju")
var project: Project? = Project(projectName: "My Xcode Project")

// <----- Above, allocation done and reference for the both class are also created. It's a strong reference [Retain count for Developer & Project class is = 1]

// Deallocate

developer = nil
project = nil

// <---- Above, we are removing the reference of the created instances. So, Retain count for Developer & Project class is = 0

// Another Important point to remeber, we are removing the relationships, not the object.

/*
 Developer(name: "Riju") // For this line there is no reference, so as soon as the allocation done, dealloc will be called instantly.
*/

/*
  -----------======================= Now create inter realtion between objects =======================---------------------
 */
print("\n-----------======================= Now create inter realtion between objects =======================--------------------- \n")

var anotherDeveloper: Developer? = Developer(name: "Subhodip")
var anotherProject: Project? = Project(projectName: "My another Xcode Project")

anotherDeveloper?.project = anotherProject
anotherProject?.developer = anotherDeveloper // interconnection done

/*
  Now it looks like - anotherDeveloper ---------------> Developer (var project: Project?) // Here Class has 2 ref counting
                                                                    |     |
                                                                    |     |     // HERE internally cross strong ref.
                                                                    |     |
                      anotherProject   ---------------> Project   (var developer: Developer?) // Here Class has 2 ref counting
*/

// Now deallocate

anotherDeveloper = nil
anotherProject = nil


/*
 setting nil we are breaking the relationship of the objects, but internally cross strong ref still remains so both class are not deallocated. So here comes into the picture the weak Property.
 
 Now it looks like - anotherDeveloper xxbreakxxxxxxx-> Developer (var project: Project?) // Here Class has 2 ref counting
                                                                    |     |
                                                                    |     |     // HERE internally cross strong ref.
                                                                    |     |
                      anotherProject  xxxbreakxxxxxx-> Project   (var developer: Developer?) // Here Class has 2 ref counting
 */

// Now we can declare one property of the class as weak.
// So the property will not increase the reference count for that class, so it will be 0 ref. count.
// By default every property creates a strong reference. and count increase + 1
// enable line no 20 //var developer: Developer?, disable line no 22 to see the above magic of retain cycle

/*
 Now it looks like - anotherDeveloper xxxbreakxnilxx-> Developer (var project: Project?), now Class has 0 ref counting and class deallocated
                                                                     |     |
                                                                  weak     class deallocated, so reference removed
                                                                     |     |
                     anotherProject  xxxbreakxnilxx-> Project   (var developer: Developer?) // Here Class has 0 ref counting
 */




















