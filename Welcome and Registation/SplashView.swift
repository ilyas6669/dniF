//
//  SplashView.swift
//  Fiind
//
//  Created by İlyas Abiyev on 5/30/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class SplashView: UIViewController {
    
    var countryArray = [String]()
    
    var country = ""
    
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
        
        getData()
        
        view.backgroundColor = .white
        addSubview()
        addConstraint()
        activityIndicator.startAnimating()
        
        
        if Auth.auth().currentUser != nil {
            
            if country == "" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("bos")
                
                
                
                
            } else if country == "de" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("de/alman")
                
                
                
                
                
            }else if country == "en" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("en/english")
                
                
                
            }else if country == "ar" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("ar/arabic")
                
                
                
                
                
            }else if country == "ru" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("ru/russian")
                
                
                
            }else if country == "da" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("da/danca")
                
                
                
                
            }else if country == "fr" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("fr/french")
                
                
                
                
            }else if country == "it" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("it/italic")
                
                
                
                
                
            }else if country == "nl" {
                perform(#selector(toHomePage), with: nil,afterDelay: 2)
                print("nl/holland")
                
                
                
                
                
            }
            
            
            
        }else{
            
            if country == "" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("bos")
            } else if country == "de" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("de/alman")
            }else if country == "en" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("en/english")
            }else if country == "ar" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("ar/arabic")
            }else if country == "ru" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("ru/russian")
            }else if country == "da" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("da/danca")
            }else if country == "fr" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("fr/french")
            }else if country == "it" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("it/italic")
            }else if country == "nl" {
                perform(#selector(toSignIn), with: nil,afterDelay: 2)
                print("nl/holland")
            }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func toSignIn() {
        let signin = SignIn()
        signin.modalPresentationStyle = .fullScreen
        self.present(signin, animated: true, completion: nil)
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
    
    
    
    
}

