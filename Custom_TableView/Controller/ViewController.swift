//
//  ViewController.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    
}

class ViewController: UIViewController {
    
    var viewModel: ViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupViewModel() {
        self.viewModel = ViewModel(view: self)
    }


}

extension ViewController: ViewModelProtocol {
    
}

