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
    var subs : User?
    var tagIds : [Int]? = []
    let reuseIdentifier = "TagsCell"
    @IBOutlet weak var saveBtn: UIButton!
    let checkedImage = UIImage(named: "CheckBoxChecked")! as UIImage

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
        DataContext.instance.getUsers(completion:  { [weak self] user in
            if let user = user {
                self?.subs = user.data
            }
            self?.tableView.reloadData()
        })
        saveBtn.isEnabled = false
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
        var isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        for sub in subs?.subscriptions ?? [] {
            if sub.title == cell.titleLabel.text ?? ""{
                isRowChecked = true
                
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
        cell.actionBlock = {
            if cell.checkBoxBtn.isChecked == true{
                if (tags?.id) != nil{
                    self.tagIds?.append(tags!.id)
                    if(self.tagIds != nil){
                        self.saveBtn.isEnabled = true
                    }
                }} else{
                    if self.tagIds != nil {
                        if let index = self.tagIds?.firstIndex(of: tags!.id) {
                            self.tagIds?.remove(at: index)
                        }
                        
                    }
                    
                }
            if (self.tagIds == nil){
                self.saveBtn.isEnabled = false
            }
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
    func saveTags(tag_ids:[Int]){
        let semaphore = DispatchSemaphore (value: 0)
        print(tag_ids)
        let parameters = "{\n    \"tags\": \"\(tag_ids)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://aboard.iee.ihu.gr/api/auth/subscribe")!,timeoutInterval: Double.infinity)
        request.addValue("\(DataContext.instance.accessToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
    @IBAction func save(_ sender: Any) {
        if let tagIds = tagIds {
            print(tagIds)
            saveTags(tag_ids: tagIds)
            tableView.reloadData()
            saveBtn.isEnabled = false
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.00
    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
