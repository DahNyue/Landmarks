//
//  BaseService.swift
//  SKPlastic
//
//  Created by ChulHyun Jun on 2022/06/09.
//

import Foundation
import Alamofire

class BaseService {
    lazy var session : Session = {
        let configuration = URLSessionConfiguration.af.default
        // request Timeout
        configuration.timeoutIntervalForRequest = 30
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return Session(configuration: configuration)
    }()
  
    let queue = DispatchQueue(label: "network.queue", qos: .background, attributes: .concurrent)
}
