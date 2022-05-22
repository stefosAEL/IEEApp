//
//  PublicAnnDesktopVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/05/2022.
//

import Foundation
import UIKit
import WebKit

class PublicAnnDesktop : UIViewController {
    var body = ""
    var titleL = ""
    
    @IBOutlet weak var bodyWebView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyWebView.loadHTMLString(body, baseURL: nil)
        titleLabel.text = titleL
        bodyWebView.layer.borderWidth = 1.0
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
