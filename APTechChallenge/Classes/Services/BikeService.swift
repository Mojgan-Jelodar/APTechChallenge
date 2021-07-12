//
//  BikeService.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
final class BikeService : NSObject {
    class var shared : BikeService {
        struct Static {
          static let instance = BikeService()
        }
        return Static.instance
    }
    private lazy var network : Network = {
        return Network(url: apiEnv.string)
    }()
    func fetchResources(callback :@escaping (Result<[BikeStation]>) -> Void) {
        self.network.get(at: Endpoints.resources).responseArray { (response : DataResponse<[BikeStation]>) in
            callback(response.result)
        }
    }
}
