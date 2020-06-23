//
//  AddImage.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class AddImage: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate  {
    
    var ref : DatabaseReference?
    
    var photoUrl : String?
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var contentViewSize2 = CGSize(width: self.view.frame.width, height: self.view.frame.height+310)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    let topView : UIView = {
        let view = UIView()
        view.backgroundColor = .customBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "left-arrow"), for: .normal)
        btn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lblIlanEkle : UILabel = {
        let lbl = UILabel()
        lbl.text = "İlan ekle"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let btnEkle : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .customPink()
        btn.setTitle("Ekle", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(ekleAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let centerView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 310).isActive = true
        return view
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgAdd : UIImageView = {
        let img = UIImageView(image: UIImage(named: "camera"))
        img.contentMode = .scaleAspectFit
        img.heightAnchor.constraint(equalToConstant: 300).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
        return img
    }()
    
    let txtBaslik : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txt.layer.cornerRadius = 10
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.attributedPlaceholder = NSAttributedString(string:   "Başlık", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        return txt
    }()
    
    let txtAciklama : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txt.layer.cornerRadius = 10
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.attributedPlaceholder = NSAttributedString(string: "Açıklama", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        return txt
    }()
    
    let txtKategori : OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txt.layer.cornerRadius = 10
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.attributedPlaceholder = NSAttributedString(string:  "Kategori?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return txt
    }()
    
    let imgDown : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "down-arrow"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return img
    }()
    
    var pickerView = UIPickerView()
    
    var kategoriArray = ["Market","Eczane","Otel","Bankamatik","Ptt","Berber","Restoran","Terzi"]
    var kategoriArrayEng = ["Market","Pharmacy","Hotel","ATM","Post","Barber","Restaurant","Tailor"]
    
    
    let btnKonumuSec : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.setImage(UIImage(named: "location-1"), for: .normal)
        btn.setTitle(" KONUMUNU İŞARETLE", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(konumunuSecAction), for: .touchUpInside)
        return btn
    }()
    
    var latidude1 = 0.0
    var longutide1 = 0.0
    let locationMaager = CLLocationManager()
    
    
    let mapView : UIView = {
        let view = UIView()
        view.backgroundColor = .customBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topViewMap : UIView = {
        let view = UIView()
        view.backgroundColor = .customBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    let btnLeftMap : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "left-arrow"), for: .normal)
        btn.addTarget(self, action: #selector(leftActionMap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnKonumKullan : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .customPink()
        btn.setTitle("KONUMUNU KULLAN", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(konumKullanAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return btn
    }()
    
    let lblKonum : UILabel = {
        let lbl = UILabel()
        lbl.text = "Seçmek istediğiniz konuma haritada tıklayın"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let map : MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    var selectedcategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        mapView.isHidden = true
        view.backgroundColor = .customBlue()
        stackView()
        addSubview()
        addConstraint()
        
        
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(pickerViewGizle))
        view.addGestureRecognizer(gestureREcongizer)
        
        let gestureRecongizer1 = UITapGestureRecognizer(target: self, action: #selector(imgSecAction))
        imgAdd.addGestureRecognizer(gestureRecongizer1)
        
        let gestureREcongizer2 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer2)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        txtKategori.inputView = pickerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        map.delegate = self
        locationMaager.delegate = self
        
        locationMaager.desiredAccuracy = kCLLocationAccuracyBest
        locationMaager.requestWhenInUseAuthorization()
        locationMaager.startUpdatingLocation()
        
        let gestureRecongizer3 = UITapGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecongizer:)))
        
        map.addGestureRecognizer(gestureRecongizer3)
        
        
        
    }
    
    
    func stackView() {
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [topView,centerView,bottomView])
        stackView.axis = .vertical
        
        containerView.addSubview(stackView)
        _ = stackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        let txtStackView = UIStackView(arrangedSubviews: [txtBaslik,txtAciklama,txtKategori,btnKonumuSec])
        txtStackView.axis = .vertical
        txtStackView.spacing = 5
        
        bottomView.addSubview(txtStackView)
        _ = txtStackView.anchor(top: bottomView.topAnchor, bottom: nil, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    func addSubview() {
        topView.addSubview(btnLeft)
        topView.addSubview(lblIlanEkle)
        topView.addSubview(btnEkle)
        view.addSubview(activityIndicator)
        centerView.addSubview(imgAdd)
        txtKategori.addSubview(imgDown)
        view.addSubview(mapView)
        mapView.addSubview(topViewMap)
        topViewMap.addSubview(btnLeftMap)
        topViewMap.addSubview(btnKonumKullan)
        topViewMap.addSubview(lblKonum)
        mapView.addSubview(map)
        
        
    }
    
    func addConstraint() {
        btnLeft.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 10).isActive = true
        btnLeft.merkezYSuperView()
        
        lblIlanEkle.merkezKonumlamdirmaSuperView()
        
        _ = btnEkle.anchor(top: topView.topAnchor, bottom: topView.bottomAnchor, leading: lblIlanEkle.trailingAnchor, trailing: topView.trailingAnchor,padding: .init(top: 10, left: 40, bottom: 10, right: 10))
        btnLeft.merkezYSuperView()
        
        activityIndicator.merkezKonumlamdirmaSuperView()
        
        
        _ = imgAdd.anchor(top: centerView.topAnchor, bottom: centerView.bottomAnchor, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor,padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        imgDown.trailingAnchor.constraint(equalTo: txtKategori.trailingAnchor,constant: -5).isActive = true
        imgDown.merkezYSuperView()
        
        _ = mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = topViewMap.anchor(top: mapView.topAnchor, bottom: nil, leading: mapView.leadingAnchor, trailing: mapView.trailingAnchor)
        
        btnLeftMap.leadingAnchor.constraint(equalTo: topViewMap.leadingAnchor,constant: 10).isActive = true
        btnLeftMap.merkezYSuperView()
        
        _ = btnKonumKullan.anchor(top: topViewMap.topAnchor, bottom: nil, leading: nil, trailing: topViewMap.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 5))
        
        _ = lblKonum.anchor(top: btnKonumKullan.bottomAnchor, bottom: nil, leading: nil, trailing: topViewMap.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 5))
        
        _ = map.anchor(top: topViewMap.bottomAnchor, bottom: mapView.bottomAnchor, leading: mapView.leadingAnchor, trailing: mapView.trailingAnchor)
        
        
    }
    
    
    
    
    @objc func leftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func ekleAction() {
        activityIndicator.startAnimating()
        if txtBaslik.text == "" {
            makeAlert(tittle: "Hata", message: "Lütfen başlık girniz")
            activityIndicator.stopAnimating()
            return
        }else if txtAciklama.text == "" {
            makeAlert(tittle: "Hata", message: "Lütfen açıklama girniz")
            activityIndicator.stopAnimating()
            return
        }else if txtKategori.text == "" {
            makeAlert(tittle: "Hata", message: "Lütfen kategori seçiniz")
            activityIndicator.stopAnimating()
            return
        }else if latidude1 == 0.0 && longutide1 == 0.0 {
            makeAlert(tittle: "Hata", message: "Lütfen konumu seçiniz")
            activityIndicator.stopAnimating()
            return
        }else if imgAdd.image == UIImage(named: "camera") {
            makeAlert(tittle: "Hata", message: "Lütfen ilanınız için fotoğraf seçiniz")
            activityIndicator.stopAnimating()
            return
        }
        
        
        let postid = Database.database().reference().child("items").childByAutoId().key
        
        let imagename = "images/\(postid!)/1.jpg"
        let storageRef = Storage.storage().reference().child("WorkPhoto").child(imagename)
        
        if let uploadData = imgAdd.image!.pngData() {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error:\(error.debugDescription)")
                    self.activityIndicator.stopAnimating()
                } else { //succesfully
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        
                        let photourl = url?.absoluteString
                        print("succes")
                        
                        self.photoUrl = photourl
                        
                        let userid = Auth.auth().currentUser!.uid
                        
                        
                        let items = Items(category: self.selectedcategory, description: self.txtAciklama.text!, header: self.txtBaslik.text!, itemid: postid!, latitude: self.latidude1, longitude: self.longutide1, photourl:self.photoUrl! , publisher: userid)
                        
                        let dict : [String:Any] = ["category":items.category!,"description":items.description!,"header":items.header!,"itemid":items.itemid!,"latitude":items.latitude!,"longitude":items.longitude!,"photourl":items.photourl!,"publisher":items.publisher!]
                        //itemid postid did yuxaridaki
                        let newRef = self.ref?.child("items").child(postid!)
                        newRef?.setValue(dict) {
                            (err, resp) in
                            guard err == nil else {
                                print("Posting failed : ")
                                self.activityIndicator.stopAnimating()
                                //self.btnSignUp.isHidden = false
                                return
                            }
                            self.activityIndicator.stopAnimating()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            
                            
                        }
                        
                        
                    })
                }
            }
        }
        
        
        
        
        
        
    }
    
    @objc func leftActionMap() {
        
        if !mapView.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.mapView.isHidden = true
                self.mapView.alpha = 0
            }
        }
    }
    
    @objc func konumunuSecAction() {
        if mapView.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.mapView.isHidden = false
                self.mapView.alpha = 1
            }
        }
        
    }
    
    @objc func pickerViewGizle() {
        view.endEditing(true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func imgSecAction() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }
    
    
    
    @objc func chooseLocation(gestureRecongizer : UITapGestureRecognizer) {
        
        let touchPoint = gestureRecongizer.location(in: self.map)
        let touchCordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCordinate
        
        
        if self.map.annotations.count == 0 {
            self.map.addAnnotation(annotation)
        }else {
            
            self.map.removeAnnotations(map.annotations)
            self.map.addAnnotation(annotation)
        }
        
        latidude1 = touchCordinate.latitude
        longutide1 = touchCordinate.longitude
        print("\(touchCordinate.latitude)")
        print("\(touchCordinate.longitude)")
        
        
    }
    @objc func konumKullanAction() {
        if latidude1 != 0.0 && longutide1 != 0.0 {
            UIView.transition(with: btnKonumuSec, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.btnKonumuSec.backgroundColor = .init(red: 0/255, green: 204/255, blue: 0/255, alpha: 1)
                self.btnKonumuSec.setImage(UIImage(named: "check"), for: .normal)
                self.btnKonumuSec.setTitle("KONUM İŞARETLENDİ", for: .normal)
                self.btnKonumuSec.setTitleColor(.white, for: .normal)
            }, completion: nil)
        }
        
        if !mapView.isHidden {
            UIView.animate(withDuration: 0.35) { [unowned self] in
                self.mapView.isHidden = true
                self.mapView.alpha = 0
            }
        }
        
        
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        scrolView.contentSize = contentViewSize2
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrolView.contentSize = contentViewSize
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategoriArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kategoriArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtKategori.text = kategoriArray[row]
        selectedcategory = kategoriArrayEng[row]
        txtKategori.resignFirstResponder()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgAdd.image =  info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

