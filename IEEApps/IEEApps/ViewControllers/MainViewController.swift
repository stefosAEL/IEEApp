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
            showAnnouncementDesktopVC(row: indexPath.row)
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! PublicAnnTableViewCell
        let announcement = publicAnn?[indexPath.row]

        //cell.teacherLabel = announcement?.author.name
        cell.teacherLabel.text=announcement?.author.name
        cell.bodyLabel.text = announcement?.body.description.htmlToString
        cell.dateTimeLabel.text = announcement?.created_at
        cell.eventLabel.text = announcement?.tags[1].title
        cell.titleLabel.text = announcement?.title
        cell.event2Label.text=announcement?.tags[0].title
        
        
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
    private func showAnnouncementDesktopVC(row index:Int){
        let selecteAnn : PublicAnn = (publicAnn?[index])!
        let title = selecteAnn.title
        print(title)
        let body = selecteAnn.body
        let storyBoard : UIStoryboard = UIStoryboard(name: "AnnouncementsDesktop", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "PublicAnnDesktop") as? PublicAnnDesktop
        viewcontroller!.body = body
        viewcontroller!.titleL = title
        viewcontroller?.modalPresentationStyle = .fullScreen
        navigationController?.present(viewcontroller!, animated: true)

      
    }
    }

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
