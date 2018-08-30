//
//  MainViewModel.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation

class MainViewModel
{
    let locationService = LocationService()
    let networkService = NetworkingService()
}


extension MainViewModel: MainVMProtocol
{
    func getTitle() -> String {
        return Constants.title
    }
    
    func getShops(completion: @escaping (_ shops : Betshops) -> Void)
    {
        networkService.getLocation(coordinates: "") { (shops) in
            if let shops = shops
            {
                completion(shops)
            }
        }
    }
}
