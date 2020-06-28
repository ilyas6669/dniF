//
//  LeftMenu.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/9/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit



class LeftMenu: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var mapView = MKMapView()
    
    var locationManager = CLLocationManager()
    
    var locationcontrol = false
    
    var lattitude = Double()
    var longitude = Double()
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.separatorColor = .white
        
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        lattitude = location.latitude
        longitude = location.latitude
    }
    
    
    
    
}


extension LeftMenu : UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 73
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
        }else if indexPath.row == 15 {
            let cellTerzi2 : cellTerzi2 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi2") as! cellTerzi2
            return cellTerzi2
        }else if indexPath.row == 16 {
            let cellTerzi3 : cellTerzi3 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi3") as! cellTerzi3
            return cellTerzi3
        }else if indexPath.row == 17 {
            let cellTerzi4 : cellTerzi4 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi4") as! cellTerzi4
            return cellTerzi4
        }else if indexPath.row == 18 {
            let cellTerzi5 : cellTerzi5 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi5") as! cellTerzi5
            return cellTerzi5
        }else if indexPath.row == 19 {
            let cellTerzi6 : cellTerzi6 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi6") as! cellTerzi6
            return cellTerzi6
        }else if indexPath.row == 20 {
            let cellTerzi7 : cellTerzi7 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi7") as! cellTerzi7
            return cellTerzi7
        }else if indexPath.row == 21 {
            let cellTerzi8 : cellTerzi8 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi8") as! cellTerzi8
            return cellTerzi8
        }else if indexPath.row == 22 {
            let cellTerzi9 : cellTerzi9 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi9") as! cellTerzi9
            return cellTerzi9
        }else if indexPath.row == 23 {
            let cellTerzi10 : cellTerzi10 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi10") as! cellTerzi10
            return cellTerzi10
        }else if indexPath.row == 24 {
            let cellTerzi11 : cellTerzi11 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi11") as! cellTerzi11
            return cellTerzi11
        }else if indexPath.row == 25 {
            let cellTerzi12 : cellTerzi12 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi12") as! cellTerzi12
            return cellTerzi12
        }else if indexPath.row == 26 {
            let cellTerzi13 : cellTerzi13 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi13") as! cellTerzi13
            return cellTerzi13
        }else if indexPath.row == 27 {
            let cellTerzi14 : cellTerzi14 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi14") as! cellTerzi14
            return cellTerzi14
        }else if indexPath.row == 28 {
            let cellTerzi15 : cellTerzi15 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi15") as! cellTerzi15
            return cellTerzi15
        }else if indexPath.row == 29 {
            let cellTerzi16 : cellTerzi16 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi16") as! cellTerzi16
            return cellTerzi16
        }else if indexPath.row == 30 {
            let cellTerzi17 : cellTerzi17 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi17") as! cellTerzi17
            return cellTerzi17
        }else if indexPath.row == 31 {
            let cellTerzi18 : cellTerzi18 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi18") as! cellTerzi18
            return cellTerzi18
        }else if indexPath.row == 32 {
            let cellTerzi19 : cellTerzi19 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi19") as! cellTerzi19
            return cellTerzi19
        }else if indexPath.row == 33 {
            let cellTerzi20 : cellTerzi20 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi20") as! cellTerzi20
            return cellTerzi20
        }else if indexPath.row == 34 {
            let cellTerzi21 : cellTerzi21 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi21") as! cellTerzi21
            return cellTerzi21
        }else if indexPath.row == 35 {
            let cellTerzi22 : cellTerzi22 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi22") as! cellTerzi22
            return cellTerzi22
        }else if indexPath.row == 36 {
            let cellTerzi23 : cellTerzi23 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi23") as! cellTerzi23
            return cellTerzi23
        }else if indexPath.row == 37 {
            let cellTerzi24 : cellTerzi24 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi24") as! cellTerzi24
            return cellTerzi24
        }else if indexPath.row == 38 {
            let cellTerzi25 : cellTerzi25 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi25") as! cellTerzi25
            return cellTerzi25
        }else if indexPath.row == 39 {
            let cellTerzi26 : cellTerzi26 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi26") as! cellTerzi26
            return cellTerzi26
        }else if indexPath.row == 40 {
            let cellTerzi27 : cellTerzi27 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi27") as! cellTerzi27
            return cellTerzi27
        }else if indexPath.row == 41 {
            let cellTerzi28 : cellTerzi28 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi28") as! cellTerzi28
            return cellTerzi28
        }else if indexPath.row == 42 {
            let cellTerzi29 : cellTerzi29 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi29") as! cellTerzi29
            return cellTerzi29
        }else if indexPath.row == 43 {
            let cellTerzi30 : cellTerzi30 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi30") as! cellTerzi30
            return cellTerzi30
        }else if indexPath.row == 44 {
            let cellTerzi31 : cellTerzi31 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi31") as! cellTerzi31
            return cellTerzi31
        }else if indexPath.row == 45 {
            let cellTerzi32 : cellTerzi32 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi32") as! cellTerzi32
            return cellTerzi32
        }else if indexPath.row == 46 {
            let cellTerzi33 : cellTerzi33 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi33") as! cellTerzi33
            return cellTerzi33
        }else if indexPath.row == 47 {
            let cellTerzi34 : cellTerzi34 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi34") as! cellTerzi34
            return cellTerzi34
        }else if indexPath.row == 48 {
            let cellTerzi35 : cellTerzi35 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi35") as! cellTerzi35
            return cellTerzi35
        }else if indexPath.row == 49 {
            let cellTerzi36 : cellTerzi36 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi36") as! cellTerzi36
            return cellTerzi36
        }else if indexPath.row == 50 {
            let cellTerzi37 : cellTerzi37 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi37") as! cellTerzi37
            return cellTerzi37
        }else if indexPath.row == 51 {
            let cellTerzi38 : cellTerzi38 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi38") as! cellTerzi38
            return cellTerzi38
        }else if indexPath.row == 52 {
            let cellTerzi39 : cellTerzi39 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi39") as! cellTerzi39
            return cellTerzi39
        }else if indexPath.row == 53 {
            let cellTerzi40 : cellTerzi40 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi40") as! cellTerzi40
            return cellTerzi40
        }else if indexPath.row == 54 {
            let cellTerzi41 : cellTerzi41 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi41") as! cellTerzi41
            return cellTerzi41
        }else if indexPath.row == 55 {
            let cellTerzi42 : cellTerzi42 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi42") as! cellTerzi42
            return cellTerzi42
        }else if indexPath.row == 56 {
            let cellTerzi43 : cellTerzi43 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi43") as! cellTerzi43
            return cellTerzi43
        }else if indexPath.row == 57 {
            let cellTerzi44 : cellTerzi44 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi44") as! cellTerzi44
            return cellTerzi44
        }else if indexPath.row == 58 {
            let cellTerzi45 : cellTerzi45 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi45") as! cellTerzi45
            return cellTerzi45
        }
        
        //------------------------------
        
        
        
        else if indexPath.row == 60 {
            let cellTerzi46 : cellTerzi46 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi46") as! cellTerzi46
            return cellTerzi46
        }else if indexPath.row == 61 {
            let cellTerzi47 : cellTerzi47 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi47") as! cellTerzi47
            return cellTerzi47
        }else if indexPath.row == 62 {
            let cellTerzi48 : cellTerzi48 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi48") as! cellTerzi48
            return cellTerzi48
        }else if indexPath.row == 63 {
            let cellTerzi49 : cellTerzi49 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi49") as! cellTerzi49
            return cellTerzi49
        }else if indexPath.row == 64 {
            let cellTerzi50 : cellTerzi50 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi50") as! cellTerzi50
            return cellTerzi50
        }else if indexPath.row == 65 {
            let cellTerzi51 : cellTerzi51 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi51") as! cellTerzi51
            return cellTerzi51
        }else if indexPath.row == 66 {
            let cellTerzi52 : cellTerzi52 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi52") as! cellTerzi52
            return cellTerzi52
        }else if indexPath.row == 68 {
            let cellTerzi53 : cellTerzi53 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi53") as! cellTerzi53
            return cellTerzi53
        }else if indexPath.row == 69 {
            let cellTerzi54 : cellTerzi54 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi54") as! cellTerzi54
            return cellTerzi54
        }else if indexPath.row == 70 {
            let cellTerzi55 : cellTerzi55 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi55") as! cellTerzi55
            return cellTerzi55
        }else if indexPath.row == 71 {
            let cellTerzi56 : cellTerzi56 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi56") as! cellTerzi56
            return cellTerzi56
        }else if indexPath.row == 72 {
            let cellTerzi57 : cellTerzi57 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi57") as! cellTerzi57
            return cellTerzi57
        }
        
        let cellTerzi : cellTerzi = tableView.dequeueReusableCell(withIdentifier: "cellTerzi") as! cellTerzi
        return cellTerzi
        
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
            
            Cache.filterkeyword = ""
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
                           
            self.dismiss(animated: true, completion: nil)
            
            
        }else if indexPath.row == 3 {
            //duzelis edecem......
            let userid = Auth.auth().currentUser!.uid
            var ref : DatabaseReference?
            ref = Database.database().reference().child("user").child(userid)
            
            let dict : [String:Any] = ["latitude":lattitude,"longitude":longitude]
            ref?.updateChildValues(dict)
                        
            
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
            
        }else {
            let kategoriArrayEng = ["Lawyer","Car Repair","Car Track","Hunting Equipment","Bank","Cash dispenser","Municipality","Barber","Petrol station","Computer","Bike","Household appliances","Cafe","Mobile phone","Florist","Child park","Class","Wedding","Pharmacy","Entertainment","Driving license","Electronic","Factory","Bakery","Hospital","Bath","Clothing","Beauty centre","Butcher","Stationery","Nursery","Consular","Cosmetic","Course Locations","Dry cleaner","Small Ad","Restaurant","Greengrocer","Massage","Carpenter","Market","Furniture","Accounting","Music","Population","School","Hotel","Car park","Organization","Private school","Patisserie","Police station","PTT","Restaurant","Moneychanger","Self-employment","Cinema","Insurance","Sport","Resort","Cleaning","Translation","Tailor","Wholesaler"]
            
            print("\(kategoriArrayEng[indexPath.row-7])")
            
            Cache.filterkeyword = "\(kategoriArrayEng[indexPath.row-7])"
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil) 
            self.dismiss(animated: true, completion: nil)
            
           }
            
        
    }
    
}
