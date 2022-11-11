//
//  APIInterceptor.swift
//  SKPlastic
//
//  Created by ChulHyun Jun on 2022/06/09.
//

import Foundation
import Alamofire

class APIInterceptor: RequestInterceptor {
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 1 else {
            print("API Retry Limited")
            completion(.doNotRetry)
            return
        }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 500 {
            print("API Retry 500 Error")
            completion(.retryWithDelay(0.5))
            return
        }
        
        completion(.doNotRetry)
    }
}
