//
//  SettingsViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 01/04/2022.
//

import Foundation
import UIKit
import SafariServices
import MessageUI
import KeychainSwift


class SettingsViewController : UIViewController, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate
{
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    @IBOutlet weak var sourceCodeLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var bugReportLabel: UILabel!
    let keychain = KeychainSwift()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.logoutTapFunction))
            logoutLabel.isUserInteractionEnabled = true
            logoutLabel.addGestureRecognizer(logoutTap)
        
        let sourceCodeTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.sourceCodeTapFunction))
        sourceCodeLabel.isUserInteractionEnabled = true
        sourceCodeLabel.addGestureRecognizer(sourceCodeTap)
        
        let termsAndConditionsTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.termsAndConditionsTapFunctionTapFunction))
        termsAndConditionsLabel.isUserInteractionEnabled = true
        termsAndConditionsLabel.addGestureRecognizer(termsAndConditionsTap)
        
        let privacyPolicyTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.termsAndConditionsTapFunctionTapFunction))
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.addGestureRecognizer(privacyPolicyTap)
        
        let bugReportTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.bugReportTapFunctionTapFunction))
        bugReportLabel.isUserInteractionEnabled = true
        bugReportLabel.addGestureRecognizer(bugReportTap)
        
        let tagsTap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tagsTapFunctionTapFunction))
        tagsLabel.isUserInteractionEnabled = true
        tagsLabel.addGestureRecognizer(tagsTap)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func logoutTapFunction(sender:UITapGestureRecognizer) {
        LogOut()
        self.keychain.set("false", forKey: DataReloadEnum.FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS.rawValue)
        let dependencyContainer = AppDependencyContainer()
        let mainVC = dependencyContainer.makeMainViewController()
        self.view.window?.frame = UIScreen.main.bounds
        self.view.window?.rootViewController? = mainVC

    }
    
    @objc func sourceCodeTapFunction(sender:UITapGestureRecognizer) {
        let safariVC = SFSafariViewController(url: URL(string: "https://github.com/stefosAEL/IEEApp/tree/main")!)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
    }
    
    @objc func termsAndConditionsTapFunctionTapFunction(sender:UITapGestureRecognizer) {
        let safariVC = SFSafariViewController(url: URL(string: "https://github.com/stefosAEL/IEEApp/blob/main/Terms-and-Conditions")!)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
    }
    
    @objc func privacyPolicyTapFunctionTapFunction(sender:UITapGestureRecognizer) {
        let safariVC = SFSafariViewController(url: URL(string: "https://github.com/stefosAEL/IEEApp/blob/main/Privacy")!)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
    }
    
    @objc func bugReportTapFunctionTapFunction(sender:UITapGestureRecognizer) {
        showMailComposer()
    }
    
    @objc func tagsTapFunctionTapFunction(sender:UITapGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "TagsViewController")
        viewcontroller.modalPresentationStyle = .fullScreen
        self.present(viewcontroller, animated: true, completion: nil)
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
    
    func showMailComposer(){
        if MFMailComposeViewController.canSendMail()  {
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate=self
        composer.setToRecipients(["stefanosael97@hotmail.com"])
        composer.setSubject("Bug Report!")
        composer.setMessageBody("Report your bug here ..", isHTML: false)
        
        present(composer,animated: true)
        }else {
            return
        }
    }
}
extension SettingsViewController{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            print("Fail to Send")
        case .sent:
            print("Saved")
        case .failed:
            print("Email Sent")
        }
        controller.dismiss(animated: true)
    }
}


