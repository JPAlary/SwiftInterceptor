//
//  AddInterceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

@testable import SwiftInterceptor

struct AddInterceptor: Interceptor {
    private let modifyEndValue: Bool
    
    // MARK: Initializer
    
    init(modifyEndValue: Bool) {
        self.modifyEndValue = modifyEndValue
    }
    
    // MARK: Interceptor
    
    func intercept(chain: InterceptorChain<Int, Int>, completion: (Int) -> Void) {
        var value = chain.input
        value += 1
        
        chain.input = value
        
        chain.proceed { (endValue) in
            if modifyEndValue {
                completion(endValue + 1)
            } else {
                completion(endValue)
            }
        }
    }
}
