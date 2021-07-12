//
//  StationsPresenter.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import Foundation
import CoreLocation
struct MapPresenter {
    let view : StationView?
    func showCurrentUserLocation() {
        self.view?.showCurrentUserLocation()
    }
    func fetch() {
        if Connectivity.isConnectedToInternet() {
            self.callApi()
        } else {
            self.view?.showConnectionError()
        }
    }
    func showOnMap(station : BikeStation) {
        self.view?.showOnMap(station: station)
    }
    func routeByGoogle(station : CLLocationCoordinate2D) {
        self.view?.openGoogleMap(station: station)
    }
    func routeByAppleMap(station : CLLocationCoordinate2D) {
        self.view?.openAppleMap(station: station)
    }
    private func callApi() {
        self.view?.startLoading()
        BikeService.shared.fetchResources { (result) in
            self.view?.stopLoading()
            switch result {
            case .success(let value):
                self.showMarkersOnTheMap(list: value)
            case .failure(let error):
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }
    private func showMarkersOnTheMap(list : [BikeStation]) {
        let newList = list.filter({$0.lat?.doubleValue != nil && $0.lon?.doubleValue != nil})
        self.view?.display(items: newList)
    }
}
