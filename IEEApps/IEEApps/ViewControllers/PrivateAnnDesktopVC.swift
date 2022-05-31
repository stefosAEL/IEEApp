//
//  PrivateAnnDesktopVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 03/05/2022.
//

import Foundation
import UIKit
import WebKit

class PrivateAnnDesktop : UIViewController {
    var body = ""
    var titleL = ""
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var bodyWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyWebView.loadHTMLString(body, baseURL: nil)
        titleLabel.text = titleL
        
    }

    @IBAction func goBck(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
