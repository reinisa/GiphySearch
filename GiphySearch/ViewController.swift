//
//  ViewController.swift
//  GiphySearch
//
//  Created by Reinis Antons on 18/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var network = GifNetwork()
    var gifs = [Gif]()
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    /// Setup tableview delegates.
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        // Search bar
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
    }
    /**
        Fetches gifs based on the search term and populates tableview
        - Parameter searchTerm: The string to search gifs of
        */
        func searchGifs(for searchText: String) {
            network.fetchGifs(searchTerm: searchText) { gifArray in
                if gifArray != nil {
                    self.gifs = gifArray!.gifs
                    self.tableView.reloadData()
                }
            }
        }
    /**
        Fetches gifs based on the search term and populates tableview
        - Parameter searchTerm: The string to search gifs of
        */
        func fetchGifs(for searchText: String) {
            network.fetchGifs(searchTerm: searchText) { gifArray in
                if gifArray != nil {
                    print(gifArray!.gifs.count)
                    self.gifs = gifArray!.gifs
                    self.tableView.reloadData()
                }
            }
        }
    /**
        Returns a url with our API key and search term
        - Parameter searchTerm: The string to search gifs of
        - Returns: URL of search term & api key
        */
        static func urlBuilder(searchTerm: String) -> URL {
            let apiKey = "ccHq2a7mdqskF7dXOafj2VEe1RqoYMFk"
            let apikey = apiKey
            var components = URLComponents()
               components.scheme = "https"
               components.host = "api.giphy.com"
               components.path = "/v1/gifs/search"
               components.queryItems = [
                   URLQueryItem(name: "api_key", value: apikey),
                   URLQueryItem(name: "q", value: searchTerm),
                   URLQueryItem(name: "limit", value: "3") // Edit limit to display more gifs
               ]
            return components.url!
        }
    
    
}
// MARK: - Tableview functions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell") as! GifCell
        cell.gif = gifs[indexPath.row]
        return cell
    }
}
// MARK: - Search bar functions
extension ViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
                fetchGifs(for: textField.text!)
        }
        return true
    }
}
