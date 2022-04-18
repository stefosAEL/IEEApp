//
//  MainViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/03/2022.
//

import Foundation
import UIKit
import Alamofire
import WebKit
import SafariServices


class MainViewController : UIViewController,UITableViewDelegate, UITableViewDataSource,WKUIDelegate  {
    let reuseIdentifier = "PublicAnnsCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var LogInBtn: UIButton!
    var publicAnns: [PublicAnn]?
    let oAuthService: OAuthService
    private let makeHomeViewController: () -> UIViewController
    
    init(oAuthService: OAuthService ,makeHomeViewController: @escaping () -> UIViewController) {
        self.oAuthService = oAuthService
        self.makeHomeViewController = makeHomeViewController
      
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        oAuthService.onAuthenticationResult = { [weak self] in self?.onAuthenticationResult(result: $0) }
        
        LogInBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        tableView.dataSource = self
        tableView.delegate = self

        DataContext.instance.getAnnouncemnets(completion: { [weak self] publicAnns in
            if let publicAnns = publicAnns {
                self?.publicAnns = publicAnns.data
            }
            self?.tableView.reloadData()
        })
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let publicAnns = publicAnns
        {
           return publicAnns.count
        }else {
           return 0
        }
        }
        // method to run when table view cell is tapped
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // note that indexPath.section is used rather than indexPath.row
            print("You tapped cell number \(indexPath.section).")
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! PublicAnnTableViewCell
        let announcement = publicAnns?[indexPath.row]
        //cell.teacherLabel = announcement?.author.name
        cell.teacherLabel.text=announcement?.author.name
        cell.bodyLabel.text = announcement?.body
        cell.dateTimeLabel.text = announcement?.created_at
        cell.eventLabel.text = announcement?.tags[0].title
        cell.titleLabel.text = announcement?.title
        cell.event2Label.text=announcement?.tags[1].title
        
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    @IBAction func LoggIn(_ sender: Any) {
        guard let url = oAuthService.getAuthPageUrl(state: "state") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
        
    }
    func onAuthenticationResult(result: Result<TokenBag, Error>) {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true) {
                switch result {
                case .success:
                    self.navigationController?.pushViewController(self.makeHomeViewController(), animated: true)

                case .failure:
                    let alert = UIAlertController(title: "Something went wrong :(",
                                                  message: "Authentication error",
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }

}
