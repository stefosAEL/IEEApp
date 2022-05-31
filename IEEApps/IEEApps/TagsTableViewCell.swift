//
//  TagsTableViewCell.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 21/05/2022.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxBtn: CheckBoxBtn!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
