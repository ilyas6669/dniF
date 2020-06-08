//
//  SplashView.swift
//  Fiind
//
//  Created by İlyas Abiyev on 5/30/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase


class SplashView: UIViewController {
    
    
    //MARK: Properties
    let imgLogo : UIImageView = {
        let img = UIImageView(image: UIImage(named: "FindTrasparant"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return img
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //        try! Auth.auth().signOut()
        
        view.backgroundColor = .white
        addSubview()
        addConstraint()
        activityIndicator.startAnimating()
       
        
        if Auth.auth().currentUser != nil {
           
            perform(#selector(toHomePage), with: nil,afterDelay: 2)
            
        }else{
           
            perform(#selector(toSignIn), with: nil,afterDelay: 2)
        }
        
    }
    
    //MARK: addSubview
    func addSubview() {
        view.addSubview(imgLogo)
        view.addSubview(activityIndicator)
    }
    
    //MARK: constraint
    func addConstraint() {
        imgLogo.merkezKonumlamdirmaSuperView()
        activityIndicator.topAnchor.constraint(equalTo: imgLogo.bottomAnchor,constant: 5).isActive = true
        activityIndicator.merkezXSuperView()
        
    }
    
    @objc func toHomePage() {
        let homePage = Home()
        homePage.modalPresentationStyle = .fullScreen
        self.present(homePage, animated: true, completion: nil)
    }
    
    @objc func toSignIn() {
        let signin = SignIn()
        signin.modalPresentationStyle = .fullScreen
        self.present(signin, animated: true, completion: nil)
    }
    
    
  
    
    
    
    
}

