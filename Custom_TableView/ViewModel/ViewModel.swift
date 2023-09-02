//
//  ViewModel.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    
}

class ViewModel {
    
    weak var view: ViewModelProtocol?
    
    init(view: ViewModelProtocol? = nil) {
        self.view = view
    }
    
}

extension ViewModel: ViewControllerProtocol {
    
}
