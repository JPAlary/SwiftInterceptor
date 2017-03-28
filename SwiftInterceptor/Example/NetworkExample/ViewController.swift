//
//  NetworkExampleViewController.swift
//  SwiftInterceptor
//
//  Created by Jean-Pierre Alary on 22/11/2016.
//  Copyright © 2016 Jean-Pierre Alary. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        sendRequest()
    }
    
    // MARK: Private
    
    private func sendRequest() -> Void {
        let httpClient = MyHTTPClient()
        let request = URLRequest(url: URL(string: "https://some-api.com")!)
        
        httpClient.send(request: request) { (result) in
            switch result {
            case .success(let response):
                // print : https://some-api.com?access_token=some_value&locale=fr_FR
                
                print(response.requestUrl)
            case .error(_):
                // Handle error
                break
            case .networkError(_):
                // Handle error
                break
            }
        }
    }
}
