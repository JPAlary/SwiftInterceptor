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
    func send(request: URLRequest, completion: @escaping (HTTPClientResult) -> Void) -> Void
}

final class MyHTTPClient: HTTPClient {
    private let requestChain: InterceptorChain<URLRequest>
    private let responseChain: InterceptorChain<Response>
    
    // MARK: Initializer
    
    convenience init() {
        let requestChain = InterceptorChain<URLRequest>()
            .add(interceptor: AnyInterceptor(base: CredentialsInterceptor()))
            .add(interceptor: AnyInterceptor(base: AddLocaleInterceptor()))
        
        self.init(
            requestChain: requestChain,
            responseChain: InterceptorChain<Response>()
        )
    }
    
    init(
        requestChain: InterceptorChain<URLRequest>,
        responseChain: InterceptorChain<Response>
    ) {
        self.requestChain = requestChain
        self.responseChain = responseChain
    }
    
    // MARK: HTTPClient
    
    func send(request: URLRequest, completion: @escaping (HTTPClientResult) -> Void) {
        requestChain.proceed(object: request) { [weak self] (request) in
            
            // You should send the request and do this code when you have the response. For the example, I directly
            // chain a fake Response.
            
            self?.responseChain.proceed(object: Response(requestUrl: request.url!.absoluteString), completion: { (response) in
                completion(.success(response))
            })
        }
    }
}
