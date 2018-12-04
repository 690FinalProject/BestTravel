//
//  FourSquareAPI.swift
//  BestTravel
//
//  Created by Jangey Lu on 12/3/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import Foundation

class FourSquareAPI {
    
    static let client_id = "FXPLHIF0E053NMZ0F2SLUPBKBHL15WHJQ2HGKBZPEVGXFFRR"
    static let client_secret = "J0A0KQAMFSGR4MM0GKXX04MQH312SSGFY2JVV35KQBHN3THH"

    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func getVenue(completion: @escaping ([Spot]?, Error?) -> ()) {
        // get current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyymmdd"
        let currentDate = formatter.string(from: date)


        let url = URL(string: "https://api.foursquare.com/v2/venues/explore?near=SF&client_id=\(FourSquareAPI.client_id)&client_secret=\(FourSquareAPI.client_secret)&v=\(currentDate)")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                let response = dataDictionary["response"] as! [String: Any]
                let groups = response["groups"] as! [[String: Any]]
                let items = groups[0]["items"] as! [[String: Any]]
                
                let spots = Spot.spots(dictionaries: items)
                
                completion(spots, nil)
            } else {
                completion(nil, error)
            }
        }
        
//        Alamofire.request(urlString).responseJSON { response in
//            //debugPrint(response)
//            guard
//                let jsonDictionary = response.result.value as? [String: Any],
//                let response = jsonDictionary["response"] as? [String: Any],
//                let groups = response["groups"] as? [[String: Any]],
//                let items = groups[0]["items"] as? [[String: Any]],
//
//                let venue = items[0]["venue"] as? [String: Any],
//                let name = venue["name"] as? String
//
//                else {
//                    return
//            }
//            print(venue)
//            self.spots = Spot.spots(dictionaries: items)
//
//        }
        task.resume()
    }
}
