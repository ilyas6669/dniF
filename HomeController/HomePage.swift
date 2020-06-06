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
    
    let urunlerTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customBlue()
        
        stackView()
        addSubview()
        addConstraint()
        sideMenu()
       
        
    }
    
    func stackView() {
        let stackView = UIStackView(arrangedSubviews: [topView,searchView,tableView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        _ = stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
    func addSubview() {
        topView.addSubview(btnSideMenu)
        topView.addSubview(imgLogo)
        searchView.addSubview(searchBar)
        tableView.addSubview(urunlerTableView)
        
    }
    
    func addConstraint() {
        btnSideMenu.merkezYSuperView()
        btnSideMenu.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 10).isActive = true
        
        imgLogo.merkezKonumlamdirmaSuperView()
        
        _ = searchBar.anchor(top: searchView.topAnchor, bottom: searchView.bottomAnchor, leading: searchView.leadingAnchor, trailing: searchView.trailingAnchor)
        
        _ = urunlerTableView.anchor(top: tableView.topAnchor, bottom: tableView.bottomAnchor, leading: tableView.leadingAnchor, trailing: tableView.trailingAnchor)
        
    }
    
    func sideMenu() {
         menu = SideMenuNavigationController(rootViewController: LeftSideMenuView())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @objc func sideMenuAction() {
        present(menu!, animated: true, completion: nil)
        
    }
    
    func layoutTableView() {
        urunlerTableView.delegate = self
        urunlerTableView.dataSource = self
    }
    

   

}

extension HomePage : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = urunlerTableView.dequeueReusableCell(withIdentifier: "UrunlerCell", for: indexPath)
        return cell
    }
   
    
}

