//
//  Annotation.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var type: Type
    let shop: Betshop
    
    init(type: Type, shop: Betshop) {
        self.type = type
        self.shop = shop
        self.coordinate =  CLLocationCoordinate2DMake(shop.location.lat ,shop.location.lng)
        super.init()
    }
}

    enum Type: String {
        case selected
        case basic
}
