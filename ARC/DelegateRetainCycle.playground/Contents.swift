//: Playground - noun: a place where people can play

import UIKit

protocol SendDelegate: class {} // IF you're using a weak and that conforms to the protocol class, then you have to use : class, otherwise you receive error. "weak may only be applied to class and class bound protocol types."


// Delegate sender
class DelegateSender {
  //var delegate: SendDelegate?
  weak var delegate: SendDelegate?
  
  deinit {
    print("DelegateSender Gone")
  }
}


// Delegate receiver
class DelegateReceiver: SendDelegate{
  lazy var delegateSender: DelegateSender = { // It's lazy. why? Because, lazy allows since the property is initialized only after self has created.
    let vc = DelegateSender()
    vc.delegate = self // if you remove lazy, there will be an error as property has not initialized.
    return vc
  }()
  
  deinit {
    print("DelegateReceiver Gone")
  }
  
}

//now create instance

var receiverDelegate: DelegateReceiver? = DelegateReceiver()
//access the lazy property and born it into the memory, if you don't access the property will not initialize
receiverDelegate?.delegateSender
receiverDelegate = nil



// now lazily born in above, and retain cycle happened

/*
 it looks like ->
 
 receiverDelegate --------> DelegateReceiver() (lazy var delegateSender)
                              |   | // retain cycle as inside there are reference
                            DelegateSender()    (var delegate)
 
*/

// now if make the instance nil, it will remove the reference of the instance, but inside both class there will be retain cycle.

 // so deallocation will not happen now, as there is a retain cycle created

// So, how can I deaalocate???????

/*
 So,  1.we will make the delegate of the DelegateSender as weak. So var delegate is pointing weak reference to DelegateReceiver.
 2. As soon as receiverDelegate = nil, DelegateReceiver will be deallocated and as var delegate is weak, as DelegateReceiver deallocated DelegateSender now have no reference. As a result DelegateSender will be deallocated and retain cycle will be removed
 3. Uncomment line no 9 and comment line no 10 to see this magic
 
*/

// Important remember ARC applies to reference types, not the value types like struct and enum [value types are the direct storage, not to worry about for weak when it is value types.]

// A weak reference allows the referencing object to becoming nil
// Referencing object must be optional.









