//
//  MainPageViewController.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/1.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit
import Kingfisher

enum fetchingError: Error {
    
    case internetError
    
    case decoderError
}

class MainPageViewController: UIViewController {
    //for testing internet
    var reachability = Reachability(hostName: "www.apple.com")
   
    var touristData: [ResultInfo] = []
    
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
                        
                        let fetchingResult = data.result.results.map{ resultInfo-> ResultInfo in
                            
                            var fixedResult = resultInfo
                            
                            fixedResult.jpgFilesURLSlipAndfilter()
                            
                            return fixedResult
                        }
                        
                        strongSelf.touristData += fetchingResult
                        
                        DispatchQueue.main.async {
                            
                            strongSelf.setupTableView()
                            
                            strongSelf.tableView.reloadData()
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
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.TS_registerCellWithNib(identifier: TouristTableViewCell.identifier, bundle: nil)
    }
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return touristData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TouristTableViewCell.identifier, for: indexPath) as? TouristTableViewCell else { fatalError() }
        
        let touristInfo = touristData[indexPath.section]
        
        cell.titleLabel.text = touristInfo.stitle
        
        cell.descriptLabel.text = touristInfo.description
        
        cell.indexPathInCode = indexPath
        
        cell.collectionView.delegate = self
        
        cell.collectionView.dataSource = self
        
        cell.collectionView.register(TouristCollectionViewCell.self, forCellWithReuseIdentifier: "TouristCollectionViewCell")
        
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    
}

extension MainPageViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard let cell = collectionView.superview?.superview as? TouristTableViewCell else { fatalError() }

//        guard let indexPath = tableView.indexPath(for: cell) else { fatalError() }

        guard let indexPath = cell.indexPathInCode else { fatalError() }
        
        guard let jpgFilesArr = touristData[indexPath.section].jpgFiles else { fatalError() }
        
        return jpgFilesArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TouristCollectionViewCell", for: indexPath) as? TouristCollectionViewCell else{ fatalError() }
        
        guard let tableViewCell = collectionView.superview?.superview as? TouristTableViewCell else { fatalError() }
        
        //        guard let indexPath = tableView.indexPath(for: cell) else { fatalError() }
        
        guard let tableViewCellIndexPath = tableViewCell.indexPathInCode else { fatalError() }
        
        guard let jpgFilesArr = touristData[tableViewCellIndexPath.section].jpgFiles else { fatalError() }
        
        let url = URL(string: jpgFilesArr[indexPath.row])
        
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }

}

extension MainPageViewController: UICollectionViewDelegate {

}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let height = collectionView.frame.height
        
        let size = CGSize(width: height, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

