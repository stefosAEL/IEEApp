//
//  LoggInViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 30/04/2022.
//

import Foundation
import UIKit

class PrivateAnnouncementsVC:UIViewController, UITableViewDelegate,UITableViewDataSource{
     var loggInAnns: [PublicAnn]?
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "LoggInAnnsCell"
    
    @IBOutlet weak var notificationIcon: UIImageView!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var profileIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsImageTapped(tapGestureRecognizer:)))
        settingsIcon.isUserInteractionEnabled = true
        settingsIcon.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(NotificationsImageTapped(tapGestureRecognizer:)))
        notificationIcon.isUserInteractionEnabled = true
        notificationIcon.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(ProfileImageTapped(tapGestureRecognizer:)))
        profileIcon.isUserInteractionEnabled = true
        profileIcon.addGestureRecognizer(tapGestureRecognizer3)
        
        DataContext.instance.getLoggInAnnouncemnets(page:DataContext.instance.page2,completion: { [weak self] loggInAnns in
            if let loggInAnns = loggInAnns {
                self?.loggInAnns = loggInAnns.data
            }
            self?.tableView.reloadData()
        })
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let loggInAnns = loggInAnns
        {
           return loggInAnns.count
        }else {
           return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        showAnnouncementDesktopVC(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! LogginAnnTableViewCell
        let announcement = loggInAnns?[indexPath.row]
        cell.teacherLabel.text = announcement?.author.name
        cell.bodyLabel.text = announcement?.body.description.htmlToString
        cell.dateTimeLabel.text = announcement?.created_at
        cell.eventLabel.text = announcement?.tags[0].title
        cell.titleLabel.text = announcement?.title
        cell.event2Label.text = announcement?.tags[1].title
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    @objc func SettingsImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "SettingsView")
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true, completion: nil)
    }
    
    @objc func NotificationsImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "NotificationsView")
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true, completion: nil)
    }
    
    @objc func ProfileImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "ProfileView")
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ((loggInAnns?.count ?? 0) - 1)  {
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
                                self?.loggInAnns?.append(Ann)
                            }
                        }
                        self?.tableView.reloadData()
                
                    })}
        })
        }
    private func showAnnouncementDesktopVC(row index:Int){
        let selecteAnn : PublicAnn = (loggInAnns?[index])!
        let title = selecteAnn.title
        let body = selecteAnn.body
        let storyBoard : UIStoryboard = UIStoryboard(name: "AnnouncementsDesktop", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "PrivateAnnDesktop") as? PrivateAnnDesktop
        viewcontroller!.body = body
        viewcontroller!.titleL = title
        viewcontroller?.modalPresentationStyle = .fullScreen
        present(viewcontroller!, animated: true)

      
    }
    
    
    }

