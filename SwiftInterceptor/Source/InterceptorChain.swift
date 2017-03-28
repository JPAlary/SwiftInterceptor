//
//  InterceptorChain.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Class which handles the chaining of the interceptors given
/// - `Input` generic forward to the same generic of the `AnyInterceptor`
/// - It's the entry point of the SwiftInterceptor library when you want to use it
public class InterceptorChain<Input> {
    private var interceptors: [AnyInterceptor<Input>]
    
    // MARK: Initializer
    
    /// Convenience initializer
    public convenience init() {
        self.init(interceptors: [AnyInterceptor<Input>]())
    }
    
    /// Initialized with an array of interceptors which will intercept the input given
    public init(interceptors: [AnyInterceptor<Input>], input: Input? = nil) {
        self.interceptors = interceptors
        self.input = input
    }
    
    // MARK: Public
    
    /// The input which is intercept when `InterceptorChain` proceed
    public var input: Input?
    
    /// Add an interceptor
    /// - note: It returns `Self` to chain methods call at the initialization
    /// - warning: the AnyInterceptor in parameter must have the same `Input` type of the `InterceptorChain`
    /// - returns: `InterceptorChain<Input>`
    public func add(interceptor: AnyInterceptor<Input>) -> InterceptorChain {
        interceptors.append(interceptor)
        
        return self
    }
    
    /// Launch the chaining of the input:
    /// - given at the initialization 
    /// - if not, given in parameter
    /// - if not, raise a fatalError
    /// - parameter object: the `Input` object to proceed.
    /// - warning: You must set the input object at the initialization of the `InterceptorChain<Input>` or set the class property or
    /// give it in parameter of this method.
    /// - parameter completion: Closure with the final result
    public func proceed(object: Input? = nil, completion: (Input) -> Void) -> Void {
        var currentInput: Input
        
        if let object = object {
            currentInput = object
        } else if let input = self.input {
            currentInput = input
        } else {
            fatalError("You need to provide an `Input` object: in parameter of `proceed` method or by setting the class property.")
        }
        
        guard let interceptor = self.interceptors.first else {
            completion(currentInput)
            
            return
        }
        
        var interceptors = self.interceptors
        interceptors.removeFirst()
        
        interceptor.intercept(chain: InterceptorChain(interceptors: interceptors, input: currentInput), completion: completion)
    }
}
