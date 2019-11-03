//
//  MainPageViewController.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

enum fetchingError: Error {
    
    case internetError
    
    case decoderError
}

class MainPageViewController: UIViewController {
    //for testing internet
    var reachability = Reachability(hostName: "www.apple.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchingData()
    }
    
    func checkInternetFunction() -> Bool {
        
      if reachability?.currentReachabilityStatus().rawValue == 0 {
        
        print("no internet connected.")
        
        return false
      }else {
        
        print("internet connected successfully.")
        
        return true
      }
    }
    
    func fetchingData() {
        
        if checkInternetFunction() == true {
            
            HTTPClient.shared.request(TSUserRequest.taipeiOpenAPI(offset: 0, limit: 10)) {[weak self] result in
                
                switch result {
                case .success(let data):
                    do {
                    let data = try JSONDecoder().decode(TaipeiOpenAPIData.self, from: data)
                        print(data)
                    } catch {
                        print(error)
                        
                    }
                case . failure(let error):
                    print(error)
                    
                }
            }
        } else {
            
            print("show internet alert")
        }
        
    }
}
