//
//  Betshops.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation

typealias Betshops = [Betshop]

struct Betshop: Codable {
    let id: Int
    let name: String
    let location: Location
    let address: String
    let cityID: Int
    let city, county, workingHourStart, workingHourEnd: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case location = "Location"
        case address = "Address"
        case cityID = "CityId"
        case city = "City"
        case county = "County"
        case workingHourStart = "WorkingHourStart"
        case workingHourEnd = "WorkingHourEnd"
        case phone = "Phone"
    }
}

struct Location: Codable {
    let lat, lng: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "Lat"
        case lng = "Lng"
    }
}
