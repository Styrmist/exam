//
//  SearchCountriesTableViewController.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import Alamofire

class SearchCountriesTableViewController: UITableViewController {
    
    var countriesData = [CountriesModel.Country]()
    let apiManager = APIManager(sessionManager: SessionManager())
    let cellIdentifier = "searchCell"

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search"
        searchBar.delegate = self
        searchBar.placeholder = "Search any Topic"
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryLatinTableViewCell
        cell.nameLatinLabel.text = countriesData[indexPath.row].name
        cell.flagImage.image = getFlag(country: countriesData[indexPath.row].alpha2Code).emojiToImage()
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            if let cellIndex = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                detailVC.countryData = countriesData[cellIndex.row]
            }
        }
    }
}
