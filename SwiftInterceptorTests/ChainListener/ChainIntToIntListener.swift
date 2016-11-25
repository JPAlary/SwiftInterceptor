//
//  ChainIntToIntListener.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 21/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

@testable import SwiftInterceptor

struct ChainIntToIntListener: ChainListener {
    
    // MARK: ChainListener
    
    func proceedDidFinishedWith(input: Int, completion: (Int) -> Void) {
        completion(input)
    }
}
