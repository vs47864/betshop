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
        
        if now > endTime! || now < startTime!
        {
            lblState.text = "Closed until: " + start
        }
        else
        {
            lblState.text = "Open now until: " + start
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
