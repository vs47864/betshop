//
//  NetworkingService.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingService
{
    let baseUrl: URL = URL(string: "https://sa-api.info")!
    
    func getLocation(coordinates: String, completion: @escaping (_ shops : Betshops?) -> Void)
    {
//        guard let url = URL(string: Constants.baseURL + Constants.pathURL) else {
//            completion(nil)
//            return
//        }
        
        guard let url = URL(string: "https://sa-api.info/api/casapariurilor/shop/list?boundingBox=45.0%2C27.0%2C44.0%2C25.0") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        Alamofire.request(request).responseData
            {
                response in switch response.result
                {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let shops = try decoder.decode(Betshops.self, from: data)
                        completion(shops)
                    } catch let error {
                        completion(nil)
                        print("Parsing failed with error: \(error)")
                    }
                case .failure(let error):
                    completion(nil)
                    print("Request failed with error: \(error)")
                }
        }
    }
}
