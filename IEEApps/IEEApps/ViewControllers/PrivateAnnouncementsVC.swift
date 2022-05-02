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
    
    @IBOutlet weak var settingsIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        settingsIcon.isUserInteractionEnabled = true
        settingsIcon.addGestureRecognizer(tapGestureRecognizer)
        
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
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "SettingsView")
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true, completion: nil)
        // Your action
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
    }

