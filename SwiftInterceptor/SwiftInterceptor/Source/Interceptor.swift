//
//  Interceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 19/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

/// Be able to intercept an object of type `Input` and `Output`
protocol Interceptor {
    associatedtype Input
    associatedtype Output
    
    /// Intercept with an Interceptorchain and respond with a closure
    /// - parameter chain: instance of `InterceptorChain` containing
    /// the input object. The output object can be also intercept through the `proceed` method asynchronously.
    /// - parameter completion: closure containing the ouput object in parameter
    func intercept(chain: InterceptorChain<Input, Output>, completion: (Output) -> Void) -> Void
}
