//
//  MainViewController.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    var mainVM: MainVMProtocol!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
    }
}

protocol MainVMProtocol
{
    
}
