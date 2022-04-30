//
//  LoggInViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 30/04/2022.
//

import Foundation
import UIKit

class LoggInViewController:UIViewController, UITableViewDelegate,UITableViewDataSource{
     var loggInAnns: [PublicAnn]?
    @IBOutlet weak var tableView: UITableView!
    let reuseIdentifier = "LoggInAnnsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        DataContext.instance.getLoggInAnnouncemnets(completion: { [weak self] loggInAnns in
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
        print("You tapped cell number \(indexPath.section).")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! LogginAnnTableViewCell
        let announcement = loggInAnns?[indexPath.row]
        cell.teacherLabel.text = announcement?.author.name
        cell.bodyLabel.text = announcement?.body
        cell.dateTimeLabel.text = announcement?.created_at
        cell.eventLabel.text = announcement?.tags[0].title
        cell.titleLabel.text = announcement?.title
        cell.event2Label.text = announcement?.tags[1].title
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}
