//
//  LeftSideMenuView.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class LeftSideMenuView: UIViewController {
    
    let array = ["Hesap","Ana Sayfa","Konumunu Güncelle","Dili değiştir","Çıkış Yap","Kategoriler","Market","Eczane","Otel","Bankamatik","Ptt","Berber","Restoran","Terzi"]
    
    let sidemenuTable : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .green
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue()
        addSubview()
        tableView()
        addConstraint()
        
        
    }
    
    func addSubview() {
        view.addSubview(sidemenuTable)
        
    }
    
    func tableView() {
        sidemenuTable.delegate = self
        sidemenuTable.dataSource = self
        sidemenuTable.register(UINib(nibName: "LeftSideMenuCell", bundle: nil), forCellReuseIdentifier: "LeftSideMenuCell")
    }
    
    func addConstraint() {
        _ = sidemenuTable.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
}

extension LeftSideMenuView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sidemenuTable.dequeueReusableCell(withIdentifier: "LeftSideMenuCell", for: indexPath) as! LeftSideMenuCell
        if indexPath.row < 1 {
            cell.img.isHidden = true
            cell.lbl.leadingAnchor.constraint(equalTo: cell.leadingAnchor,constant: 10).isActive = true
            cell.lbl.merkezXSuperView()
            cell.lbl.text = "Hesap"
            cell.lbl.textColor = .darkGray
            cell.lbl.font = UIFont.boldSystemFont(ofSize: 20)
        } else if indexPath.row < 5 {
            cell.img.isHidden = true
            cell.lbl.leadingAnchor.constraint(equalTo: cell.leadingAnchor,constant: 10).isActive = true
            cell.lbl.merkezXSuperView()
            
        } else if indexPath.row < 6 {
            cell.img.isHidden = true
            cell.lbl.leadingAnchor.constraint(equalTo: cell.leadingAnchor,constant: 10).isActive = true
            cell.lbl.merkezXSuperView()
            cell.lbl.text = "Kategoriler"
            cell.lbl.textColor = .darkGray
            cell.lbl.font = UIFont.boldSystemFont(ofSize: 20)
        } else if indexPath.row > 6 {
            cell.img.isHidden = false
            cell.lbl.textColor = .black
            cell.lbl.font = UIFont.systemFont(ofSize: 20)
            cell.lbl.leadingAnchor.constraint(equalTo: cell.img.trailingAnchor,constant: 10).isActive = true
            cell.lbl.merkezXSuperView()
        }
       
         cell.lbl.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
   
    
    
}
