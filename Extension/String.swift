//
//  String.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/29/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

extension String {
    func addLocalizableString(str:String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

