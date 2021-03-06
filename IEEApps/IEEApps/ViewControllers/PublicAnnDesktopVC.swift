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
    var atachement = ""
    var atachement2 = ""
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
        if atachement != ""{
        bodyWebView.loadHTMLString(header + body + "<br>" + "<b>links: </b>" + atachement +  "<br>" + atachement2 + "</body>"  , baseURL: nil)
        } else {
        bodyWebView.loadHTMLString(header + body + "</body>"  , baseURL: nil)
        }
        titleLabel.text = titleL
        bodyWebView.layer.shadowColor = UIColor.black.cgColor
        bodyWebView.layer.shadowOffset = .zero
        bodyWebView.layer.shadowRadius = 1
        bodyWebView.layer.shadowPath = UIBezierPath(rect: bodyWebView.bounds).cgPath
        bodyWebView.layer.shouldRasterize = true
        bodyWebView.layer.rasterizationScale = UIScreen.main.scale
        bodyWebView.layer.borderColor = UIColor.black.cgColor
        bodyWebView.layer.borderWidth = 0.2
        
        
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowRadius = 2.0
        titleLabel.layer.shadowOpacity = 0.6
        titleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        titleLabel.layer.masksToBounds = false


    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
