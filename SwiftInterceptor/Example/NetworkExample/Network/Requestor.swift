//
//  Requestor.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import Foundation

class FakeRequestor: ChainListener {
    
    // MARK: ChainListener
    
    func proceedDidFinished(with input: URLRequest, completion: (Response) -> Void) {
        /* 
            This class is used as an example. You should have URLSession/Alamofire/any kind of component which
            send a request.
         
            Example:
         
            URLSession.shared.dataTask(with: input) { (data, urlResponse, error) in
                completion(Response(data, urlResponse, error))
            }
         */
        
        completion(Response(requestUrl: input.url!.absoluteString))
    }
}
