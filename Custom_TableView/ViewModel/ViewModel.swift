//
//  ViewModel.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import Foundation

// MARK: - Protocol
protocol ViewModelProtocol: AnyObject {
    func reload()
}

// MARK: - ViewModel
class ViewModel {
    
    weak var view: ViewModelProtocol?
    var sectionModels = [SectionModel]()
    var cellModels = [Any]()
    var currentDate: Date = Date()
    
    init(view: ViewModelProtocol) {
        self.view = view
    }
    
    func prepareCellModel() {
        self.sectionModels = []
        self.cellModels = []
        
        var dates = DateHelper.getDaysSimple(for: self.currentDate)
        dates = dates.filter({ $0.day() >= currentDate.day() })
        
        let dateModels = dates.map({ CustomCellModel(day: $0) })
        
        self.sectionModels = [SectionModel(headerModel: nil, cellModels: dateModels, footerModel: nil)]
        self.view?.reload()
    }
    
}

// MARK: - ViewControllerProtocol
extension ViewModel: ViewControllerProtocol {
    
    var numberOfSections: Int {
        return self.sectionModels.count
    }
    
    func numberOfItemsAt(section: Int) -> Int {
        return self.sectionModels[section].cellModels.count
    }
    
    func itemAt(indexPath: IndexPath) -> Any {
        return self.sectionModels[indexPath.section].cellModels[indexPath.row]
    }
    
    func setupData() {
        self.prepareCellModel()
    }
    
    
}
