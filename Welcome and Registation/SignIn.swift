//
//  SignIn.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
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
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    let lblSignIn: UILabel = {
        let lbl = UILabel()
        lbl.text = "Giriş Yap"
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
        txt.placeholder = "E-posta adresinizi giriniz"
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return txt
    }()
    
    let txtPassword: OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.placeholder = "Şifrenizi girin"
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txt.isSecureTextEntry = true
        return txt
    }()
    
    
    let btnForgotPassword: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("Şifreni mi unuttun ?", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(forgotPasswordAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnSignIn: UIButton  = {
        let btn = UIButton(type: .system)
        btn.setTitle("GİRİŞ YAP", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customPink()
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(signInpAction), for: .touchUpInside)
        return btn
    }()
    
    let btnSignUp: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("Hesabın yok mu ? Hemen oluştur!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [topView,centerView,bottomView])
        stackView.axis = .vertical
        
        scrolView.addSubview(stackView)
        
        _ = stackView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        let stackView2 = UIStackView(arrangedSubviews: [txtEmail,txtPassword])
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
    
    func addSubview() {
        
        topView.addSubview(imgLogo)
        
        centerView.addSubview(lblSignIn)
        centerView.addSubview(lineView)
        bottomView.addSubview(btnForgotPassword)
        bottomView.addSubview(btnSignIn)
        bottomView.addSubview(btnSignUp)
        bottomView.addSubview(activityIndicator)
        
    }
    
    func addConstraint() {

        imgLogo.merkezKonumlamdirmaSuperView()
        
        lblSignIn.topAnchor.constraint(equalTo: centerView.topAnchor,constant: 17).isActive = true
        lblSignIn.merkezXSuperView()
        
        _ = lineView.anchor(top: lblSignIn.bottomAnchor, bottom: centerView.bottomAnchor, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        _ = btnForgotPassword.anchor(top: txtPassword.bottomAnchor, bottom: nil, leading: nil, trailing: bottomView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
        _ = btnSignIn.anchor(top: btnForgotPassword.bottomAnchor, bottom: nil, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        _ = activityIndicator.anchor(top: btnForgotPassword.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        activityIndicator.merkezXSuperView()
        
        _ = btnSignUp.anchor(top: btnSignIn.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        btnSignUp.merkezXSuperView()
        
        
       
        
    }
    
    @objc func forgotPasswordAction() {
        let forgotpassword = ForgotPassword()
        forgotpassword.modalPresentationStyle = .fullScreen
        present(forgotpassword, animated: false, completion: nil)
    }
    
    @objc func signInpAction() {
        
        if txtEmail.text == "" {
            makeAlert(tittle: "Error", message: "Lütfen email adresinizi girniz")
            return
        }
        if txtPassword.text == "" {
           makeAlert(tittle: "Error", message: "Lütfen şifrenizi giriniz")
           return
        }
        
        btnSignIn.isHidden = true
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (authdata, error) in
            if(error != nil){
                self.makeAlert(tittle: "Error", message: "Giris yapilirken bir hata olustu")
                self.activityIndicator.stopAnimating()
                self.btnSignIn.isHidden = false
            }else{
                let splahs = SplashView()
                splahs.modalPresentationStyle = .fullScreen
                self.present(splahs, animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    @objc func signUpAction() {
        let signup = SignUp()
        signup.modalPresentationStyle = .fullScreen
        present(signup, animated: false, completion: nil)
        
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



