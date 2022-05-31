//
//  TagsViewController.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 21/05/2022.
//

import Foundation
import UIKit

var rowsWhichAreChecked = [NSIndexPath]()
class TagsViewController : UIViewController,UITableViewDelegate,UITableViewDataSource{
    var tags : [TagsArray]?
    var subs : [Subscription]?
    let reuseIdentifier = "TagsCell"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection=true
        DataContext.instance.getTags(completion: { [weak self] tags in
            if let tags = tags {
                self?.tags = tags.data
            }
            self?.tableView.reloadData()
        })
        DataContext.instance.getSubscriptions(completion:{ [weak self] subs in
            if let subs = subs {
                self?.subs = subs
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath as IndexPath) as! TagsTableViewCell
        let sortedTags = tags?.sorted(by: { $0.id < $1.id })
        let tags = sortedTags?[indexPath.row]
        cell.titleLabel.text=tags?.title
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        let isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        
        if let subs = self.subs {
            for sub in subs {
                cell.checkBoxBtn.isChecked = tags?.id == sub.id ? true : false
            }
           
        }
        
        if(isRowChecked == true )
        {
            cell.checkBoxBtn.isChecked = true
            cell.checkBoxBtn.buttonClicked(sender: cell.checkBoxBtn)
        }else{
            cell.checkBoxBtn.isChecked = false
            cell.checkBoxBtn.buttonClicked(sender: cell.checkBoxBtn)
        }
    
    return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TagsTableViewCell
        cell.checkBoxBtn.isChecked = false
        cell.checkBoxBtn.buttonClicked(sender: cell.checkBoxBtn)
        // remove the indexPath from rowsWhichAreCheckedArray
        if let checkedItemIndex = rowsWhichAreChecked.firstIndex(of: indexPath as NSIndexPath){
            rowsWhichAreChecked.remove(at: checkedItemIndex)
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TagsTableViewCell
        cell.contentView.backgroundColor = UIColor.white
        // cross checking for checked rows
        if(rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
            cell.checkBoxBtn.isChecked = true
            cell.checkBoxBtn.buttonClicked(sender: cell.checkBoxBtn)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.00
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
