//
//  Spot.swift
//  BestTravel
//
//  Created by Jangey Lu on 12/3/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import Foundation

class Spot {
    var spotName: String
    var description: String
    
    
    init(dictionary: [String: Any]) {
        let venue = dictionary["venue"] as? [String: Any]
        let categories = venue!["categories"] as? [[String: Any]]
        
        spotName = venue!["name"] as? String ?? "No title"
        description = categories![0]["name"] as? String ?? "No description"
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
    
    class func spots(dictionaries: [[String: Any]]) -> [Spot] {
        var spots: [Spot] = []
        for dictionary in dictionaries {
            let spot = Spot(dictionary: dictionary)
            spots.append(spot)
        }
        
        return spots
    }
    
}
