//
//  ViewController.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/10/31.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fileString = "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000979.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D8/E522/F82/a484053b-bdb9-4c1f-87c3-12408399e743.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D0/E823/F612/894d8150-eab9-4cfb-9a97-b9bbff2a2929.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D12/E365/F861/050a57f2-aac0-4ccc-9723-5d88babb98c5.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D30/E198/F431/4f8f3bac-295c-476b-9057-55ebfcd59eb0.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D16/E778/F695/cf08fd34-debe-4703-96ae-e7d458bb3c13.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D13/E62/F774/ebfa80b9-0a86-4c88-9600-fff628249b83.jpghttp://www.travel.taipei/streams/sceneadmin/video/100C4.mp3"
    var fixFileString: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let aa = fileString.components(separatedBy: "http://")
        print(aa)
        print(aa.count)
    }


}

