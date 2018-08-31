//
//  MainViewController.swift
//  BookingMap
//
//  Created by Višeslav Šako on 30/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MainViewController: UIViewController {

    var mainVM: MainVMProtocol!
    var selcetedAnnotation: CustomAnnotation!
    var detailsView: DetailsView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = mainVM.getTitle()
        addDetailsView()
        
        mapView.mapType = .mutedStandard
        mapView.showsUserLocation = true
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
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
    
    func addDetailsView()
    {
        self.detailsView = DetailsView(frame: CGRect.zero)
        self.detailsView.delagate = self
        self.view.addSubview(self.detailsView!)
        detailsView.snp.makeConstraints({ (make) in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(Constants.detailsViewHeight)
            make.height.equalTo(Constants.detailsViewHeight)
        })
    }
    
    func animateDetailsPosition(offssetY: Double)
    {
        self.detailsView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(offssetY)
        })
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

}

extension MainViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation
        {
            if annotation.type == Type.basic
            {
                selcetedAnnotation = CustomAnnotation(type: annotation.type, shop: annotation.shop)
                selcetedAnnotation?.type = Type.selected
                mapView.removeAnnotation(annotation)
                mapView.addAnnotation(self.selcetedAnnotation)
                mapView.selectAnnotation(self.selcetedAnnotation, animated: false)
                detailsView.setView(shop: self.selcetedAnnotation.shop)
            }
            else
            {
                animateDetailsPosition(offssetY: 0)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
    {
        if let annotation = view.annotation as? CustomAnnotation
        {
            if annotation.type == Type.selected
            {
                mapView.removeAnnotation(self.selcetedAnnotation)
                annotation.type = Type.basic
                mapView.addAnnotation(annotation)
                animateDetailsPosition(offssetY: Constants.detailsViewHeight)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let cluster = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        return cluster
    }
}

extension MainViewController: DetailsViewDelegate
{
    func closeView() {
        animateDetailsPosition(offssetY: Constants.detailsViewHeight)
        mapView.deselectAnnotation(self.selcetedAnnotation, animated: false)
    }
    
    func routeToShop()
    {
        mainVM.goToMaps(coordinate: selcetedAnnotation.coordinate)
    }
}

extension MainViewController: LocationServiceDelegate
{
    func zoomToLocation(location: CLLocationCoordinate2D)
    {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
}

protocol MainVMProtocol
{
    func getShops(completion: @escaping (_ shops : Betshops) -> Void)
    func getTitle() -> String
    func goToMaps(coordinate: CLLocationCoordinate2D)
}
