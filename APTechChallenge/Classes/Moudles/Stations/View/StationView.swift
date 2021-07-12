//
//  StationView.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import Foundation
import CoreLocation
protocol StationView : AnyObject {
    func display<T:Any>(items : [T])
    func showConnectionError()
    func startLoading()
    func stopLoading()
    func showAlert(message : String)
    func showCurrentUserLocation()
    func showOnMap(station : BikeStation)
    func openGoogleMap(station : CLLocationCoordinate2D)
    func openAppleMap(station : CLLocationCoordinate2D)
}
