//
//  CustomCell.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import UIKit

class CustomCell: TableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? CustomCellModel else {
            return
        }
        self.nameLabel.text = model.name
    }
    
}
