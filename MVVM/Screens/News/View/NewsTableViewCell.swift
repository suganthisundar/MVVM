//
//  NewsTableViewCell.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var newsImgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
