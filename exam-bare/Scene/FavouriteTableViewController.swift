//
//  FavouriteTableViewController.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import Alamofire

class FavouriteTableViewController: UITableViewController {
    
    private let cellIdentifier = "favouriteCell"
    private let apiManager = APIManager(sessionManager: SessionManager())
    var countriesData = [CountriesModel.Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourite"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countriesData.removeAll()
        for country in Constants.savedCountries {
            apiManager.call(type: RequestItemsType.searchByCode(query: country)) { (res: Swift.Result<CountriesModel.Country, AlertMessage>) in
                switch res {
                case .success(let country):
                    self.countriesData.append(country)
                    self.tableView.reloadData()
                    break
                case .failure(let message):
                    print("alert \(message.title) \(message.body)")
                    break
                }
            }
        }
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            if let cellIndex = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                
                detailVC.countryData = countriesData[cellIndex.row]
                
            }
        }
    }
}
