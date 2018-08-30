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


    override init()
    {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
}

extension LocationService: CLLocationManagerDelegate
{
    
}
