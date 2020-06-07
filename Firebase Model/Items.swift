//
//  Items.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/8/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class Items {
    
    var category : String?
    var description : String?
    var header : String?
    var itemid : String?
    var latitude : Double?
    var longitude : Double?
    var photourl : String?
    var publisher : String?
  
    
    init(category:String,description:String,header:String,itemid:String,latitude:Double,longitude:Double,photourl:String,publisher:String) {
        self.category = category
        self.description = description
        self.header = header
        self.itemid = itemid
        self.latitude = latitude
        self.longitude = longitude
        self.photourl = photourl
        self.publisher = publisher
    }
    
}
