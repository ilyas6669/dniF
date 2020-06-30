//
//  SignUp.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import DLRadioButton
import CoreLocation
import MapKit
import CoreData

class SignUp: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var ref : DatabaseReference?
    
    var mapView = MKMapView()
    
    var locationManager = CLLocationManager()
    
    var locationcontrol = false
    
    var lattitude = Double()
    var longitude = Double()
    var usertype = "owner"
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgLogo: UIImageView = {
        let img = UIImageView(image: UIImage(named: "FindTrasparant"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 140).isActive = true
        return img
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBlue()
        view.heightAnchor.constraint(equalToConstant: 75).isActive = true
        return view
    }()
    
    let btnLeft: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        return btn
    }()
    
    let lblSignUp: UILabel = {
        let lbl = UILabel()
        lbl.text = "Kayıt Ol"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customPink()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtEmail: OzelTextField  = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:  "E-posta adresinizi giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return txt
    }()
    
    let txtPassword: OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:  "Şifrenizi girin", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let txtPassword2: OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:  "Şifrenizi tekrar giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let viewRadio1 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return view
    }()
    
    let viewRadio2 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return view
    }()
    
    let btnRadio1 : DLRadioButton = {
        let btn = DLRadioButton()
        btn.setTitle("İş yeri sahibiyim", for: .normal)
        btn.iconColor = UIColor.customPurple()
        btn.indicatorColor = UIColor.customPurple()
        btn.setTitleColor(.black, for: .normal)
        btn.iconSize = CGFloat.init(20.0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(radioAction), for: .touchUpInside)
        btn.isSelected = true
        return btn
    }()
    
    let btnRadio2 : DLRadioButton = {
        let btn = DLRadioButton()
        btn.setTitle("İş yeri sahibi değilim", for: .normal)
        btn.iconColor = UIColor.customPurple()
        btn.indicatorColor = UIColor.customPurple()
        btn.setTitleColor(.black, for: .normal)
        var cgFloatValue:CGFloat  = 20.0
        btn.iconSize = CGFloat.init(cgFloatValue)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(radioAction2), for: .touchUpInside)
        return btn
    }()
    
    let btnLocation: UIButton = {
        let btn = UIButton(type: .system)
        let icon = UIImage(named: "location")!
        btn.setImage(icon, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        btn.setTitle("KONUMUNU BELİRLE", for: .normal)
        btn.setTitleColor(.customBlue(), for: .normal)
        btn.backgroundColor = .white
        //btn.layer.cornerRadius = 23
        btn.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    let btnSignUp: UIButton  = {
        let btn = UIButton(type: .system)
        btn.setTitle("KAYIT OL", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customPink()
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return btn
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let alertMesaj : UILabel = {
       let alert = UILabel()
        alert.text = "Lütfen email adresinizi girniz"
        return alert
    }()
    
    let alertParola : UILabel = {
        let alert = UILabel()
        alert.text = "Lütfen şifrenizi giriniz"
        return alert
    }()
    
    let alertParola2 : UILabel = {
        let alert = UILabel()
        alert.text = "Lütfen şifrenizi tekrar giriniz"
        return alert
    }()
    
    let alertParolerror : UILabel = {
        let alert = UILabel()
        alert.text = "Girdiğiniz şifreler aynı değil"
        return alert
    }()
    
    let alertKonum : UILabel = {
        let alert = UILabel()
        alert.text = "Lutfen konumunuzu belirleyin"
        return alert
    }()
    
    var country = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        if country == "tr" {
            actionLanguageSignUp_tr()
            print("tr")
        } else if country == "de" {
            actionLanguageSignUp_de()
        }else if country == "en" {
            actionLanguageSignUp_en()
        }else if country == "ar" {
            actionLanguageSignUp_ar()
        }else if country == "ru" {
            actionLanguageSignUp_ru()
        }else if country == "da" {
            actionLanguageSignUp_da()
        }else if country == "fr" {
            actionLanguageSignUp_fr()
        }else if country == "it" {
            actionLanguageSignUp_it()
        }else if country == "nl" {
            actionLanguageSignUp_nl()
        }
        
        
        view.backgroundColor = .black
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [topView,centerView,bottomView])
        stackView.axis = .vertical
        
        scrolView.addSubview(stackView)
        _ = stackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        let stackView3 = UIStackView(arrangedSubviews: [viewRadio1,viewRadio2])
        stackView3.axis = .horizontal
        stackView3.spacing = 5
        stackView3.distribution = .fillEqually
        
        let stackView2 = UIStackView(arrangedSubviews: [txtEmail,txtPassword,txtPassword2,btnLocation,stackView3,btnSignUp])
        stackView2.axis = .vertical
        stackView2.spacing = 10
        bottomView.addSubview(stackView2)
        _ = stackView2.anchor(top: bottomView.topAnchor, bottom: nil, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        addSubview()
        addConstraint()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer)
        
        for radioButton in self.btnRadio1.otherButtons {
            radioButton.isSelected = true
        }
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        ref = Database.database().reference()
        
    }
    
    func addSubview(){
        topView.addSubview(imgLogo)
        centerView.addSubview(btnLeft)
        centerView.addSubview(lblSignUp)
        centerView.addSubview(lineView)
        viewRadio1.addSubview(btnRadio1)
        viewRadio2.addSubview(btnRadio2)
        bottomView.addSubview(activityIndicator)
        
    }
    
    func addConstraint() {
        
        imgLogo.merkezKonumlamdirmaSuperView()
        
        _ = btnLeft.anchor(top: centerView.topAnchor, bottom: nil, leading: centerView.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        lblSignUp.topAnchor.constraint(equalTo: btnLeft.bottomAnchor).isActive = true
        lblSignUp.merkezXSuperView()
        
        _ = lineView.anchor(top: lblSignUp.bottomAnchor, bottom: centerView.bottomAnchor, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        btnRadio1.leadingAnchor.constraint(equalTo: viewRadio1.leadingAnchor).isActive = true
        btnRadio1.trailingAnchor.constraint(equalTo: viewRadio1.trailingAnchor).isActive = true
        btnRadio1.merkezYSuperView()
        
        btnRadio2.leadingAnchor.constraint(equalTo: viewRadio2.leadingAnchor).isActive = true
        btnRadio2.trailingAnchor.constraint(equalTo: viewRadio2.trailingAnchor).isActive = true
        btnRadio2.merkezYSuperView()
        
        _ = activityIndicator.anchor(top: viewRadio1.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 35, left: 0, bottom: 0, right: 0))
        activityIndicator.merkezXSuperView()
        
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results =  try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let country = result.value(forKey: "country") as? String {
                    //self.countryArray.append(country)
                    self.country = country
                }
            }
            print("request")
        }catch{
            print("error")
        }
        
    }
    
    
    
    
    @objc func leftAction() {
        self.dismiss(animated: false, completion: nil)
    }
    
   
    
    func actionLanguageSignUp_tr() {
        changeLanguage(str: "tr") // turkish
    }
    
    func actionLanguageSignUp_de() {
        changeLanguage(str: "de") //german
    }
    
    
    func actionLanguageSignUp_en() {
        changeLanguage(str: "en") // engilsh
    }
    
    
    func actionLanguageSignUp_ar() {
        
        changeLanguage(str: "ar") //arabic
    }
    
    func actionLanguageSignUp_ru() {
        changeLanguage(str: "ru")  //russian
    }
    
    func actionLanguageSignUp_da() {
        changeLanguage(str: "da") //danish
    }
    
    func actionLanguageSignUp_fr() {
        changeLanguage(str: "fr")  //frenc
    }
    
    func actionLanguageSignUp_it() {
        changeLanguage(str: "it")  //italian
    }
    
       
       func actionLanguageSignUp_nl() {
           changeLanguage(str: "nl")  //duct flemence
       }
    
    func changeLanguage(str:String)  {
        lblSignUp.text = "Kayıt Ol".addLocalizableString(str: str)
        txtEmail.placeholder = "E-posta adresinizi giriniz".addLocalizableString(str: str)
        txtPassword.placeholder = "Şifrenizi girin".addLocalizableString(str: str)
        txtPassword2.placeholder = "Şifrenizi tekrar girin".addLocalizableString(str: str)
        
        
        btnLocation.setTitle("KONUMUNU BELİRLE".addLocalizableString(str: str), for: .normal)
        btnRadio1.setTitle("İş yeri sahibiyim".addLocalizableString(str: str), for: .normal)
        btnRadio2.setTitle("İş yeri sahibi değilim".addLocalizableString(str: str), for: .normal)
        btnSignUp.setTitle("KAYIT OL".addLocalizableString(str: str), for: .normal)
        
        
        alertMesaj.text = "Lütfen email adresinizi girniz".addLocalizableString(str: str)
        alertParola.text = "Lütfen şifrenizi giriniz".addLocalizableString(str: str)
        alertParola2.text = "Giris yapilirken bir hata oluştu".addLocalizableString(str: str)
        alertParolerror.text = "Girdiğiniz şifreler aynı değil".addLocalizableString(str: str)
        alertKonum.text =  "Lutfen konumunuzu belirleyin".addLocalizableString(str: str)
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                lattitude = location.latitude
                longitude = location.latitude
           }
    
   
    @objc func locationAction() {
        locationcontrol = true
        
        UIView.transition(with: btnLocation, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.btnLocation.setImage(UIImage(named: "check"), for: .normal)
            self.btnLocation.setTitle("TAMAMLANDI",for: .normal)
            self.btnLocation.setTitleColor(.white, for: .normal)
            self.btnLocation.backgroundColor = .init(red: 0/255, green: 204/255, blue: 0/255, alpha: 1)
        }, completion: nil)
        
        
    }
    
  
    @objc func radioAction(sender:DLRadioButton) {
        var buttons = [DLRadioButton]()
        buttons.append(btnRadio1)
        buttons.append(btnRadio2)
        for button in buttons {
            
            button.isSelected = false
            
        }
        usertype = "owner"
        sender.isSelected = true
        
    }
    
    @objc func radioAction2(sender:DLRadioButton) {
        var buttons = [DLRadioButton]()
        buttons.append(btnRadio1)
        buttons.append(btnRadio2)
        for button in buttons {
            
            button.isSelected = false
            
        }
        usertype = "user"
        sender.isSelected = true
        
    }
    @objc func signUpAction() {
        btnSignUp.isHidden = true
        activityIndicator.startAnimating()
        if txtEmail.text == "" {
            makeAlert(tittle: "Hata", message: alertMesaj.text!)
            activityIndicator.stopAnimating()
            btnSignUp.isHidden = false
            return
        } else if txtPassword.text == "" {
            makeAlert(tittle: "Hata", message: alertParola.text!)
            activityIndicator.stopAnimating()
              btnSignUp.isHidden = false
            return
        } else if txtPassword2.text == "" {
            makeAlert(tittle: "Hata", message: alertParola2.text!)
            activityIndicator.stopAnimating()
              btnSignUp.isHidden = false
            return
        } else if txtPassword.text != txtPassword2.text{
            makeAlert(tittle: "Hata", message: alertParolerror.text!)
            activityIndicator.stopAnimating()
              btnSignUp.isHidden = false
            return
        } else if locationcontrol == false {
            makeAlert(tittle: "Error", message: alertKonum.text!)
            activityIndicator.stopAnimating()
              btnSignUp.isHidden = false
            return
        }

        let email = txtEmail.text
        let password = txtPassword.text


        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if let _eror = error {
                self.makeAlert(tittle: "Error", message: _eror.localizedDescription)
                self.activityIndicator.stopAnimating()
                self.btnSignUp.isHidden = false
            }else{
                let userid = Auth.auth().currentUser!.uid
                let newUser = User(email: email!, latitude: self.lattitude, longitude: self.longitude, userid: userid, usertype: self.usertype)
                let dict : [String:Any] = ["email":newUser.email!,"latitude":newUser.latitude!,"longitude":newUser.longitude!,"userid":newUser.userid!,"usertype":newUser.usertype!]
                self.activityIndicator.stopAnimating()
                self.btnSignUp.isHidden = false

                let newRef = self.ref?.child("user").child(userid)
                newRef?.setValue(dict) {
                    (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        self.activityIndicator.stopAnimating()
                        self.btnSignUp.isHidden = false
                        return
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }

            }
        }

        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //scrolView.contentSize = contentViewSize2
        topView.isHidden = true
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //scrolView.contentSize = contentViewSize
        topView.isHidden = false
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
}





