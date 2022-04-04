//
//  MainViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/03/2022.
//

import Foundation
import UIKit
import Alamofire

class MainViewController : UIViewController
{
    
    @IBOutlet weak var LogInBtn: UIButton!
    override func viewDidLoad() {
        LogInBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
            
        fetchPublicAnn()
        super.viewDidLoad()
    }

}
