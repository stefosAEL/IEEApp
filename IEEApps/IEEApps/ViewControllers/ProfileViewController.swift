//
//  profileViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 10/05/2022.
//

import Foundation
import UIKit

class ProfileViewController :UIViewController {
    var profile : User?
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lesson2Label: UILabel!
    @IBOutlet weak var lesson1Label: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // nameLabel.text = profile?.name
        //uidLabel.text = profile?.uid
//        lesson1Label.text = profile?.subscriptions[0].title
//        if(profile?.subscriptions[1] != nil){
//            lesson2Label.text = profile?.subscriptions[1].title
//        }else {
//            lesson2Label.text = ""
//        }
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.cgColor
        DataContext.instance.getUsers(completion:  { [weak self] user in
            if let user = user {
                self?.profile = user.data
            }
            self?.nameLabel.text = self?.profile?.name
            self?.uidLabel.text = self?.profile?.uid
            self?.emailLabel.text = self?.profile?.email
            if(!(self?.profile?.subscriptions?.isEmpty ?? true) ){
            self?.lesson1Label.text = self?.profile?.subscriptions?[0].title
                if(self?.profile?.subscriptions?.count ?? 0 > 1){
            self?.lesson2Label.text = self?.profile?.subscriptions?[1].title
            }
            }
        })
    }
    
    @IBAction func goBck(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
}
