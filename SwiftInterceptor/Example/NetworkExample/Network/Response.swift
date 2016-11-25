//
//  Response.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

/*
    This class is used as an example, but you should have Data, Error, statusCode, etc in it ;)
    I just store the final request url to print it at the end and show the work of the interceptors
 */
struct Response {
    let requestUrl: String
    
    // MARK: Initializer
    
    init(requestUrl: String) {
        self.requestUrl = requestUrl
    }
}
