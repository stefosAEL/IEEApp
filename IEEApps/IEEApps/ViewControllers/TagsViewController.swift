//
//  TagsViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 21/05/2022.
//

import Foundation
import UIKit

class TagsViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    var tags : [TagsArray]?
    let reuseIdentifier = "TagsCell"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        DataContext.instance.getTags(completion: { [weak self] tags in
            if let tags = tags {
                self?.tags = tags.data
            }
            self?.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tags = tags
        {
           return tags.count
        }else {
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! TagsTableViewCell
//        let tags = tags?[indexPath.row]
        let sortedTags = tags?.sorted(by: { $0.id < $1.id })
        let tags = sortedTags?[indexPath.row]
        cell.titleLabel.text=tags?.title
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
   
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
