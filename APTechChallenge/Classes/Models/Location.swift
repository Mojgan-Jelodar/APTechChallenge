//
//  Location.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import ObjectMapper
import Foundation

struct Location : Mappable {
    var latitude : NSNumber?
    var longitude : NSNumber?
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        latitude <- (map["latitude"],DoubleTransform())
        longitude <- (map["longitude"],DoubleTransform())
    }
}
