//
//  NotificationTableViewCell.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 07/05/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var DateTimeLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
