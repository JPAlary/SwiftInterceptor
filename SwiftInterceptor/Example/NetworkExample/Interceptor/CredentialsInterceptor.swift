//
//  CredentialsInterceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

struct CredentialsInterceptor: Interceptor {
    
    enum Key {
        static let accessToken = "access_token"
    }
    
    func intercept(chain: InterceptorChain<URLRequest, Response>, completion: (Response) -> Void) {
        
        /* Note:
            The token value can be retrieve from storage or from an api call.
            As the chaining is asynchronous, you can check in this interceptor if you need to:
                - GET a token
                - refresh it
            and wait a response and `proceed` the chaining.
         
            In this example, I just add a simple string value but don't hesitate to handle your
            different credentials with an interceptor !
         */
        
        defer {
            chain.proceed(completion: completion)
        }
        
        var request = chain.input
        
        guard let url = request.url?.absoluteString else {
            return
        }
        
        let separator = url.contains("?") ? "&" : "?"
        
        guard let finalURL = URL(string: url + separator + Key.accessToken + "=" + "some_value") else {
            return
        }
        
        request.url = finalURL
        chain.input = request
    }
}
