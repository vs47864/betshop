//
//  LocationService.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject
{
    let locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?


    override init()
    {
        super.init()
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus()
        {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                break
            
            case .restricted, .denied:
                delegate?.zoomToLocation(location: Constants.defaultLocation)
                break
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                break
        }
    }
}

extension LocationService: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
            case .restricted, .denied:
                delegate?.zoomToLocation(location: Constants.defaultLocation)
                break
            
            case .notDetermined:
                break
            
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                break

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            delegate?.zoomToLocation(location: center)
        }
    }
}

protocol LocationServiceDelegate: class
{
    func zoomToLocation(location: CLLocationCoordinate2D)
}
