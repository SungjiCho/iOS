//
//  UIRoundPrimaryButton.swift
//  Prography
//
//  Created by 조성지 on 2020/03/04.
//  Copyright © 2020 조성지. All rights reserved.
//

import Foundation
import UIKit

class UIRoundPrimaryButton: UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor(red: 199/255, green: 53/255, blue: 73/255, alpha: 1)
        self.tintColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
    }
}


