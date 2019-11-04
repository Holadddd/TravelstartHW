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
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = TSConstant.touristTableViewTitle
        
        let barTintColor = UIColor.init(hexString: TSConstant.touristTableViewTintColorHex)
        
        self.navigationController?.navigationBar.barTintColor = barTintColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Do this method in viewDidAppear for avoid the alertController cant present with different hierarchy
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
                guard let strongSelf = self else { fatalError() }
                switch result {
                case .success(let data):
                    do {
                        
                    let data = try JSONDecoder().decode(TaipeiOpenAPIData.self, from: data)
                        print(data)
                        
                        DispatchQueue.main.async {
                            strongSelf.setupTableView()
                        }
                    } catch {
                        print(error)
                    }
                case . failure(let error):
                    print(error)
                    
                }
            }
        } else {
            
            let controller = UIAlertController(title: "Internet Connect Issue", message: "Please Check Your Internet.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            controller.addAction(okAction)
            
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    private func setupTableView() {
        loadViewIfNeeded()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.TS_registerCellWithNib(identifier: TouristTableViewCell.identifier, bundle: nil)
    }
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TouristTableViewCell.identifier, for: indexPath) as? TouristTableViewCell else { fatalError() }
        
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    
}
