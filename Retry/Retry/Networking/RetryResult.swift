//
//  RetryResult.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

public protocol RetryResultProtocol{
    associatedtype SuccessValue
    associatedtype ErrorValue
    
    init(successValue: SuccessValue)
    init(errorValue: ErrorValue)
}

public enum RetryResult<T, ErrorValue>: RetryResultProtocol{
    
    case Success(T)
    case Error(ErrorValue)
    
    public init(errorValue: ErrorValue) {
       self = .Error(errorValue)
    }
    
    public init(successValue: T) {
        self = .Success(successValue)
    }
}

