//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groupA()
        groupB()
        dispatchGroup.notify(queue: .main) {
            print("All done")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func abc(a: Int, b: Int, completion: @escaping (Bool) -> Void){
        completion(true)
    }
    
    func def(d: Int, f: Int, completion: @escaping (Int) -> Void){
        completion(d*f)
    }
    
    func groupA(){
        dispatchGroup.enter()
        abc(a: 2, b: 3) { (isSuccess) in
            print(isSuccess)
            self.dispatchGroup.leave()
        }
    }
    
    func groupB(){
        dispatchGroup.enter()
        def(d: 2, f: 3) { (num1) in
            print(num1)
            self.dispatchGroup.leave()
        }
    }
    
}

