//
//  Constants.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Constants
{
    static let baseURL = "https://sa-api.info"
    static let pathURL = "/api/casapariurilor/shop/list?boundingBox"
    static let primaryColor = UIColor(red: 140/255.0, green: 184/255.0, blue: 43/255.0, alpha: 1.0)
    static let blueColor = UIColor(red: 52/255.0, green: 82/255.0, blue: 150/255.0, alpha: 1.0)
    static let title = "Bet shops"
    static let detailsViewHeight = 234.0
    static let defaultLocation = CLLocationCoordinate2D(latitude: 44.435105, longitude: 26.100019)
    static let clusteringIdentifier = "shop"
}
