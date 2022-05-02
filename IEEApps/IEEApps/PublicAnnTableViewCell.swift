//
//  PublicAnnTableViewCell.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 11/04/2022.
//

import UIKit

class PublicAnnTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.activityIndicator.hidesWhenStopped = true
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
