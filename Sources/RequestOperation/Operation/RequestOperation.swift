//
//  RequestOperation.swift
//  request-operation-ios
//
//  Created by Levi Eggert on 1/3/2022.
//  Copyright © 2020 Cru. All rights reserved.
//

import Foundation

open class RequestOperation: Operation {
    
    public typealias Completion = ((_ response: RequestResponse) -> Void)
    
    enum ObserverKey: String {
        case isExecuting = "isExecuting"
        case isFinshed = "isFinished"
    }
    
    enum State {
        case executing
        case finished
        case notStarted
    }
    
    private let errorDomain: String = String(describing: RequestOperation.self)
    
    private var task: URLSessionDataTask?
    private var completion: Completion?
    
    private(set) var urlRequest: URLRequest
    
    public let session: URLSession
    
    public init(session: URLSession, urlRequest: URLRequest) {
        self.session = session
        self.urlRequest = urlRequest
        super.init()
    }
    
    public func setUrlRequestHeader(httpHeaderField: String, value: String) {
        urlRequest.setValue(value, forHTTPHeaderField: httpHeaderField)
    }
    
    public func setCompletionHandler(completion: @escaping Completion) {
        self.completion = completion
    }
    
    open override func start() {
        
        guard !isCancelled else {
            handleOperationCancelled()
            return
        }
        
        task = session.dataTask(with: urlRequest) { [weak self] (data: Data?, urlResponse: URLResponse?, error: Error?) in
            
            self?.completeOperation(data: data, urlResponse: urlResponse, requestError: error)
        }
        
        task?.resume()
        state = .executing
    }
    
    open override func cancel() {
        super.cancel()
        task?.cancel()
    }
    
    open func completeOperation(data: Data?, urlResponse: URLResponse?, requestError: Error?) {
        
        state = .finished
        
        let response = RequestResponse(
            urlRequest: urlRequest,
            data: data,
            urlResponse: urlResponse,
            requestError: requestError
        )
        
        completion?(response)
    }
    
    private func handleOperationCancelled() {
        
        let cancelledError: Error = NSError(
            domain: errorDomain,
            code: NSURLErrorCancelled,
            userInfo: [NSLocalizedDescriptionKey: "The operation was cancelled."]
        )
        
        completeOperation(data: nil, urlResponse: nil, requestError: cancelledError)
    }

    // MARK: - State
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished
    }
    
    private var state: State = .notStarted {
        willSet (value) {
            switch value {
            case .executing:
                willChangeValue(forKey: ObserverKey.isExecuting.rawValue)
            case .finished:
                willChangeValue(forKey: ObserverKey.isFinshed.rawValue)
            case .notStarted:
                break
            }
        }
        didSet {
            switch state {
            case .executing:
                didChangeValue(forKey: ObserverKey.isExecuting.rawValue)
            case .finished:
                didChangeValue(forKey: ObserverKey.isFinshed.rawValue)
            case .notStarted:
                break
            }
        }
    }
}
