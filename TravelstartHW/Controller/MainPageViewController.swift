//
//  MainPageViewController.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HTTPClient.shared.request(TSUserRequest.taipeiOpenAPI(offset: 2)) { result in
            
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
    }
}
