//
//  RetryNetworkManager.swift
//  Retry
//
//  Created by Banerjee, Subhodip on 28/04/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

enum NetworkRequest: String{
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


class FailableRetryURlManager: RetryTaskProtocol{
    private var url: URL
    private var bodyDictionary: [String: Any]
    private var requestType: NetworkRequest
    
    init(url: URL, body: [String: Any], request: NetworkRequest) {
        self.url = url
        self.bodyDictionary = body
        self.requestType = request
    }
    
    
    func run(completion: @escaping RetryProtocolExcutionCompletion) {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.requestType.rawValue
        let body = self.requestType == .DELETE ? [:] : self.bodyDictionary
        guard let data = getJsonFromDictionary(jsonDict: body) else { return }
        urlRequest.httpBody = data
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data, error == nil{
                completion(RetryResult(successValue: data))
            }else if let error = error {
                print(error)
                completion(RetryResult(errorValue: RetryError.RetryDelay(0.1)))
            } else{
                completion(RetryResult(errorValue: RetryError.NoData))
            }
        }
        session.resume()
    }
    
    func getJsonFromDictionary(jsonDict httpBody: [String: Any]?) -> Data?{
        var bodyData: Data? = nil
        if let body = httpBody{
            bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        return bodyData
    }
}


