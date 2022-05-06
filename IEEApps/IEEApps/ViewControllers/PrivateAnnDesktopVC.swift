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
        bodyTextView.text = body.description.html2String
        titleLabel.text = titleL
        bodyTextView.layer.cornerRadius =
        bodyTextView.frame.size.height/2
        bodyTextView.clipsToBounds = false
        bodyTextView.layer.shadowOpacity=0.4
        bodyTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
