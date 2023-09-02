//
//  TableViewCell.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var item: Any? {
        // MARK: - Property Observer
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol?
    
    func configure(_ item: Any?) {
        
    }
    
}

// MARK: - UITableViewHeaderFooterView
class TableHeaderFooterView: UITableViewHeaderFooterView {
    
    var item: Any? {
        didSet {
            self.configure(self.item)
        }
    }
    
    weak var delegate: NSObjectProtocol?
    
    func configure(_ item: Any?) {
        
    }
    
}
