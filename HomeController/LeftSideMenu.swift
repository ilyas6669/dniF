//
//  LeftSideMenu.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class LeftSideMenu: UIViewController {
    
    let array = ["","Hesap","Ana Sayfa","Konumunu Güncelle","Dili değiştir","Çıkış Yap","Kategoriler","Market","Eczane","Otel","Bankamatik","Ptt","Berber","Restoran","Terzi"]
    
    fileprivate let sideMenu : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .blue
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView()
        addSubview()
        addConstraint()

       
    }
    
    func collectionView() {
        sideMenu.delegate = self
        sideMenu.dataSource = self
        sideMenu.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellWithReuseIdentifier: "SideMenuCell")
    }
    
    func addSubview() {
        view.addSubview(sideMenu)
    }
    
    func addConstraint() {
        _ = sideMenu.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    

    

}

extension LeftSideMenu : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sideMenu.dequeueReusableCell(withReuseIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        if array.count == 0 {
            cell.backgroundColor = .customBlue()
            cell.imgLogo.isHidden = false
            cell.imgLogo.merkezKonumlamdirmaSuperView()
            return cell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
