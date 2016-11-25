//
//  AnyChainListener.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Struct that conforms to `ChainListener`
/// - Type erasure of `ChainListener` protocol to be able to make homogeneous arrays or for dependency injection.
/// - The `Input` and `Output` generics types forward the two generics types in `ChainListener` protocol
public struct AnyChainListener<Input, Output>: ChainListener {
    private let _callback: (Input, (Output) -> Void) -> Void
    
    public init<C: ChainListener>(base: C) where C.Input == Input, C.Output == Output {
        _callback = base.proceedDidFinishedWith
    }
    
    public func proceedDidFinishedWith(input: Input, completion: (Output) -> Void) -> Void {
        return _callback(input, completion)
    }
}
