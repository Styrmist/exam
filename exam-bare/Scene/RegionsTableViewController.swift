//
//  RegionsTableViewController.swift
//  exam-bare
//
//  Created by Kirill on 6/16/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class RegionsTableViewController: UITableViewController {

    let regions = ["Africa", "Americas", "Asia", "Europe", "Oceania"]
    let regionBlocks = ["EU", "EFTA", "CARICOM", "PA", "AU", "USAN", "EEU", "AL", "ASEAN", "CAIS", "CEFTA", "NAFTA", "SAARC"]
    let cellIdentifier = "regionCell"
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return regions.count
        case 1:
            return regionBlocks.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RegionsTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.regionNameLabel.text = regions[indexPath.row]
        case 1:
            cell.regionNameLabel.text = regionBlocks[indexPath.row]
        default:
            return cell
        }
        
        return cell
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
