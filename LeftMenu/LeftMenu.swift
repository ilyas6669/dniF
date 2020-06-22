//
//  LeftMenu.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/9/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class LeftMenu: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.separatorColor = .white
        
        
    }
    
    
    
    
}


extension LeftMenu : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellLogo : cellLogo = tableView.dequeueReusableCell(withIdentifier: "cellLogo") as! cellLogo
            return cellLogo
        } else if indexPath.row == 1 {
            let cellHesap : cellHesap = tableView.dequeueReusableCell(withIdentifier: "cellHesap") as! cellHesap
            return cellHesap
        }else if indexPath.row == 2 {
            let cellAnaSayfa : cellAnaSayfa = tableView.dequeueReusableCell(withIdentifier: "cellAnaSayfa") as! cellAnaSayfa
            return cellAnaSayfa
        }else if indexPath.row == 3 {
            let cellKonum : cellKonum = tableView.dequeueReusableCell(withIdentifier: "cellKonum") as! cellKonum
            return cellKonum
        }else if indexPath.row == 4 {
            let cellDil : cellDil = tableView.dequeueReusableCell(withIdentifier: "cellDil") as! cellDil
            return cellDil
        }else if indexPath.row == 5 {
            let cellCik : cellCik = tableView.dequeueReusableCell(withIdentifier: "cellCik") as! cellCik
            return cellCik
        }else if indexPath.row == 6 {
            let cellKategori : cellKategori = tableView.dequeueReusableCell(withIdentifier: "cellKategori") as! cellKategori
            return cellKategori
        }else if indexPath.row == 7 {
            let cellMarket : cellMarket = tableView.dequeueReusableCell(withIdentifier: "cellMarket") as! cellMarket
            return cellMarket
        }else if indexPath.row == 8 {
            let cellEczane : cellEczane = tableView.dequeueReusableCell(withIdentifier: "cellEczane") as! cellEczane
            return cellEczane
        }else if indexPath.row == 9 {
            let cellOtel : cellOtel = tableView.dequeueReusableCell(withIdentifier: "cellOtel") as! cellOtel
            return cellOtel
        }else if indexPath.row == 10 {
            let cellBankamatik : cellBankamatik = tableView.dequeueReusableCell(withIdentifier: "cellBankamatik") as! cellBankamatik
            return cellBankamatik
        }else if indexPath.row == 11 {
            let cellPtt : cellPtt = tableView.dequeueReusableCell(withIdentifier: "cellPtt") as! cellPtt
            return cellPtt
        }else if indexPath.row == 12 {
            let cellBerber : cellBerber = tableView.dequeueReusableCell(withIdentifier: "cellBerber") as! cellBerber
            return cellBerber
        }else if indexPath.row == 13 {
            let cellRestoran : cellRestoran = tableView.dequeueReusableCell(withIdentifier: "cellRestoran") as! cellRestoran
            return cellRestoran
        }else if indexPath.row == 14 {
            let cellTerzi : cellTerzi = tableView.dequeueReusableCell(withIdentifier: "cellTerzi") as! cellTerzi
            return cellTerzi
        }
        
        let cellHesap : cellHesap = tableView.dequeueReusableCell(withIdentifier: "cellHesap") as! cellHesap
        return cellHesap
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //none
        }else if indexPath.row == 1 {
            //none
        }else if indexPath.row == 2 {
            self.dismiss(animated: true, completion: nil)
            
            
        }else if indexPath.row == 3 {
            
        }else if indexPath.row == 4 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
            vc.modalPresentationStyle = .fullScreen
            vc.isHiddenn = "false"
            self.present(vc, animated: true, completion: nil)
            
            
        }else if indexPath.row == 5 {
            let refreshAlert = UIAlertController(title: "Çıkış Yap", message: "Çıkıs yapmak istediğinizden eminmisiniz?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
                do {
                    try Auth.auth().signOut()
                    let login = SignIn()
                    login.modalPresentationStyle = .fullScreen
                    self.present(login, animated: true, completion: nil)
                    
                    
                } catch {
                    print("error")
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "İptal Et", style: .cancel, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
                self.view.endEditing(true)
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else if indexPath.row == 6 {
            
        }else if indexPath.row == 7 {
            //none
        }else if indexPath.row == 8 {
            
        }else if indexPath.row == 9 {
            
        }else if indexPath.row == 10 {
            
        }else if indexPath.row == 11 {
            
        }else if indexPath.row == 12 {
            
        }else if indexPath.row == 13 {
            
        }else if indexPath.row == 14 {
            
        }
    }
    
}
