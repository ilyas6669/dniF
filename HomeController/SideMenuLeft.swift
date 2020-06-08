//
//  SideMenuLeft.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/9/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class cell1 : UITableViewCell {
    
}
class cell2 : UITableViewCell {
    
}


class SideMenuLeft: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

  

}


extension SideMenuLeft : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if indexPath.row == 0 {
            let cell : cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! cell1
            return cell
        }
        let cell : cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! cell2
        return cell
        
    }
    
    
}
