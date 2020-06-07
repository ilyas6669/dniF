//
//  UrunlerCel.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class UrunlerCel: UICollectionViewCell {
    
    
       let imgView : UIView = {
          let view = UIView()
           view.backgroundColor = .blue
           view.translatesAutoresizingMaskIntoConstraints = false
           view.heightAnchor.constraint(equalToConstant: 300).isActive = true
           return view
       }()
       
       let img : UIImageView = {
          let img = UIImageView()
           img.translatesAutoresizingMaskIntoConstraints = false
           img.contentMode = .scaleAspectFit
           return img
       }()
       
       let nameView : UIView = {
          let view = UIView()
           view.backgroundColor = .red
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let lblName : UILabel = {
          let lbl = UILabel()
           lbl.textColor = .black
           lbl.textAlignment = .left
           lbl.font = UIFont.boldSystemFont(ofSize: 20)
           lbl.text = "Name"
           lbl.translatesAutoresizingMaskIntoConstraints = false
           return lbl
       }()
       
       let aciklamaView : UIView = {
          let view = UIView()
           view.backgroundColor = .red
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let lblAciklama : UILabel = {
          let lbl = UILabel()
           lbl.textColor = .darkGray
           lbl.textAlignment = .left
           lbl.font = UIFont.systemFont(ofSize: 15)
           lbl.text = "Aciklama"
           lbl.translatesAutoresizingMaskIntoConstraints = false
           return lbl
       }()
       
       let likeView : UIView = {
          let view = UIView()
           view.backgroundColor = .red
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let commecntView : UIView = {
          let view = UIView()
           view.backgroundColor = .red
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let btnView : UIView = {
          let view = UIView()
           view.backgroundColor = .red
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       
      

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        
//        let stackView = UIStackView(arrangedSubviews: [imgView,nameView,aciklamaView,likeView,commecntView,btnView])
//               
//               stackView.axis = .vertical
//               stackView.distribution = .fillEqually
//               
//               stackView.addArrangedSubview(stackView)
//               _ = stackView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

}
