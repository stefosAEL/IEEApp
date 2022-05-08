//
//  SettingsViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 01/04/2022.
//

import Foundation
import UIKit
class SettingsViewController : UIViewController
{
    @IBOutlet weak var logoutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFunction))
            logoutLabel.isUserInteractionEnabled = true
            logoutLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        LogOut()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "MainStoryboardID")
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true, completion: nil)
    }
    func LogOut (){
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://aboard.iee.ihu.gr/api/auth/logout")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(DataContext.instance.accessToken)", forHTTPHeaderField: "authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}

