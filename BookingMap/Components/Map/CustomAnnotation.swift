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
    
    init(type: Type, coordinate: CLLocationCoordinate2D) {
        self.type = type
        self.coordinate = coordinate
        super.init()
    }
}

    enum Type: String {
        case selected
        case basic
}
