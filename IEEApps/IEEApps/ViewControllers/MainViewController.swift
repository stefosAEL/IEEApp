//
//  MainViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/03/2022.
//

import Foundation
import UIKit
import Alamofire

class MainViewController : UIViewController {
    
    @IBOutlet weak var LogInBtn: UIButton!
    
    var publicAnns: [PublicAnn]?
    
    override func viewDidLoad() {
        LogInBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
            
        fetchPublicAnn()
        super.viewDidLoad()
    }
    
    func fetchPublicAnn() {
        DataContext.instance.getAnnouncemnets(completion: { [weak self] publicAnns in
            if let publicAnns = publicAnns {
                self?.publicAnns = publicAnns.data
                print(publicAnns.data[0].title)
                print(publicAnns.data[0].body)
                print(publicAnns.data[0].created_at)
                print(publicAnns.data[0].tags[0].title)
                print(publicAnns.data[0].author.name)
            }
        })
    }

}
