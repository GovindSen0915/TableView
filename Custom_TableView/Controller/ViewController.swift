//
//  ViewController.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    var numberOfSections: Int { get }
    func numberOfItemsAt(section: Int) -> Int
    func itemAt(indexPath: IndexPath) -> Any
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewControllerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableview()
    }
    
    private func setupViewModel() {
        self.viewModel = ViewModel(view: self)
    }
}

extension ViewController: ViewModelProtocol {
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableview() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
