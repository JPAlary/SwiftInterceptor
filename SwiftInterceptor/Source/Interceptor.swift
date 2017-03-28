//
//  Interceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 19/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

/// Be able to intercept an object of type `Input`
public protocol Interceptor {
    associatedtype Input
    
    /// Intercept with an `InterceptorChain` instance and respond with a closure
    /// - parameter chain: instance of `InterceptorChain` containing the current input object.
    /// - parameter completion: closure containing the future `Input` object in parameter
    func intercept(chain: InterceptorChain<Input>, completion: (Input) -> Void) -> Void
}
