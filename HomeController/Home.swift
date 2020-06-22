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
    
    var lblCommentAction : (()->())?
    
    var btnCommentAction : (()->())?
    
    var btnLikeAction : (()->())?
    
    var btnMapAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblComment.isUserInteractionEnabled = true
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(lblcommentAction))
        lblComment.addGestureRecognizer(gestureREcongizer)
        
        btnComment.addTarget(self, action: #selector(btncommentAction), for: .touchUpInside)
        
        btnLike.addTarget(self, action: #selector(btnlikeAction), for: .touchUpInside)
        
        btnMap.addTarget(self, action: #selector(btnmapAction), for: .touchUpInside)
        
        
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
    
}

class Home: UIViewController {
    
    var ref : DatabaseReference?
    
    var itemlist : [NSDictionary] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableview()
        addSubview()
        addConstraint()
        isHiddenControl()
        getitemfromDB()
        
        ref = Database.database().reference()
        
        let gesturereRecongizer = UITapGestureRecognizer(target: self, action: #selector(viewHiddenAction))
        view.addGestureRecognizer(gesturereRecongizer)
        
        //        menu = SideMenuNavigationController(rootViewController:LeftMenu())
        //        menu?.leftSide = true
        //        
        //        SideMenuManager.default.leftMenuNavigationController = menu
        //        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
       
        
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
        
    }
    
    func addConstraint() {
        _ = btnAdd.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 15))
        
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
       
        
        activityIndicator.merkezKonumlamdirmaSuperView()
        activityIndicator.startAnimating()
        
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
        if searching {
            return searchitemlist.count
        }
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : cell666 = tableView.dequeueReusableCell(withIdentifier: "cell666") as! cell666
        
        if searching {
            let value2 = self.searchitemlist[indexPath.row]
            
            let header = value2["header"] as? String ?? ""
            let description = value2["description"] as? String ?? ""
            let photourl = value2["photourl"] as? String ?? ""
            
            cell.lblName.text = header
            cell.lblAciklama.text = description
            cell.img.sd_setImage(with: URL(string: "\(photourl)"))
            activityIndicator.stopAnimating()
            cell.lblCommentAction = {
                () in
                print("lblComment")
            }
            
            cell.btnCommentAction = {
                () in
                print("btncomment")
            }
            
            cell.btnLikeAction = {
                () in
                print("btnlike")
            }
            
            cell.btnMapAction = {
                () in
                
                let latitude = value2["latitude"] as? Double ?? 0.0
                let longitude = value2["longitude"] as? Double ?? 0.0
               
                
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
            
        }else{
            let value2 = self.itemlist[indexPath.row]
            
            let header = value2["header"] as? String ?? ""
            let description = value2["description"] as? String ?? ""
            let photourl = value2["photourl"] as? String ?? ""
            
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
            
            cell.btnLikeAction = {
                () in
                print("btnlike")
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
            
        }
        
        
        return cell
    }
    
   
    
    func getitemfromDB(){
        
        let userRef = Database.database().reference().child("items")
        
        userRef.observe(.value, with: { (snapshot) in
            
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot //get first snapshot
                let value = snap.value as? NSDictionary //get second snapshot
                
                self.itemlist.append(value!)
                self.searchitemlist.append(value!)
                
            }
            
            //reverseni yeni bunu
            //            self.itemlist = self.itemlist.reversed()
            
            self.itemlist = self.itemlist.shuffled()
            self.searchitemlist = self.searchitemlist.shuffled()
            self.tableView.reloadData()
           
        })
        
    }
    
  
    
    
}

extension Home : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //searchitemlist = itemlist.filter({$0.prefix(searchText.count) == searchText})
       searching = true
              let filteredArray = searchitemlist.filter {
                  for key in $0.allKeys {
                      if let string = $0[key] as? String,
                          string.contains(searchText) {
                          return true
                      }
                  }
                 tableView.reloadData()
                  return false
              }
        
             
              
          }
    
}
