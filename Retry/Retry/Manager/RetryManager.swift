//
//  RetryManager.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation


class RetryManager{
    private let retryCount: Int
    var currentCount = 0
    private let successBlock: (Data) -> Void
    private let failureBlock: (Error) -> Void
    
    init(retryCount: Int, success: @escaping (Data) -> Void, error: @escaping (Error) -> Void) {
        self.retryCount = retryCount
        self.successBlock = success
        self.failureBlock = error
    }
    
    func runRetry(transientTask: RetryTaskProtocol){
        transientTask.run { (result) -> Void in
            switch (result){
            case .Success(let value):
                self.successBlock(value)
            case .Error(let error):
                if error.isTransient{
                    self.failureBlock(error)
                } else if ((self.currentCount + 1) > self.retryCount){
                    self.currentCount += 1
                    self.failureBlock(RetryError.RetryFailed(self.currentCount))
                }else{
                    print("retry")
                    self.currentCount += 1
                    self.runRetry(transientTask: transientTask)
                }
            }
        }
    }
}



