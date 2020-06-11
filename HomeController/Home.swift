//
//  Home.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/8/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import SideMenu
import Firebase
import SDWebImage

class cell666 : UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAciklama: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}

class Home: UIViewController {
    
    var ref : DatabaseReference?
    
     var itemlist : [NSDictionary] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let btnAdd : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "AAdd"), for: .normal)
        btn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var menu : SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
         getitemfromDB()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
//        menu = SideMenuNavigationController(rootViewController:LeftMenu())
//        menu?.leftSide = true
//        
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        view.addSubview(btnAdd)
        _ = btnAdd.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 15))
        
        
        
        
    }
    
    @IBAction func btnLeftAction(_ sender: Any) {
//        present(menu!, animated: true, completion: nil)
    }
    
    @objc func addAction() {
        let addimage = AddImage()
        addimage.modalPresentationStyle = .fullScreen
        present(addimage, animated: true, completion: nil)
    }
    
    
    
    
    
}


extension Home : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : cell666 = tableView.dequeueReusableCell(withIdentifier: "cell666") as! cell666
       let value2 = self.itemlist[indexPath.row]

       let header = value2["header"] as? String ?? ""
       let description = value2["description"] as? String ?? ""
       let photourl = value2["photourl"] as? String ?? ""
      
        cell.lblName.text = header
        cell.lblAciklama.text = description
        cell.img.sd_setImage(with: URL(string: "\(photourl)"))
        
        
        return cell
    }
    
     func getitemfromDB(){
            
            let userRef = Database.database().reference().child("items")
    //        let userRef = Database.database().reference().child("items")

            userRef.observe(.value, with: { (snapshot) in
            
                self.itemlist.removeAll(keepingCapacity: false)
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot //get first snapshot
                    let value = snap.value as? NSDictionary //get second snapshot
                    
                    self.itemlist.append(value!)
                    
                    

                }
                
             
                //reverseni yeni bunu
    //            self.itemlist = self.itemlist.reversed()
            
                self.itemlist = self.itemlist.shuffled()
                self.tableView.reloadData()
            })
            
        }
    
    
}
