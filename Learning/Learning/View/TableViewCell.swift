//
//  TableViewCell.swift
//  Learning
//
//  Created by LivingMobile on 13/1/2563 BE.
//  Copyright © 2563 LivingMobile. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var data: DataModel? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureView() {
        guard let data = data else {
            return
        }
        
        titleLabel.text = data.title
        thumbnailImage.getImageFromWeb(imageUrlString: data.thumbnailUrl, withReceiptPrint: true)
    }
}
