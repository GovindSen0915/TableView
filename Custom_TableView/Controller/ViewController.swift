//
//  ViewController.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import UIKit

// MARK: - Protocol
protocol ViewControllerProtocol: AnyObject {
    var numberOfSections: Int { get }
    func numberOfItemsAt(section: Int) -> Int
    func itemAt(indexPath: IndexPath) -> Any
    func setupData()
}

// MARK: - UIViewController
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableview()
        self.viewModel.setupData()
    }
    
    private func setupViewModel() {
        self.viewModel = ViewModel(view: self)
    }
}

// MARK: - ViewModelProtocol
extension ViewController: ViewModelProtocol {
    func reload() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableview() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(CustomCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {
            return UITableViewCell()
        }
        
        cell.item = self.viewModel.itemAt(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
}

