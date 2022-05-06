//
//  PublicAnnDesktopVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/05/2022.
//

import Foundation
import UIKit

class PublicAnnDesktop : UIViewController {
    var body = ""
    var titleL = ""
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.text = body.description.html2String
        titleLabel.text = titleL
        bodyTextView.layer.borderWidth = 1.0
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
