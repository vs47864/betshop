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
    var selcetedAnnotation: CustomAnnotation!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = mainVM.getTitle()
        
        mapView.showsUserLocation = true
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
        
        mainVM.getShops { (shops) in
            self.addShopAnntotations(shops: shops)
        }
    }
    
    func addShopAnntotations(shops: Betshops)
    {
        for shop in shops
        {
            mapView.addAnnotation(CustomAnnotation(type: Type.basic, shop: shop))
        }
    }
}

extension MainViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! CustomAnnotation
        if annotation.type == Type.basic
        {
            selcetedAnnotation = CustomAnnotation(type: annotation.type, shop: annotation.shop)
            selcetedAnnotation?.type = Type.selected
            mapView.removeAnnotation(annotation)
            mapView.addAnnotation(self.selcetedAnnotation)
            mapView.selectAnnotation(self.selcetedAnnotation, animated: false)
        }
        else
        {
            //TODO add to show specific
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
    {
        let annotation = view.annotation as! CustomAnnotation
        if annotation.type == Type.selected
        {
            mapView.removeAnnotation(self.selcetedAnnotation)
            annotation.type = Type.basic
            mapView.addAnnotation(annotation)
        }
    }
}

protocol MainVMProtocol
{
    func getShops(completion: @escaping (_ shops : Betshops) -> Void)
    func getTitle() -> String
}
