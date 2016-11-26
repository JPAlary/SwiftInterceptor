//
//  ChainListener.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

/// Be able to be notified when the `Input` object has finished to be chain.
/// - note: It's here where the `Output` object is created. When the completion closure in proceed method is called, the `Output` object chaining
/// will start.
public protocol ChainListener {
    associatedtype Input
    associatedtype Output
    
    /// Method called when `Input` object chaining is finished
    /// - parameter input: `Input` object which has been intercepted by interceptors
    /// - parameter completion: closure to give back the `Output` object.
    /// - note: It's here where the `Output` object is created. When completion is called, the `Output` object chaining 
    /// will start.
    func proceedDidFinished(with input: Input, completion: (Output) -> Void) -> Void
}
