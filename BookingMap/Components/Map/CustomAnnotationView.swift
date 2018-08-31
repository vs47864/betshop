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
            if let cluster = newValue as? MKClusterAnnotation {
                let count = cluster.memberAnnotations.count
                
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 64, height: 88))

                image = renderer.image { _ in
                    
                    UIImage(named: Type.basic.rawValue)?.draw(in: CGRect(x: 0, y: 0, width: 64, height: 88))
                    
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 8, y: 10, width: 48, height: 48)).fill()
                    
                    let attributes = [ NSAttributedStringKey.foregroundColor: Constants.blueColor,
                                       NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 22)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 32 - size.width / 2, y: 33 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
                
                

            } else {
                clusteringIdentifier = Constants.clusteringIdentifier
                guard let customAnnotation = newValue as? CustomAnnotation else {return}
                
                image = UIImage(named: customAnnotation.type.rawValue)
            }
        }
    }
}
