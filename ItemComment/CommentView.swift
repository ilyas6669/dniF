//
//  CommentView.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/11/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}

class CommentView: UIViewController,UITextFieldDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlue()
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
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureREcongizer)
        
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
    
    @objc func btnPaylasAction() {
        print("paylas")
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
    
   
    
    
}



extension CommentView : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CommentCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        cell.lblEmail.text = "ilyas.666@mail.ru"
        cell.lblComment.text = "jnjdncdcdscscjnjdncdcdscscnjnjdncdcdscscnjnjdncdcdscscnjnjdncdcdscscnjnjdncdcdscscnn"
        cell.btnTapAction = {
            () in
            print("test")
        }
        return cell
    }
    
    
}
