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


class MainViewController : UIViewController,UITableViewDelegate, UITableViewDataSource,WKUIDelegate,UIScrollViewDelegate  {
    let reuseIdentifier = "PublicAnnsCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var LogInBtn: UIButton!
    var publicAnn: [PublicAnn]?
    var oAuthService: OAuthService?
    var makeHomeViewController: (() -> UIViewController)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        LogInBtn.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        tableView.dataSource = self
        tableView.delegate = self

        DataContext.instance.getAnnouncemnets(page:DataContext.instance.page ,completion: { [weak self] publicAnns in
            if let publicAnns = publicAnns {
                self?.publicAnn = publicAnns.data
            }
            self?.tableView.reloadData()
        })
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let publicAnns = publicAnn
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
        let announcement = publicAnn?[indexPath.row]
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
        guard let url = oAuthService?.getAuthPageUrl(state: "state") else { return }
        let webViewVC = LogginWebViewVC()
        webViewVC.modalPresentationStyle = .fullScreen
        webViewVC.url = url
        present(webViewVC, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ((publicAnn?.count ?? 0) - 1)  {
            displayData()
            tableView.reloadInputViews()
        }
    }

    func displayData(){
        DataContext.instance.getAnnouncemnets(page:DataContext.instance.page ,completion: { [weak self] publicAnns in
            if (publicAnns?.meta?.last_page ??  0) > (DataContext.instance.page){
                    DataContext.instance.page = (DataContext.instance.page) + 1
                    DataContext.instance.getAnnouncemnets(page:DataContext.instance.page ,completion: { [weak self] publicAnns in
                        if let publicAnns = publicAnns {
                            for Ann in publicAnns.data{
                                self?.publicAnn?.append(Ann)
                            }
                        }
                        self?.tableView.reloadData()
                
                    })}
        })
        }
    }
        
                                              

