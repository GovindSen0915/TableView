//
//  SectionModel.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import Foundation

class SectionModel {
    
    var headerModel: Any?
    var cellModels: [Any] = []
    var footerModel: Any?
    
    init(headerModel: Any? = nil,
         cellModels: [Any] = [],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}
