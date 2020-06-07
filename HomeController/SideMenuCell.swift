//
//  SideMenuCell.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SideMenuCell: UICollectionViewCell {
    
    let imgLogo : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "ic_launcher-1"))
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let imgIcon : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "location"))
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(imgLogo)
        addSubview(imgIcon)
        addSubview(lbl)
        
        imgLogo.isHidden = true
        imgIcon.isHidden = true
        lbl.isHidden = true
        
    }
    
}
