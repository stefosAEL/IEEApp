//
//  LogginAnnTableViewCell.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 30/04/2022.
//

import UIKit

class LogginAnnTableViewCell: UITableViewCell {

    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
