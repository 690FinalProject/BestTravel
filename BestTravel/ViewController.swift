//
//  ViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 11/28/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let client_id = "FXPLHIF0E053NMZ0F2SLUPBKBHL15WHJQ2HGKBZPEVGXFFRR"
        let client_secret = "J0A0KQAMFSGR4MM0GKXX04MQH312SSGFY2JVV35KQBHN3THH"

        // get current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyymmdd"
        let currentDate = formatter.string(from: date)
        
        
        let urlString = "https://api.foursquare.com/v2/venues/explore?near=SF&client_id=\(client_id)&client_secret=\(client_secret)&v=\(currentDate)"
        
        Alamofire.request(urlString).responseJSON { response in
            //debugPrint(response)
            guard
                let jsonDictionary = response.result.value as? [String: Any],
                let response = jsonDictionary["response"] as? [String: Any],
                let groups = response["groups"] as? [[String: Any]],
                let items = groups[0]["items"] as? [[String: Any]],
                
                let venue = items[0]["venue"] as? [String: Any],
                let name = venue["name"] as? String
                else {
                    return
            }
            print(name)
        }
        
        print("test")
    }


}

