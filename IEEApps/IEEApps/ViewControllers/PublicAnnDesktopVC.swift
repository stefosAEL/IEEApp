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
    let header = """
            <head>
                <style>
                    body {
                        font-size: 20px;
                    }
                </style>
            </head>
            <body>
            """
    @IBOutlet weak var bodyWebView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyWebView.loadHTMLString(header + body + "</body>", baseURL: nil)
        titleLabel.text = titleL
        bodyWebView.layer.shadowColor = UIColor.black.cgColor
        bodyWebView.layer.shadowOpacity = 1
        bodyWebView.layer.shadowOffset = .zero
        bodyWebView.layer.shadowRadius = 5
        bodyWebView.layer.shadowPath = UIBezierPath(rect: bodyWebView.bounds).cgPath
        bodyWebView.layer.shouldRasterize = true
        bodyWebView.layer.rasterizationScale = UIScreen.main.scale


    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
