//
//  Comment.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/27/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class ItemsComments {
    
    var comment : String?
    var commentid : String?
    var postid : String?
    var postpublisher : String?
    var posttime : String?
    var publisher : String?
    
    init(comment:String,commentid:String,postid:String,postpublisher:String,posttime:String,publisher:String) {
        self.comment = comment
        self.commentid = commentid
        self.postid = postid
        self.postpublisher = postpublisher
        self.posttime = posttime
        self.publisher = publisher
        
    }
    
}
