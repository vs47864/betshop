//
//  DetailsView.swift
//  BookingMap
//
//  Created by Višeslav Šako on 31/08/2018.
//  Copyright © 2018 viseslav. All rights reserved.
//

import UIKit

class DetailsView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTel: UILabel!
    @IBOutlet weak var lblState: UILabel!
    
    weak var delagate: DetailsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit()
    {
        Bundle.main.loadNibNamed("DetailsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.top.equalTo(self)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 16.0, height: 16.0)).cgPath
        self.layer.mask = shapeLayer;
    }
    
    
    func setView(shop: Betshop)
    {
        lblTel.text = shop.phone
        lblName.text = shop.name
        lblAddress.text = shop.address
        lblCity.text = shop.city + "-" + shop.county
        chackIfOpen(start: shop.workingHourStart, end: shop.workingHourEnd)
    }
    
    func chackIfOpen(start: String, end:String)
    {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let startTime = dateFormatter.date(from: start)
        let endTime = dateFormatter.date(from: end)
        
        let calendar = Calendar.current
        

        var startComponents = calendar.dateComponents([.hour, .minute], from: startTime!)
        var endComponents = calendar.dateComponents([.hour, .minute], from: endTime!)
        
        let nowComponents = calendar.dateComponents([.month, .day, .year], from: now)

        startComponents.year  = nowComponents.year
        startComponents.month = nowComponents.month
        startComponents.day   = nowComponents.day
        
        endComponents.year  = nowComponents.year
        endComponents.month = nowComponents.month
        endComponents.day   = nowComponents.day
        
        
        let startDate = calendar.date(from: startComponents)
        let endDate = calendar.date(from: endComponents)
        
        if now > endDate! || now < startDate!
        {
            lblState.text = "Closed until: " + start
        }
        else
        {
            lblState.text = "Open now until: " + end
        }
    }
    
    @IBAction func actionClose(_ sender: Any)
    {
        self.delagate?.closeView()
    }
    
    @IBAction func actionRoute(_ sender: Any)
    {
        self.delagate?.routeToShop()
    }
}

protocol DetailsViewDelegate: class
{
    func closeView()
    func routeToShop()
}
