//
//  CountriesTableViewCell.swift
//  exam-bare
//
//  Created by Kirill on 6/16/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class CountryLatinOriginTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLatinLabel: UILabel!
    @IBOutlet weak var nameOriginLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
