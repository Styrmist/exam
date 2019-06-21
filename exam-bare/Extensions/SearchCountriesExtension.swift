import UIKit
import Alamofire

extension SearchCountriesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countriesData.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        self.apiManager.call(type: RequestItemsType.search(query: textToSearch)) { (res: Swift.Result<[CountriesModel.Country], AlertMessage>) in
            switch res {
            case .success(let countries):
                self.countriesData.append(contentsOf: countries)
                self.tableView.reloadData()
                break
            case .failure(let message):
                print("alert \(message.title) \(message.body)")
                break
            }
        }
    }
}
