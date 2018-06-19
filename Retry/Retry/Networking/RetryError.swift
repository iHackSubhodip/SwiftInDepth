//
//  RetryError.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

enum RetryError: Error{
    
    case RetryFailed(Int)
    case Failed(Error)
    case NoData
    case RetryDelay(Double)
    
    var isTransient: Bool{
        switch self {
        case .RetryDelay:
            return false
        default:
            return true
        }
    }
    
}
