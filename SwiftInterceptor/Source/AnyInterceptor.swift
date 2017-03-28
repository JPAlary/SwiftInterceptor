//
//  AnyInterceptor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Struct that conforms to `Interceptor` protocol
/// - Type erasure of `Interceptor` protocol to be able to make homogeneous arrays or dependency injection.
/// - The `Input` generics type forward to the generic type in `Interceptor` protocol
public struct AnyInterceptor<Input>: Interceptor {
    private let _intercept: (InterceptorChain<Input>, (Input) -> Void) -> Void
    
    public init<I: Interceptor>(base: I) where I.Input == Input {
        _intercept = base.intercept
    }
    
    public func intercept(chain: InterceptorChain<Input>, completion: (Input) -> Void) -> Void {
        return _intercept(chain, completion)
    }
}
