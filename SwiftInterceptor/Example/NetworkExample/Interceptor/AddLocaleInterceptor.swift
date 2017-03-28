//
//  AddLocaleInterceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

struct AddLocaleInterceptor: Interceptor {
    enum Key {
        static let locale = "locale"
    }
    
    // MARK: Interceptor
    
    func intercept(chain: InterceptorChain<URLRequest>, completion: (URLRequest) -> Void) {
        defer {
            chain.proceed(completion: completion)
        }
        
        var request = chain.input
        
        guard let url = request?.url?.absoluteString else {
            return
        }
        
        let separator = url.contains("?") ? "&" : "?"
        
        guard let finalURL = URL(string: url + separator + Key.locale + "=" + "fr_FR") else {
            return
        }
        
        request?.url = finalURL
        chain.input = request
    }
}
