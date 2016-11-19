//
//  AnyInterceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Struct that conforms to `Interceptor` protocol
/// - Type erasure of `Interceptor` protocol to be able to make homogeneous arrays or for dependency injection.
/// - The `Input` and `Output` generics types forward the two generics types in `Interceptor` protocol
struct AnyInterceptor<Input, Output>: Interceptor {
    private let _intercept: (InterceptorChain<Input, Output>, (Output) -> Void) -> Void
    
    init<I: Interceptor>(base: I) where I.Input == Input, I.Output == Output {
        _intercept = base.intercept
    }
    
    func intercept(chain: InterceptorChain<Input, Output>, completion: (Output) -> Void) -> Void {
        return _intercept(chain, completion)
    }
}
