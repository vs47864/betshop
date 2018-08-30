//
//  Coordinator.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator
{
    var rootNC: UINavigationController { get set }
    
    init(_ rootNC: UINavigationController)
    
    func start()
    
}
