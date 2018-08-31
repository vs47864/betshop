//
//  MainCoordinator.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MainCoordinator: Coordinator
{
    var rootNC: UINavigationController
    
    required init(_ rootNC: UINavigationController)
    {
        self.rootNC = rootNC
    }
    
    func start()
    {
        let  mainVC = MainViewController()
        let mainVM = MainViewModel()
        mainVM.routeToShop = { (coordinate) in
            let currentLocMapItem = MKMapItem.forCurrentLocation()
            
            let selectedPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
            
            let mapItems = [selectedMapItem, currentLocMapItem]
            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            
            MKMapItem.openMaps(with: mapItems, launchOptions:launchOptions)
        }
        
        mainVC.mainVM = mainVM
        self.rootNC.pushViewController(mainVC, animated: true)
    }
}
