//
//  PrivateAnnDesktopVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 03/05/2022.
//

import Foundation
import UIKit

class PrivateAnnDesktop : UIViewController {
    var body = ""
    var titleL = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.text = body.description.htmlToString
        titleLabel.text = titleL
        
    }

    @IBAction func goBck(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
