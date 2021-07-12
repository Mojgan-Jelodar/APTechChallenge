//
//  BikeStation.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import Foundation
import ObjectMapper
struct BikeStation : Mappable {
    private(set) var station_id : NSNumber?
    private(set) var name : String?
    private(set) var rental_method : String?
    private(set) var capacity : NSNumber?
    private(set) var lat : NSNumber?
    private(set) var lon : NSNumber?
    private(set) var geocoded_column : Location?
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        station_id <- (map["station_id"],NumericTransform())
        name <- map["name"]
        rental_method <- map["rental_method"]
        capacity <- (map["capacity"],NumericTransform())
        lat <- (map["lat"],DoubleTransform())
        lon <- (map["lon"],DoubleTransform())
        geocoded_column <- map["geocoded_column"]
    }
}
