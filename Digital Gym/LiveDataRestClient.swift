//
//  LiveDataRestClient.swift
//  Digital Gym
//
//  Created by Raghav Narasimhan  on 6/19/18.
//  Copyright © 2018 southpawac. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class LiveDataRestClient {
    let uri = "http://ec2-54-67-95-108.us-west-1.compute.amazonaws.com:8000"

    func getData(serialNumber:Int) -> Promise<Int?>{
        let q = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        let parameters: Parameters = ["serialNumber": serialNumber]

        return firstly {
            Alamofire.request(uri+"/bbb/check_rpm", method: .get, parameters: parameters).responseData()
            }
            .map(on: q) { data, rsp in
                (Hardware.self, from: data)
            }
            .ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
    
}

//4475502

