//
//  ViewController.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let task = FailableRetryURlManager(url: URL(string: "https://500-error-code-url")!, body: [:], request: .POST)
        
        task.retryCount(count: 3, successCompletion: { (data) in
            print(data)
        }) { (error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

