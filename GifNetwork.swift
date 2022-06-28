//
//  GifNetwork.swift
//  GiphySearch
//
//  Created by Reinis Antons on 20/06/2022.
//

import Foundation

class GifNetwork {
    var apiKey = "ccHq2a7mdqskF7dXOafj2VEe1RqoYMFk"
    
    /**
    Fetches gifs from the Giphy api
    -Parameter searchTerm: What  we should query gifs of.
    -Returns: Optional array of gifs
    */
    func fetchGifs(searchTerm: String, completion: @escaping (_ response: GifArray?) -> Void) {
        // Create a GET url request
        let url = ViewController.urlBuilder(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                // Decode the data into array of Gifs
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
        }.resume()
    }
}
