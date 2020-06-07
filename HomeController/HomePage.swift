//
//  HomePage.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

class HomePage: UIViewController {
    
    var menu : SideMenuNavigationController?
    
    let topView : UIView = {
       let view = UIView()
        view.backgroundColor = .customBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let btnSideMenu : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "menuy"), for: .normal)
        btn.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let imgLogo : UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_launcher"))
        //img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 49).isActive = true
        img.widthAnchor.constraint(equalToConstant: 49).isActive = true
        return img
    }()
    
    let searchView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return view
    }()
    
    let searchBar : UISearchBar = {
       let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let tableView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     fileprivate let urunlerCollectionView : UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.backgroundColor = .white
           cv.translatesAutoresizingMaskIntoConstraints = false
           return cv
       }()
    
    let btnAdd : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "AAdd"), for: .normal)
        btn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customBlue()
        
        stackView()
        addSubview()
        addConstraint()
        sideMenu()
        layoutTableView()
       
        
    }
    
    func stackView() {
        let stackView = UIStackView(arrangedSubviews: [topView,searchView,tableView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        _ = stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
       
    }
    
    func addSubview() {
        topView.addSubview(btnSideMenu)
        topView.addSubview(imgLogo)
        searchView.addSubview(searchBar)
        tableView.addSubview(urunlerCollectionView)
        view.addSubview(btnAdd)
        
    }
    
    func addConstraint() {
        btnSideMenu.merkezYSuperView()
        btnSideMenu.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 10).isActive = true
        
        imgLogo.merkezKonumlamdirmaSuperView()
        
        _ = searchBar.anchor(top: searchView.topAnchor, bottom: searchView.bottomAnchor, leading: searchView.leadingAnchor, trailing: searchView.trailingAnchor)
        
        _ = urunlerCollectionView.anchor(top: tableView.topAnchor, bottom: tableView.bottomAnchor, leading: tableView.leadingAnchor, trailing: tableView.trailingAnchor)
        
        _ = btnAdd.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 15))
    }
    
    func sideMenu() {
         menu = SideMenuNavigationController(rootViewController:LeftSideMenu())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @objc func sideMenuAction() {
        present(menu!, animated: true, completion: nil)
        
    }
    
    func layoutTableView() {
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "UrunlerCel", bundle: nil), forCellWithReuseIdentifier: "UrunlerCel")
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.itemSize = CGSize(width: view.frame.width, height: 334)
                   layout.minimumLineSpacing = 10
                   layout.minimumInteritemSpacing = 5
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
               }
    }
    

    
    @objc func addAction() {
        let addimage = AddImage()
        addimage.modalPresentationStyle = .fullScreen
        present(addimage, animated: true, completion: nil)
    }
   

}

extension HomePage : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "UrunlerCel", for: indexPath) as! UrunlerCel
        cell.backgroundColor = .red
        return cell
        
    
}

}

