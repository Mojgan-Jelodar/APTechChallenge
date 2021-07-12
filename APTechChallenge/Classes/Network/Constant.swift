//
//  Constant.swift
//  DataReader
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation
//Active Compilation Conditions
#if DEBUG
let apiEnv: APIEnvironment = .debug
#else
let apiEnv: APIEnvironment = .production
#endif
enum APIEnvironment {
    case production
    case debug
    var string: String {
        switch self {
        case .production:
            return "https://data.melbourne.vic.gov.au/"
        default:
            return "https://data.melbourne.vic.gov.au/"
        }
    }
}
enum Endpoints {
    case resources
    var string: String {
        switch self {
        case .resources:
            return "resource/vrwc-rwgm.json"
        }
    }
}
