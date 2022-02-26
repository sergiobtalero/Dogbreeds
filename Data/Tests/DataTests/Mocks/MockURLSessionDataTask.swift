//
//  MockURLSessionDataTask.swift
//  
//
//  Created by Sergio Bravo on 26/02/22.
//

import Foundation

public final class MockURLSessionDataTask: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    public override init() {}
    
    public override func resume() {
        completionHandler?(taskResponse?.0, taskResponse?.1, taskResponse?.2)
    }
}
