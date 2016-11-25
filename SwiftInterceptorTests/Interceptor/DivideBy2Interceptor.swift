//
//  DivideBy2Interceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

@testable import SwiftInterceptor

struct DivideBy2Interceptor: Interceptor {
    private let modifyEndValue: Bool
    
    // MARK: Initializer
    
    init(modifyEndValue: Bool) {
        self.modifyEndValue = modifyEndValue
    }
    
    // MARK: Interceptor
    
    func intercept(chain: InterceptorChain<Int, String>, completion: (String) -> Void) {
        var value = chain.input
        value /= 2
        
        chain.input = value
        
        chain.proceed { (endValue) in
            if modifyEndValue {
                completion(endValue + " divided")
            } else {
                completion(endValue)
            }
        }
    }
}
