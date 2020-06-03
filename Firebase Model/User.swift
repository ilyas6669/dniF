//
//  User.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class User {
    
    var email : String?
    var latitude : Double?
    var longitude : Double?
    var userid : String?
    var usertype : String?
    
    init(email:String,latitude:Double,longitude:Double,userid:String,usertype:String) {
        self.email = email
        self.latitude = latitude
        self.longitude = longitude
        self.userid = userid
        self.usertype = usertype
    }
    
}
