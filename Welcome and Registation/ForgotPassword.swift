//
//  ForgotPassword.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class ForgotPassword: UIViewController {
    
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
        lbl.text = "Şifremi unuttum"
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
    
    let btnForgotPassword: UIButton  = {
        let btn = UIButton(type: .system)
        btn.setTitle("ŞİFREMİ SIFIRLA", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customPink()
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(forgoPasswordAction), for: .touchUpInside)
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
    
    var alertMesaj : UILabel = {
        let alert = UILabel()
        alert.text = "Lütfen email adresinizi girniz"
        return alert
    }()
    
    var alertMesaj2 : UILabel = {
        let alert = UILabel()
        alert.text = "Email adresinize gönderdiğimiz linke tıklıyarak şifrenizi değişebilirsiniz"
        return alert
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [topView,centerView,bottomView])
        stackView.axis = .vertical
        
        scrolView.addSubview(stackView)
        _ = stackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        let stackView2 = UIStackView(arrangedSubviews: [txtEmail,btnForgotPassword])
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
        
        
        
    }
    
    func addSubview(){
        topView.addSubview(imgLogo)
        centerView.addSubview(btnLeft)
        centerView.addSubview(lblSignUp)
        centerView.addSubview(lineView)
        bottomView.addSubview(activityIndicator)
    }
    
    func addConstraint() {
        
        imgLogo.merkezKonumlamdirmaSuperView()
        
        _ = btnLeft.anchor(top: centerView.topAnchor, bottom: nil, leading: centerView.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        
        lblSignUp.topAnchor.constraint(equalTo: btnLeft.bottomAnchor).isActive = true
        lblSignUp.merkezXSuperView()
        
        _ = lineView.anchor(top: lblSignUp.bottomAnchor, bottom: centerView.bottomAnchor, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        _ = activityIndicator.anchor(top: txtEmail.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 30, left: 0, bottom: 0, right: 0))
        activityIndicator.merkezXSuperView()
        
        
    }
    
    
    
    @objc func leftAction() {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    func actionLanguageForgot_tr() {
        changeLanguage(str: "tr") // turkish
    }
    
    func actionLanguageForgot_de() {
        changeLanguage(str: "de") //german
    }
    
    
    func actionLanguageForgot_en() {
        changeLanguage(str: "en") // engilsh
    }
    
    
    func actionLanguageForgot_ar() {
        
        changeLanguage(str: "ar") //arabic
    }
    
    func actionLanguageForgot_ru() {
        changeLanguage(str: "ru")  //russian
    }
    
    func actionLanguageForgot_da() {
        changeLanguage(str: "da") //danish
    }
    
    func actionLanguageForgot_fr() {
           changeLanguage(str: "fr")  //frenc
       }
    
    func actionLanguageForgot_it() {
        changeLanguage(str: "it")  //italian
    }
    
    
    func actionLanguageForgot_nl() {
        changeLanguage(str: "nl")  //duct flemence
    }
    
    func changeLanguage(str:String)  {
        lblSignUp.text = "Şifremi unuttum".addLocalizableString(str: str)
        txtEmail.placeholder = "E-posta adresinizi giriniz".addLocalizableString(str: str)
        btnForgotPassword.setTitle("ŞİFREMİ SIFIRLA".addLocalizableString(str: str), for: .normal)
        
        alertMesaj.text = "Lütfen email adresinizi girniz".addLocalizableString(str: str)
        alertMesaj2.text = "Email adresinize gönderdiğimiz linke tıklıyarak şifrenizi değişebilirsiniz".addLocalizableString(str: str)
        
    }
    
    
    
    
    @objc func forgoPasswordAction() {
        if txtEmail.text == "" {
            self.makeAlert(tittle: "Error", message: alertMesaj.text!)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { error in
            self.makeAlert(tittle: "Succes", message: self.alertMesaj2.text!)
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        topView.isHidden = true
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        topView.isHidden = false
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
}
