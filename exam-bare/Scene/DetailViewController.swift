//
//  DetailViewController.swift
//  exam-bare
//
//  Created by Kirill on 6/17/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var neighboursTableView: UITableView!
    @IBOutlet weak var boardWithLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableHighConstraint: NSLayoutConstraint!
    
    var countryData: CountriesModel.Country?
    var countryNeihbours = [CountriesModel.Country?]()
    let apiManager = APIManager(sessionManager: SessionManager())
    let cellIdentifier = "detailCell"
    var saved = false
    
    @IBAction func saveClicked(_ sender: UIButton) {
        if saved {
            Constants.savedCountries = Constants.savedCountries.filter {$0 != countryData?.alpha2Code}
            saved = false
            saveButton.setImage(UIImage(named: "star"), for: .normal)
        }else{
            Constants.savedCountries.append(countryData!.alpha2Code)
            saved = true
            saveButton.setImage(UIImage(named: "unstar"), for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        neighboursTableView.dataSource = self
        neighboursTableView.delegate = self
        self.navigationItem.title = countryData?.name
        
        if Constants.savedCountries.contains(countryData!.alpha2Code) {
            saved = true
            saveButton.setImage(UIImage(named: "unstar"), for: .normal)
        }
        let emojiFlag: String = getFlag(country: countryData!.alpha2Code)
        flagImage.image = emojiFlag.emojiToImage()
        currenciesLabel.text = (countryData?.currencies.compactMap { $0.code })?.joined(separator: ", ")
        languagesLabel.text = countryData?.languages.compactMap { $0.name }.joined(separator: ", ")
        
        centerMapOnLocation(map: locationMap, size: countryData?.area)
        
        for countryCode in countryData!.borders {
            apiManager.call(type: RequestItemsType.searchByCode(query: countryCode)) { (res: Swift.Result<CountriesModel.Country, AlertMessage>) in
                switch res {
                case .success(let country):
                    self.countryNeihbours.append(country)
                    if self.countryNeihbours.count == self.countryData?.borders.count {
                        self.tableHighConstraint.constant = self.neighboursTableView.rowHeight * CGFloat(self.countryNeihbours.count)
                        self.neighboursTableView.reloadData()
                    }
                    break
                case .failure(let message):
                    print("alert \(message.title) \(message.body)")
                    break
                }
            }
        }
    }
    
    func centerMapOnLocation(map: MKMapView, size: Double?) {
        var lat: Double
        var lng: Double
        if self.countryData?.latlng.count != 0{
            lat = (self.countryData?.latlng[0])!
            lng = (self.countryData?.latlng[1])!
        }else{
            map.isHidden = true
            return
        }
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let width = Double(map.frame.width)
        let height = Double(map.frame.height)
        let delta = (size ?? (width * height)) / (width * height) // if size is unknown, delta = 1
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(coordinateRegion, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countryNeihbours.count == 0 {
            boardWithLabel.text = "\(countryData!.name) has no boards with other countries"
        }else{
            boardWithLabel.text = "Borders with:"
        }
        return self.countryNeihbours.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryLatinOriginTableViewCell
        guard let currentCountry = self.countryNeihbours[indexPath.row] else { return cell }
        cell.selectionStyle = .none
        cell.nameLatinLabel.text = currentCountry.name
        cell.nameOriginLabel.text = currentCountry.nativeName
        cell.flagImage.image = getFlag(country: currentCountry.alpha2Code).emojiToImage()
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToDetailSegue" {
            if let cellIndex = self.neighboursTableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                guard let currentCountry = self.countryNeihbours[cellIndex.row] else { return }
                
                detailVC.countryData = currentCountry
            }
        }
    }
}
