//
//  CheckBoxBtn.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 22/05/2022.
//

import Foundation
import UIKit

class CheckBoxBtn :UIButton{
    let checkedImage = UIImage(named: "CheckBoxChecked")! as UIImage
   let uncheckedImage = UIImage(named: "CheckBoxUnChecked")! as UIImage

    var isChecked: Bool = true {
        didSet{
            if isChecked == true {
                self.setImage(uncheckedImage, for: .normal)
            } else {
                
                self.setImage(checkedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        self.addTarget(self, action: #selector(CheckBoxBtn.buttonClicked), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
