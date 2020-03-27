//
//  NetworkTools.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/26.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
import Alamofire
class NetworkTools: NSObject {

    func requestData() -> Void {
        Alamofire.request("ss", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            print("sss")
        }
        
    }
}
