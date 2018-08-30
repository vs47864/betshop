//
//  CustomAnnotationView.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView
{
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? CustomAnnotation else {return}
            
            image = UIImage(named: customAnnotation.type.rawValue)
        }
    }
}
