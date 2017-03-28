//
//  InterceptorChainTests.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

@testable import SwiftInterceptor
import XCTest

final class InterceptorChainTests: XCTestCase {
    func test_ChainingIntValue_ShouldSucceed() -> Void {
        let expectation = self.expectation(description: "Chaining Int to Int")
        
        let chain = InterceptorChain()
            .add(interceptor: AnyInterceptor(base: AddInterceptor()))
            .add(interceptor: AnyInterceptor(base: MinusInterceptor()))
            .add(interceptor: AnyInterceptor(base: AddInterceptor()))
        chain.input = 1
        
        chain.proceed { (endValue) in
            expectation.fulfill()
            XCTAssertTrue(endValue == 2)
        }
        
        waitForExpectations(timeout: 1.0)
    }
}

private struct AddInterceptor: Interceptor {
    
    // MARK: Interceptor
    
    func intercept(chain: InterceptorChain<Int>, completion: (Int) -> Void) {
        var value = chain.input!
        value += 1
        
        chain.input = value
        chain.proceed(completion: completion)
    }
}

private struct MinusInterceptor: Interceptor {
    
    // MARK: Interceptor
    
    func intercept(chain: InterceptorChain<Int>, completion: (Int) -> Void) {
        var value = chain.input!
        value -= 1
        
        chain.input = value
        chain.proceed(completion: completion)
    }
}
