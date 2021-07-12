//
//  SearchTableViewCell.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: TitleLabel!
    @IBOutlet weak var lblCapacity: SubtitleLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(station : BikeStation) {
        self.lblTitle.text = station.name
        self.lblCapacity.text = station.capacity?.stringValue
    }
}
