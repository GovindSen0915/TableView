//
//  ViewModel.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func reload()
}

class ViewModel {
    
    weak var view: ViewModelProtocol?
    var sectionModels = [SectionModel]()
    var cellModels = [Any]()
    
    init(view: ViewModelProtocol) {
        self.view = view
    }
    
    func prepareCellModel() {
        self.sectionModels = []
        self.cellModels = []
        
        let cellModel1 = CustomCellModel(name: "Trending")
        
        
        let dummyCellModel1 = CustomCellModel(name: "DEMO")
        self.cellModels.append(dummyCellModel1)
        self.sectionModels.append(SectionModel(cellModels: self.cellModels))
        self.view?.reload()
    }
    
}

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
