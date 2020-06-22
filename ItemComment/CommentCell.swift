//
//  CommentCell.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblComment: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
var btnTapAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func btnAction() {
        btnTapAction?()
    }
    
}
