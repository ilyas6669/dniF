//
//  CommentView.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/11/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import CoreData

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}

class CommentView: UIViewController,UITextFieldDelegate {
    
    var ref : DatabaseReference?
    var postid = ""
    var postpublisher = ""
    var itemlist : [NSDictionary] = []
    
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
        lbl.text = "Yorumlar"
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let centerView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    
    let txtComment: UITextField  = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string: "Yorum yapın", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txt.textColor = .black
        return txt
    }()
    
    let btnPaylas: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PAYLAŞ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .customBlue()
        btn.addTarget(self, action: #selector(btnPaylasAction), for: .touchUpInside)
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    
    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let alertTitle : UILabel = {
       let alert = UILabel()
        alert.text = "Sil"
        return alert
    }()
    
    let alertMessage : UILabel = {
       let alert = UILabel()
        alert.text = "Yorumunuzu silmek mi istiyorsunuz?"
        return alert
    }()
    
    let alertButtonTitlle1 : UILabel = {
        let alert = UILabel()
        alert.text = "Paylaşımı sil"
        return alert
    }()
    
    let alertButtonTitlle2 : UILabel = {
        let alert = UILabel()
        alert.text = "İptal Et"
        return alert
    }()
    
    var country = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        if country == "tr" {
            actionLanguageComment_tr()
            print("tr")
        } else if country == "de" {
            actionLanguageComment_de()
        }else if country == "en" {
            actionLanguageComment_en()
        }else if country == "ar" {
            actionLanguageComment_ar()
        }else if country == "ru" {
            actionLanguageComment_ru()
        }else if country == "da" {
            actionLanguageComment_da()
        }else if country == "fr" {
            actionLanguageComment_fr()
        }else if country == "it" {
            actionLanguageComment_it()
        }else if country == "nl" {
            actionLanguageComment_nl()
        }
        
        
        
        view.backgroundColor = .customBlue()
        
        ref = Database.database().reference()
        
        stackView()
        addSubview()
        addConstraint()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        txtComment.delegate = self
        
        
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(gestureREcongizer)
        
        dataPullFirebase()
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
    
    
    
    
    func stackView() {
        
        let stackView = UIStackView(arrangedSubviews: [topView,centerView,bottomView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        _ = stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        let bottomStackView = UIStackView(arrangedSubviews: [txtComment,btnPaylas])
        bottomStackView.axis = .horizontal
        bottomView.addSubview(bottomStackView)
        
         _ = bottomStackView.anchor(top: bottomView.topAnchor, bottom: bottomView.bottomAnchor, leading: bottomView.leadingAnchor, trailing: bottomView.trailingAnchor,padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
    func addSubview() {
        topView.addSubview(btnLeft)
        topView.addSubview(lblIlanEkle)
        centerView.addSubview(tableView)
        
        
    }
    
    func addConstraint() {
        btnLeft.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 10).isActive = true
        btnLeft.merkezYSuperView()
        
        lblIlanEkle.merkezKonumlamdirmaSuperView()
        
        
        
        _ = tableView.anchor(top: centerView.topAnchor, bottom: centerView.bottomAnchor, leading: centerView.leadingAnchor, trailing: centerView.trailingAnchor)
    }
    
    
    
    @objc func leftAction() {
                self.dismiss(animated: true, completion: nil)
        
    }
    
    func actionLanguageComment_tr() {
        changeLanguage(str: "tr") // turkish
    }
    
    func actionLanguageComment_de() {
        changeLanguage(str: "de") //german
    }
    
    
    func actionLanguageComment_en() {
        changeLanguage(str: "en") // engilsh
    }
    
    
    func actionLanguageComment_ar() {
        
        changeLanguage(str: "ar") //arabic
    }
    
    func actionLanguageComment_ru() {
        changeLanguage(str: "ru")  //russian
    }
    
    
    func actionLanguageComment_da() {
        changeLanguage(str: "da") //danish
    }
    
    func actionLanguageComment_fr() {
        changeLanguage(str: "fr")  //italian
    }
    
    
    func actionLanguageComment_it() {
        changeLanguage(str: "it")  //italian
    }
    
    
    func actionLanguageComment_nl() {
           changeLanguage(str: "nl")  //duct flemence
       }
    
    
    func changeLanguage(str:String)  {
        lblIlanEkle.text = "Yorumlar".addLocalizableString(str: str)
        txtComment.placeholder = "Yorum yapın".addLocalizableString(str: str)
        btnPaylas.setTitle("PAYLAŞ".addLocalizableString(str: str), for: .normal)
        
        alertTitle.text = "Sil".addLocalizableString(str: str)
        alertMessage.text = "Yorumunuzu silmek mi istiyorsunuz?".addLocalizableString(str: str)
        alertButtonTitlle1.text = "Paylaşımı sil".addLocalizableString(str: str)
        alertButtonTitlle2.text = "İptal Et".addLocalizableString(str: str)
    }
    
    
    
   
    @objc func btnPaylasAction() {
        view.endEditing(true)
        if txtComment.text != "" {
            let commentid = Database.database().reference().child("itemsComments").child(postid).childByAutoId().key
            
            let userid = Auth.auth().currentUser!.uid
            
            let itemsComment = ItemsComments(comment: txtComment.text!, commentid: commentid!, postid: postid, postpublisher:postpublisher , posttime: signupdateint(), publisher: userid)
            
            let comment : [String:Any] = ["comment":itemsComment.comment!,"commentid":itemsComment.commentid!,"postid":itemsComment.postid!,"postpublisher":itemsComment.postpublisher!,"posttime":itemsComment.posttime!,"publisher":itemsComment.publisher!]
            
            let newRef = self.ref?.child("itemsComments").child(postid).child(commentid!)
            newRef?.setValue(comment, withCompletionBlock: { (error, response) in
                guard error == nil else {
                    print("Posting failed : ")
                    return
                }
                self.txtComment.text = ""
            })
            view.endEditing(true)
        }
       
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.bounds.origin.y == 0{
            self.view.bounds.origin.y += keyboardFrame.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func signupdateint() -> String {
        //    20200101
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-yy-MMdd"
        let result = formatter.string(from: date)
        return String(result)
    }
    
    
    
    
}



extension CommentView : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CommentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        let value2 = self.itemlist[indexPath.row]
        
        let comment = value2["comment"] as? String ?? ""
        let posttime = value2["posttime"] as? String ?? ""
        let email = value2["email"] as? String ?? ""
        let publisher = value2["publisher"] as? String ?? ""
        
        cell.lblEmail.text = email
        cell.lblComment.text = comment
        cell.lblDate.text = posttime
    
        userMailPullFirebase(userid: publisher, cell: cell)
        
        cell.btnTapAction = {
            () in
            let alert = UIAlertController(title: self.alertTitle.text!, message: self.alertMessage.text!, preferredStyle: .actionSheet)
            let silAction = UIAlertAction(title: self.alertButtonTitlle1.text!, style: .default) { (action) in

                var ref : DatabaseReference?


                ref = Database.database().reference().child("itemsComments").child(self.postid)
                ref!.removeValue()



            }
            let iptalAction = UIAlertAction(title: self.alertButtonTitlle2.text!, style: .cancel, handler: nil)

            alert.addAction(silAction)
            alert.addAction(iptalAction)
            self.present(alert, animated: true, completion: nil)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("\(postid)")
               print("ilyas")
               print("\(postpublisher)")
    }
        
    func dataPullFirebase() {
        let userRef = Database.database().reference().child("itemsComments").child(postid)
        userRef.observe(.value) { (snapshot) in
            self.itemlist.removeAll(keepingCapacity: false)
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot
                let value = snap.value as? NSDictionary
                
                let comment = value!["comment"] as? String ?? ""
                
                if comment != "" {
                    self.itemlist.append(value!)
                }
            }
            self.itemlist = self.itemlist.shuffled()
            self.tableView.reloadData()
            
            
        }
        
    }
    
    func userMailPullFirebase(userid : String, cell : CommentCell) {
        let userRef = Database.database().reference().child("user").child(userid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let email = value?["email"] as? String ?? ""
         
            cell.lblEmail.text = email
           
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func getUserInfo() {
        
    }
    
    
}
