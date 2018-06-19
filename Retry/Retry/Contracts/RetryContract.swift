//
//  RetryContract.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

typealias RetryProtocolExcutionCompletion = (RetryResult<Data, RetryError>) -> Void


protocol RetryTaskProtocol{
    func run(completion: @escaping RetryProtocolExcutionCompletion) -> Void
}

extension RetryTaskProtocol{
    func retryCount(count: Int, successCompletion: @escaping (Data) -> Void, failureCompletion: @escaping (Error) -> Void){
        let retryResultManager = RetryManager(retryCount: count, success: successCompletion, error: failureCompletion)
        retryResultManager.runRetry(transientTask: self)
    }
}

