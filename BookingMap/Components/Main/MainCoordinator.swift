//
//  MainCoordinator.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import UIKit

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
        mainVC.mainVM = MainViewModel()
        self.rootNC.pushViewController(mainVC, animated: true)
    }
}
