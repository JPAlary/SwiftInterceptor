//
//  ChainListener.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Be able to be notified when the input object has been chained.
public protocol ChainListener {
    associatedtype Input
    associatedtype Output
    
    /// Method called when input chained is done
    /// - parameter input: Input object which has been intercept by interceptors
    /// - parameter completion: Closure to respond with the output object
    /// - note: It's here where the output object is created. When completion is called, the object will be forward
    /// to the interceptors.
    func proceedDidFinishedWith(input: Input, completion: (Output) -> Void) -> Void
}
