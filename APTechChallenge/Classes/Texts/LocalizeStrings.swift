//
//  File.swift
//  DataReader
//
//  Created by m.jelodar on 11/9/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation

struct LocalizeStrings {
    struct MapView {
        static let mapViewTitle = "STATIONS_MAP_TITLE".localiz()
        static let routingTitle = "ROUTING".localiz()
        static let googleGoutingTitle = "GOOGLE_MAP".localiz()
        static let appleRoutingTitle = "APPLE_MAP".localiz()
    }
    struct CommonStrings {
        static let alertTitle = "ALERT".localiz()
        static let ok = "OK".localiz()
        static let cancel = "CANCEL".localiz()
        static let errorConnectivity = "THERE_IS_NO_INTERNET_CONNECTION".localiz()
        static let noItem = "THERE_IS_NO_ITEM_TO_DISPLAY".localiz()
        static let tryAgain = "TRY_AGAIN".localiz()
    }
}
