//
//  SignIn.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/2/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class SignIn: UIViewController, UITextFieldDelegate {
    
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
        txt.attributedPlaceholder = NSAttributedString(string: "E-posta adresinizi giriniz", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return txt
    }()
    
    let txtPassword: OzelTextField = {
        let txt = OzelTextField()
        txt.backgroundColor = .white
        txt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txt.isSecureTextEntry = true
        txt.attributedPlaceholder = NSAttributedString(string: "Şifrenizi girin", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
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
    
    var alertMesaj : UILabel = {
        let alert = UILabel()
        alert.text = "Lütfen email adresinizi girniz"
        return alert
    }()
    var alertParola : UILabel = {
       let alert = UILabel()
        alert.text = "Lütfen şifrenizi giriniz"
        return alert
    }()
    var alertHata : UILabel = {
       let alert = UILabel()
        alert.text = "Giris yapilirken bir hata oluştu"
        return alert
    }()
    
    let btnChangeLanguage : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "turkey"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnLanguageAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return btn
    }()
    
    
       let visualEffectView : UIVisualEffectView = {
           let blurEffect = UIBlurEffect(style: .dark)
           let view = UIVisualEffectView(effect: blurEffect)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       
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
       
       let btnAlgeri : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "algeria"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(algeriAction), for: .touchUpInside)
           return btn
       }()
       
       let btnRussia : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "russia"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(russiaAction), for: .touchUpInside)
           return btn
       }()
       
       let btnDenmark : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "denmark"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(denmarkAction), for: .touchUpInside)
           return btn
       }()
       
       let btnFrench : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "french"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(frenchAction), for: .touchUpInside)
           return btn
       }()
       
       let btnItaly : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "italy"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(italyAction), for: .touchUpInside)
           return btn
       }()
       
       let btnHolland : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "holland"), for: .normal)
           btn.translatesAutoresizingMaskIntoConstraints = false
           btn.addTarget(self, action: #selector(hollandAction), for: .touchUpInside)
           return btn
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
       
       let lineView3 : UIView = {
           let view = UIView()
           view.backgroundColor = .white
           view.heightAnchor.constraint(equalToConstant: 70).isActive = true
           view.widthAnchor.constraint(equalToConstant: 2).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let lineView4 : UIView = {
           let view = UIView()
           view.backgroundColor = .white
           view.heightAnchor.constraint(equalToConstant: 70).isActive = true
           view.widthAnchor.constraint(equalToConstant: 2).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let lineView5 : UIView = {
           let view = UIView()
           view.backgroundColor = .white
           view.heightAnchor.constraint(equalToConstant: 70).isActive = true
           view.widthAnchor.constraint(equalToConstant: 2).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let lineView6 : UIView = {
           let view = UIView()
           view.backgroundColor = .white
           view.heightAnchor.constraint(equalToConstant: 70).isActive = true
           view.widthAnchor.constraint(equalToConstant: 2).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       
       let stack = UIStackView()
       
       let stack2 = UIStackView()
       
       let stack3 = UIStackView()
    
     var country = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        if country == "tr" {
            actionLanguageSignIn_tr()
            btnChangeLanguage.setImage(UIImage(named: "turkey"), for: .normal)
            print("tr")
        } else if country == "de" {
            actionLanguageSignIn_de()
             btnChangeLanguage.setImage(UIImage(named: "germany"), for: .normal)
        }else if country == "en" {
            actionLanguageSignIn_en()
             btnChangeLanguage.setImage(UIImage(named: "uk"), for: .normal)
        }else if country == "ar" {
            actionLanguageSignIn_ar()
             btnChangeLanguage.setImage(UIImage(named: "algeria"), for: .normal)
        }else if country == "ru" {
            actionLanguageSignIn_ru()
             btnChangeLanguage.setImage(UIImage(named: "russia"), for: .normal)
        }else if country == "da" {
            actionLanguageSignIn_da()
             btnChangeLanguage.setImage(UIImage(named: "denmark"), for: .normal)
        }else if country == "fr" {
            actionLanguageSignIn_fr()
             btnChangeLanguage.setImage(UIImage(named: "french"), for: .normal)
        }else if country == "it" {
            actionLanguageSignIn_it()
             btnChangeLanguage.setImage(UIImage(named: "italy"), for: .normal)
        }else if country == "nl" {
            actionLanguageSignIn_nl()
             btnChangeLanguage.setImage(UIImage(named: "holland"), for: .normal)
        }
              
        
        
        
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
        
        let gesturereRecongizer2 = UITapGestureRecognizer(target: self, action: #selector(viewHiddenAction))
        view.addGestureRecognizer(gesturereRecongizer2)
        
        view.addSubview(visualEffectView)
        
        stack.addArrangedSubview(btnTurkey)
        stack.addArrangedSubview(lineView1)
        stack.addArrangedSubview(btnGermany)
        stack.addArrangedSubview(lineView2)
        stack.addArrangedSubview(btnUk)
        
        stack2.addArrangedSubview(btnAlgeri)
        stack2.addArrangedSubview(lineView3)
        stack2.addArrangedSubview(btnRussia)
        stack2.addArrangedSubview(lineView4)
        stack2.addArrangedSubview(btnDenmark)
        
        stack3.addArrangedSubview(btnFrench)
        stack3.addArrangedSubview(lineView5)
        stack3.addArrangedSubview(btnItaly)
        stack3.addArrangedSubview(lineView6)
        stack3.addArrangedSubview(btnHolland)
        
        
        stack.axis = .horizontal
        stack.spacing = 10
        
        stack2.axis = .horizontal
        stack2.spacing = 10
        
        stack3.axis = .horizontal
        stack3.spacing = 10
        
        view.addSubview(stack)
        view.addSubview(stack2)
        view.addSubview(stack3)
        
        
        stack2.merkezKonumlamdirmaSuperView()
        
        _ = stack.anchor(top: nil, bottom: stack2.topAnchor, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        stack.merkezXSuperView()
        
        _ = stack3.anchor(top: stack2.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        stack3.merkezXSuperView()
        
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       
        visualEffectView.isHidden = true
        stack.isHidden = true
        stack2.isHidden = true
        stack3.isHidden = true
        
        txtPassword.delegate = self
        txtEmail.delegate = self
        
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
         txtPassword.resignFirstResponder()
        return true
    }
    
    @objc func btnLanguageAction() {
        visualEffectView.isHidden = false
        stack.isHidden = false
        stack2.isHidden = false
        stack3.isHidden = false
    }
    
    func addSubview() {
        
        topView.addSubview(imgLogo)
        
        centerView.addSubview(lblSignIn)
        centerView.addSubview(lineView)
        bottomView.addSubview(btnForgotPassword)
        bottomView.addSubview(btnSignIn)
        bottomView.addSubview(btnSignUp)
        bottomView.addSubview(activityIndicator)
        bottomView.addSubview(btnChangeLanguage)
        
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
        
        _ = btnChangeLanguage.anchor(top: nil, bottom: bottomView.bottomAnchor, leading :nil, trailing: bottomView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 15))
        
       
        
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
    
 
    
    @objc func viewHiddenAction() {
        visualEffectView.isHidden = true
        stack.isHidden = true
        stack2.isHidden = true
        stack3.isHidden = true
        
        
    }
    
    
    @objc func turkeyAction() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("tr", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
        
      }
      
      @objc func germanyAction() {
          
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("de", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
          
      }
      
      @objc func ukAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("en", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func algeriAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("ar", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func russiaAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("ru", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func denmarkAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("da", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func frenchAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("fr", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func italyAction() {
          
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("it", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
      
      @objc func hollandAction() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          
          let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
          
          newLanguage.setValue("nl", forKey: "country")
          
          do {
              try context.save()
              print("save")
          }catch {
              print("erro")
          }
          
          let splashView = SplashView()
          splashView.modalPresentationStyle = .fullScreen
          self.present(splashView, animated: true, completion: nil)
      }
    
    @objc func forgotPasswordAction() {
        
        let forgotpassword = ForgotPassword()
        forgotpassword.modalPresentationStyle = .fullScreen
        present(forgotpassword, animated: false, completion: nil)
    }
    
    
    func actionLanguageSignIn_tr() {
        changeLanguage(str: "tr") // turkish
    }
    
    func actionLanguageSignIn_de() {
        changeLanguage(str: "de") //german
    }
    
    
    func actionLanguageSignIn_en() {
        changeLanguage(str: "en") // engilsh
    }
    
    
    func actionLanguageSignIn_ar() {
        
        changeLanguage(str: "ar") //arabic
    }
    
    func actionLanguageSignIn_ru() {
        changeLanguage(str: "ru")  //russian
    }
    
    func actionLanguageSignIn_da() {
        changeLanguage(str: "da") //danish
    }
    
    func actionLanguageSignIn_fr() {
        changeLanguage(str: "fr")  //frenc
    }
    
    
    func actionLanguageSignIn_it() {
        changeLanguage(str: "it")  //italian
    }
    
    
    func actionLanguageSignIn_nl() {
        changeLanguage(str: "nl")  //duct flemence
    }
    
    func changeLanguage(str:String)  {
        lblSignIn.text = "Giriş Yap".addLocalizableString(str: str)
        txtEmail.placeholder = "E-posta adresinizi giriniz".addLocalizableString(str: str)
        txtPassword.placeholder = "Şifrenizi girin".addLocalizableString(str: str)
        btnForgotPassword.setTitle("Şifreni mi unuttun ?".addLocalizableString(str: str), for: .normal)
        btnSignIn.setTitle("GİRİŞ YAP".addLocalizableString(str: str), for: .normal)
        btnSignUp.setTitle("Hesabın yok mu ? Hemen oluştur!".addLocalizableString(str: str), for: .normal)
        alertMesaj.text = "Lütfen email adresinizi girniz".addLocalizableString(str: str)
        alertParola.text = "Lütfen şifrenizi giriniz".addLocalizableString(str: str)
        alertHata.text = "Giris yapilirken bir hata oluştu".addLocalizableString(str: str)
        
    }
    
    @objc func signInpAction() {
        
        if txtEmail.text == "" {
            makeAlert(tittle: "Error", message: alertMesaj.text!)
            return
        }
        if txtPassword.text == "" {
            makeAlert(tittle: "Error", message: alertParola.text!)
           return
        }
        
        btnSignIn.isHidden = true
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (authdata, error) in
            if(error != nil){
                self.makeAlert(tittle: "Error", message: self.alertHata.text!)
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
        print("test")
    }
    
    
    
    
    
}



