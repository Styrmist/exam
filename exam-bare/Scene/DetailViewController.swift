//
//  DetailViewController.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var neighboursTableView: UITableView!
    
    var countryData: CountriesModel.Country?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
