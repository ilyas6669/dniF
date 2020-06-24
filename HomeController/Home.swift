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
import MapKit


class cell666 : UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAciklama: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnMap: UIButton!
    
    
    @IBOutlet weak var btnEdit: UIButton!
    
    
    var lblCommentAction : (()->())?
    
    var btnCommentAction : (()->())?
    
    var btnLikeAction : (()->())?
    
    var btnMapAction : (()->())?
    
    var btnEditAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblComment.isUserInteractionEnabled = true
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(lblcommentAction))
        lblComment.addGestureRecognizer(gestureREcongizer)
        
        btnComment.addTarget(self, action: #selector(btncommentAction), for: .touchUpInside)
        
        btnLike.addTarget(self, action: #selector(btnlikeAction), for: .touchUpInside)
        
        btnMap.addTarget(self, action: #selector(btnmapAction), for: .touchUpInside)
        
        btnEdit.addTarget(self, action: #selector(btneditAction), for: .touchUpInside)
        
        btnEdit.isHidden = true
    }
    
    @objc func lblcommentAction() {
        lblCommentAction?()
    }
    
    @objc func btncommentAction() {
        btnCommentAction?()
    }
    
    @objc func btnlikeAction() {
        btnLikeAction?()
    }
    
    @objc func btnmapAction() {
        btnMapAction?()
    }
    
    @objc func btneditAction() {
        btnEditAction?()
    }
    
}

//burdan
class Home: UIViewController {
    
    var ref : DatabaseReference?
    
    @objc var itemlist : [NSDictionary] = []
    
    var searchitemlist : [NSDictionary] = []
    
    
    
    
    var searching = false
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let btnAdd : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "AAdd"), for: .normal)
        btn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    var menu : SideMenuNavigationController?
    
    let languageView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    let annotationTitle = ""
    
    let btnTurkey : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "turkey"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(turkeyAction), for: .touchUpInside)
        return btn
    }()
    
    let btnGermany : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "germany"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(germanyAction), for: .touchUpInside)
        return btn
    }()
    
    let btnUk : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "uk"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ukAction), for: .touchUpInside)
        return btn
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView = UIStackView()
    
    var isHiddenn = ""
    
    let bulunmadiView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bulunamadiImg : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "alert"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let bulunamadiLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Hiç bir şey bulunamadı."
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //________NOTIFICATION
    @objc func onReceiveData(_ notification:Notification) {
        getitemfromDB(query: "", categoryfilter: Cache.filterkeyword)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReceiveData"), object: nil)
    }
    //--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //________NOTIFICATION
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveData(_:)), name: NSNotification.Name(rawValue: "ReceiveData"), object: nil)
        //--------------------
        
        tableview()
        addSubview()
        addConstraint()
        isHiddenControl()
        getuserinfo()
        getitemfromDB(query: "", categoryfilter: "")
        
        ref = Database.database().reference()
        
        let gesturereRecongizer = UITapGestureRecognizer(target: self, action: #selector(viewHiddenAction))
        view.addGestureRecognizer(gesturereRecongizer)
        
        //        menu = SideMenuNavigationController(rootViewController:LeftMenu())
        //        menu?.leftSide = true
        //        
        //        SideMenuManager.default.leftMenuNavigationController = menu
        //        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        searchitemlist = itemlist
        btnAdd.isHidden = true
    }
    
    
    func tableview() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        searchBar.delegate = self
        
    }
    
    func addSubview() {
        view.addSubview(btnAdd)
        view.addSubview(visualEffectView)
        
        stackView.addArrangedSubview(btnTurkey)
        stackView.addArrangedSubview(lineView1)
        stackView.addArrangedSubview(btnGermany)
        stackView.addArrangedSubview(lineView2)
        stackView.addArrangedSubview(btnUk)
        stackView.axis = .horizontal
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.merkezKonumlamdirmaSuperView()
        
        view.addSubview(activityIndicator)
        
        bulunmadiView.isHidden = true
        view.addSubview(bulunmadiView)
        bulunmadiView.addSubview(bulunamadiImg)
        bulunmadiView.addSubview(bulunamadiLbl)
    }
    
    func addConstraint() {
        _ = btnAdd.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 15))
        
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        
        activityIndicator.merkezKonumlamdirmaSuperView()
        activityIndicator.startAnimating()
        
        _ = bulunmadiView.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        bulunamadiImg.merkezKonumlamdirmaSuperView()
        
        _ = bulunamadiLbl.anchor(top: bulunamadiImg.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        bulunamadiLbl.merkezXSuperView()
        
    }
    
    func isHiddenControl() {
        if isHiddenn == "" {
            visualEffectView.isHidden = true
            stackView.isHidden = true
        }else{
            
        }
        
        
    }
    
    @objc func viewHiddenAction() {
        view.endEditing(true)
        stackView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.stackView.alpha = 0
            self.visualEffectView.alpha = 0
            self.stackView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.stackView.removeFromSuperview()
        }
        
    }
    
    
    
    @IBAction func btnLeftAction(_ sender: Any) {
        //        present(menu!, animated: true, completion: nil)
    }
    
    @objc func addAction() {
        let addimage = AddImage()
        addimage.modalPresentationStyle = .fullScreen
        present(addimage, animated: true, completion: nil)
    }
    
    
    @objc func turkeyAction() {
        print("turk")
        let settingsURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
    
    @objc func germanyAction() {
        print("german")
    }
    
    @objc func ukAction() {
        print("uk")
    }
    
    //    func changeLanguage(str:String) -> String {
    //
    //    }
    
    
}

extension String {
    func addLocalizableString(str:String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "Test")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


extension Home : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : cell666 = tableView.dequeueReusableCell(withIdentifier: "cell666") as! cell666
        let value2 = self.itemlist[indexPath.row]

        let itemid = value2["itemid"] as? String ?? ""
        let header = value2["header"] as? String ?? ""
        let description = value2["description"] as? String ?? ""
        let photourl = value2["photourl"] as? String ?? ""
        let publisher = value2["publisher"] as? String ?? ""

       
        let userid = Auth.auth().currentUser!.uid
        if publisher == userid {
            cell.btnEdit.isHidden = false
        }else {
            cell.btnEdit.isHidden = true
        }
        
        cell.lblName.text = header
        cell.lblAciklama.text = description
        cell.img.sd_setImage(with: URL(string: "\(photourl)"))
        activityIndicator.stopAnimating()
        cell.lblCommentAction = {
            () in
            print("lblComment")
            let comment = CommentView()
            comment.modalPresentationStyle = .fullScreen
            self.present(comment, animated: true, completion: nil)
        }
        
        cell.btnCommentAction = {
            () in
            print("btncomment")
            let comment = CommentView()
            comment.modalPresentationStyle = .fullScreen
            self.present(comment, animated: true, completion: nil)
        }
        
        //LIKE COUNTER_____________________________
         let userRef = Database.database().reference().child("itemLikes").child(itemid)

            userRef.observe(.value, with: { (snapshot) in

               
                cell.lblLike.text = "\(snapshot.childrenCount) beğenme"
                
               
                

            }) { (error) in
                print(error.localizedDescription)
            }


        
        //LIKE_____________________________________
        checklikestatus(itemid: itemid, button: cell.btnLike)
        
        cell.btnLikeAction = {
            () in

            let tagstatus = cell.btnLike.tag
                   let userID = Auth.auth().currentUser?.uid

              

                   if(tagstatus==0){
                       Database.database().reference().child("itemLikes").child(itemid).child(userID!).setValue(true)
                   }else{
                    Database.database().reference().child("itemLikes").child(itemid).child(userID!).removeValue()
                   }
            
            
        }
        
        cell.btnMapAction = {
            () in
            let latitude = value2["latitude"] as? Double ?? 0.0
            let longitude = value2["longitude"] as? Double ?? 0.0
            print("ilyas\(latitude)")
            print("ilyas\(longitude)")
            
            var requestLocation = CLLocation(latitude: latitude, longitude: longitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
                
            }
            
            
        }
        
        cell.btnEditAction = {
            () in
            let alert = UIAlertController(title: "Sil", message: "Paylaşımınızı silmek mi istiyorsunuz?", preferredStyle: .actionSheet)
            let silAction = UIAlertAction(title: "Paylaşımı sil", style: .default) { (action) in
              
                var ref : DatabaseReference?
                var ref2 : DatabaseReference?
                var ref3 : DatabaseReference?
                
                ref = Database.database().reference().child("items").child(itemid)
                ref!.removeValue()
                
                ref2 = Database.database().reference().child("itemLikes").child(itemid)
                ref2!.removeValue()
                
                
                ref3 = Database.database().reference().child("itemsComments").child(itemid)
                ref3!.removeValue()
                
               
            }
            let iptalAction = UIAlertAction(title: "İptal Et", style: .cancel, handler: nil)
            
            alert.addAction(silAction)
            alert.addAction(iptalAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        return cell
    }
    
    func checklikestatus(itemid:String,button:UIButton){

           let userID = Auth.auth().currentUser?.uid

        let userRef = Database.database().reference().child("itemLikes").child(itemid)

           userRef.observe(.value, with: { (snapshot) in

            if(snapshot.hasChild(userID!)){
                   button.setImage(UIImage(named: "heart2"), for: .normal)
                   button.tag = 1
               }else{
                   button.setImage(UIImage(named: "heart"), for: .normal)
                   button.tag = 0
               }

           }) { (error) in
               print(error.localizedDescription)
           }


       }
    
    
    func getitemfromDB(query : String,categoryfilter : String){
        
        let userRef = Database.database().reference().child("items")
        
        userRef.observe(.value, with: { (snapshot) in
            
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                
                let category = value!["category"] as? String ?? ""
                let header = value!["header"] as? String ?? ""
                
                var addcontrol = true
                
                //search filter
                if query != "" && !header.lowercased().contains(query){
                    addcontrol = false
                }
                
                //category filter
                if categoryfilter != "" && category != categoryfilter{
                    addcontrol = false
                }
                
                
                if(addcontrol){
                    self.itemlist.append(value!)
                    self.searchitemlist.append(value!)
                }
                
            }
            
            
            //itemlist size control
            if self.itemlist.count == 0 { //urun yoxdu
                self.bulunmadiView.isHidden = false
            }else{ //urun var
                self.bulunmadiView.isHidden = true
            }
            
            self.itemlist = self.itemlist.shuffled()
            self.searchitemlist = self.searchitemlist.shuffled()
            self.tableView.reloadData()
            
        })
        
    }
    
    func getuserinfo(){
        
        let userid = Auth.auth().currentUser!.uid
        let userRef = Database.database().reference().child("user").child(userid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let usertype = value?["usertype"] as? String ?? ""
            
            if usertype == "owner"{
                self.btnAdd.isHidden = false
            }else{
                self.btnAdd.isHidden = true
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
}

extension Home : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //texniki xetadi:D deyan bidene
        getitemfromDB(query: (searchBar.text?.lowercased())!, categoryfilter: Cache.filterkeyword)
         searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
        getitemfromDB(query: "", categoryfilter: Cache.filterkeyword)
        }
        
    
    }
    
}



