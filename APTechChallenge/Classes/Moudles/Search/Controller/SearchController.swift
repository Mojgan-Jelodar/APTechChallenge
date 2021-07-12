//
//  SearchController.swift
//  APTechChallenge
//
//  Created by m.jelodar on 12/26/19.
//  Copyright © 2019 m.jelodar. All rights reserved.
//

import UIKit

final class SearchController: UITableViewController {
    private let cellName = String(describing: SearchTableViewCell.self)
    var stationDidSelect : ((BikeStation) -> Void)?
    var list :[BikeStation] = []
     private var filteredList : [BikeStation] = []
     private lazy var resultSearchController : UISearchController = {
         let controller = UISearchController(searchResultsController: nil)
         controller.searchBar.delegate = self
         return controller
     }()
}
// MARK: - Life Cycle
extension SearchController {
    override func viewDidLoad() {
         super.viewDidLoad()
         self.resultSearchController.dimsBackgroundDuringPresentation = false
         self.tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
         self.tableView.tableFooterView = UIView()
         self.tableView.separatorInset = UIEdgeInsets.zero
         self.tableView.tableHeaderView = self.resultSearchController.searchBar
         self.tableView.reloadData()
     }
}

// MARK: - Table view data source
extension SearchController {
     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return  resultSearchController.isActive ? filteredList.count : list.count
     }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? SearchTableViewCell
         let station = resultSearchController.isActive ? self.filteredList[indexPath.row] : self.list[indexPath.row]
         cell?.configCell(station: station)
         return cell!
     }
}
// MARK: - Table view delegate
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = resultSearchController.isActive ? self.filteredList[indexPath.row] : self.list[indexPath.row]
        self.resultSearchController.isActive = false
        self.dismiss(animated: true) {
            self.stationDidSelect?(station)
        }
    }
}

extension SearchController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
          if let term = searchController.searchBar.text {
            self.filteredList = self.list.filter({($0.name?.contains(term) ?? true)})
            self.tableView.reloadData()
          }
    }
}
extension SearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resultSearchController.isActive = false
        self.dismiss(animated: true, completion: nil)
    }
}
