//
//  InterceptorChainTests.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

@testable import SwiftInterceptor
import XCTest

class InterceptorChainTests: XCTestCase {
    func test_ChainingIntToInt_ShouldSucceed() -> Void {
        let expectation = self.expectation(description: "Chaining Int to Int")
        let chainListener = AnyChainListener(base: ChainIntToIntListener())
        
        let chain = InterceptorChain(listener: chainListener, input: 1)
            .add(interceptor: AnyInterceptor(base: AddInterceptor(modifyEndValue: false)))
            .add(interceptor: AnyInterceptor(base: MinusInterceptor(modifyEndValue: false)))
            .add(interceptor: AnyInterceptor(base: AddInterceptor(modifyEndValue: false)))
        
        chain.proceed { (endValue) in
            expectation.fulfill()
            XCTAssertTrue(endValue == 2)
        }
        
        waitForExpectations(timeout: 3.0) { (error) in
            print(error)
        }
    }
    
    func test_ChainingIntToString_ShouldSucceed() -> Void {
        let expectation = self.expectation(description: "Chaining Int to String")
        let chainListener = AnyChainListener(base: ChainIntToStringListener())
        
        let chain = InterceptorChain(listener: chainListener, input: 6)
            .add(interceptor: AnyInterceptor(base: MultiplyBy3Interceptor(modifyEndValue: false)))
            .add(interceptor: AnyInterceptor(base: DivideBy2Interceptor(modifyEndValue: false)))
        
        chain.proceed { (endValue) in
            expectation.fulfill()
            XCTAssertTrue(endValue == "result: 9")
        }
        
        waitForExpectations(timeout: 3.0) { (error) in
            print(error)
        }
    }
    
    func test_ChainingIntToInt_AndChainingEndValue_ShouldSucceed() -> Void {
        let expectation = self.expectation(description: "Chaining Int to Int and chain end value")
        let chainListener = AnyChainListener(base: ChainIntToIntListener())
        
        let chain = InterceptorChain(listener: chainListener, input: 10)
            .add(interceptor: AnyInterceptor(base: AddInterceptor(modifyEndValue: true)))
            .add(interceptor: AnyInterceptor(base: MinusInterceptor(modifyEndValue: true)))
            .add(interceptor: AnyInterceptor(base: MinusInterceptor(modifyEndValue: true)))
        
        chain.proceed { (endValue) in
            expectation.fulfill()
            XCTAssertTrue(endValue == 8)
        }
        
        waitForExpectations(timeout: 3.0) { (error) in
            print(error)
        }
    }
    
    func test_ChainingIntToString_AndChainingEndValue_ShouldSucceed() -> Void {
        let expectation = self.expectation(description: "Chaining Int to String and chain end value")
        let chainListener = AnyChainListener(base: ChainIntToStringListener())
        
        let chain = InterceptorChain(listener: chainListener, input: 6)
            .add(interceptor: AnyInterceptor(base: MultiplyBy3Interceptor(modifyEndValue: true)))
            .add(interceptor: AnyInterceptor(base: DivideBy2Interceptor(modifyEndValue: true)))
        
        chain.proceed { (endValue) in
            expectation.fulfill()
            XCTAssertTrue(endValue == "result: 9 divided multiplied")
        }
        
        waitForExpectations(timeout: 3.0) { (error) in
            print(error)
        }
    }
}
