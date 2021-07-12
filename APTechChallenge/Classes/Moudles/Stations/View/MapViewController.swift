//
//  MapViewController.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {
    @IBOutlet var loadingView : UIView?
    @IBOutlet var mapView : GMSMapView?
    @IBOutlet var activityIndicator : UIActivityIndicatorView?
    private lazy var presenter : MapPresenter = {
        return MapPresenter(view: self)
    }()
    private lazy var locationManager : CLLocationManager = {
        let tmp = CLLocationManager()
        tmp.delegate = self
        return tmp
    }()
    private var stations : [BikeStation] = []
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchController {
            vc.list = stations
            vc.stationDidSelect = { (station) -> Void in
              self.presenter.showOnMap(station: station)
            }
        }
    }
}
// MARK: - ViewController LifeCycle
extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.delegate = self
        self.title = LocalizeStrings.MapView.mapViewTitle
        self.presenter.showCurrentUserLocation()
        self.presenter.fetch()
    }
}
// MARK: - User Location
extension  MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        manager.startUpdatingLocation()
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}
// MARK: - GMSMapViewDelegate
extension MapViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let actionSheetController: UIAlertController = UIAlertController(title: LocalizeStrings.MapView.routingTitle, message: marker.title, preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.cancel, style: .cancel, handler: nil))
        actionSheetController.addAction(UIAlertAction(title: LocalizeStrings.MapView.googleGoutingTitle, style: .default, handler: {(_) in
            self.presenter.routeByGoogle(station: marker.position)
        }))
        actionSheetController.addAction(UIAlertAction(title: LocalizeStrings.MapView.appleRoutingTitle, style: .destructive, handler: {(_) in
            self.presenter.routeByAppleMap(station: marker.position)
        }))
        self.present(actionSheetController, animated: true, completion: nil)
        return true
    }
}
extension MapViewController : StationView {
    func openGoogleMap(station: CLLocationCoordinate2D) {
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            let googlemapsUrl = "comgooglemaps://?saddr=&daddr=\(station.latitude),\(station.longitude)&directionsmode=driving"
            UIApplication.shared.open(URL(string: googlemapsUrl)!)
        } else if let source = mapView?.myLocation?.coordinate {
            let urlString = "http://maps.google.com/?saddr=\(source.latitude),\(source.longitude)&daddr=\(station.latitude),\(station.longitude)&directionsmode=driving"
            UIApplication.shared.open(URL(string: urlString)!)
        }
    }
    func openAppleMap(station: CLLocationCoordinate2D) {
      if let source = mapView?.myLocation?.coordinate {
        let url = "http://maps.apple.com/maps?saddr=\(source.latitude),\(source.longitude)&daddr=\(station.latitude),\(station.longitude)"
        UIApplication.shared.open(URL(string:url)!)
      }
    }
    func showOnMap(station: BikeStation) {
        self.mapView?.animate(toLocation: CLLocationCoordinate2D(latitude: (station.lat?.doubleValue)!, longitude: (station.lon?.doubleValue)!))
        self.mapView?.setMinZoom(4.6, maxZoom: 20)
    }
    func showCurrentUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    func showConnectionError() {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: LocalizeStrings.CommonStrings.errorConnectivity, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.tryAgain, style: UIAlertAction.Style.default, handler: { (_) in
            self.presenter.fetch()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: LocalizeStrings.CommonStrings.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizeStrings.CommonStrings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func display<T>(items: [T]) {
        if let stations = items as? [BikeStation] {
            self.stations = stations
            for station in stations {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: (station.lat?.doubleValue)!, longitude: (station.lon?.doubleValue)!)
                marker.title = station.name
                marker.snippet = station.capacity?.stringValue
                marker.icon = Images.bike
                marker.map = mapView
            }
        }
    }
    func startLoading() {
        self.activityIndicator?.startAnimating()
        self.loadingView?.fadeIn(duration: 0.3)
    }
    func stopLoading() {
        self.activityIndicator?.stopAnimating()
        self.loadingView?.fadeOut(duration: 0.3)
    }
}
