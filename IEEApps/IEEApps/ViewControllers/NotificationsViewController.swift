//
//  NotificationsViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 07/05/2022.
//

import Foundation
import UIKit

class NotificationsViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    var Notifications:[Notification]?
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "NotificationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        DataContext.instance.getNotifications(page:DataContext.instance.page3,completion: { [weak self] Notifications in
            if let Notifications = Notifications {
                self?.Notifications = Notifications.data
            }
            self?.tableView.reloadData()
        })
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let Notifications = Notifications
        {
           return Notifications.count
        }else {
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! NotificationTableViewCell
        let notification = Notifications?[indexPath.row]
        if (notification?.data?.type == "user.login"){
        cell.bodyLabel.text = "Συνδέθηκε"
        }else if (notification?.data?.type == "announcement.created"){
            if let user = notification?.data?.user {
            cell.bodyLabel.text = "O χρήστης \(user) δημιούργησε καινούργια ανακοίνωση"
            }
        }
        cell.DateTimeLabel.text = notification?.created_at
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ((Notifications?.count ?? 0) - 1)  {
            displayData()
            tableView.reloadInputViews()
        }
    }
    
    func displayData(){
        DataContext.instance.getNotifications(page:DataContext.instance.page3,completion: { [weak self] Notifications in
            if let total = Notifications?.meta?.last_page{
            if total > (DataContext.instance.page3){
                    DataContext.instance.page3 = (DataContext.instance.page3) + 1
                DataContext.instance.getNotifications(page:DataContext.instance.page3,completion: { [weak self] Notifications in
                        if let notifications = Notifications {
                            for not in notifications.data{
                                self?.Notifications?.append(not)
                            }
                        }
                        self?.tableView.reloadData()
                
                })}
            }})
            
        }
    
    @IBAction func goBck(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
