//
//  HTTPClient.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

enum HTTPClientResult {
    case success(Response)
    case error(Error)
    case networkError(Error)
}

protocol HTTPClient {
    func send(request: URLRequest, completion: (HTTPClientResult) -> Void) -> Void
}

class MyHTTPClient: HTTPClient {
    private let requestor: FakeRequestor
    
    // MARK: Initiializer
    
    init(requestor: FakeRequestor) {
        self.requestor = requestor
    }
    
    func send(request: URLRequest, completion: (HTTPClientResult) -> Void) {
        let chain = InterceptorChain(listener: AnyChainListener(base: requestor), input: request)
            .add(interceptor: AnyInterceptor(base: CredentialsInterceptor()))
            .add(interceptor: AnyInterceptor(base: AddLocaleInterceptor()))
        
        chain.proceed { (response) in
            completion(.success(response))
        }
    }
}
