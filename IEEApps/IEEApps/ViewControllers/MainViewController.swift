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

class MainViewController : UIViewController,UITableViewDelegate, UITableViewDataSource,WKUIDelegate  {
    var webView: WKWebView!
    let reuseIdentifier = "PublicAnnsCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var LogInBtn: UIButton!
    var publicAnns: [PublicAnn]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogInBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        tableView.dataSource = self
        tableView.delegate = self
//        self.collectionView.register(PublicAnnsCollectionViewCell.self, forCellWithReuseIdentifier: "PublicAnnsCell")
           //callWebView(LogInBtn)
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
        showWebView("https://login.iee.ihu.gr/")
    }
    //    override func loadView() {
//       let webConfiguration = WKWebViewConfiguration()
//       webView = WKWebView(frame: .zero, configuration: webConfiguration)
//       webView.uiDelegate = self
//       view = webView
//    }
//    @IBAction func callWebView(_ sender: UIButton) {
//        let myURL = URL(string:"https://login.iee.ihu.gr/")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//    }
    public func showWebView(_ url: String) {
           let vc : LogginWebViewVC = UIStoryboard(name: "LogginWebViewVC", bundle: nil).instantiateViewController(withIdentifier: "LogginWebViewVC") as! LogginWebViewVC
           vc.url = url
           vc.modalPresentationStyle = .overFullScreen
           vc.modalTransitionStyle = .flipHorizontal
           self.present(vc, animated: true, completion: nil)
    }
}
