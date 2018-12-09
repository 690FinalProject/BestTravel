//
//  DetailViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 12/5/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotAddress: UILabel!
    
    
    var spot: Spot?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = spot?.spotName
        spotName.text = spot?.spotName
        spotAddress.text = spot?.spotAddress
        
        fetchImages()
    }
    
    func fetchImages() {
        // get current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyymmdd"
        let currentDate = formatter.string(from: date)
        
        if let id = spot?.id {
            let url = URL(string: "https://api.foursquare.com/v2/venues/\(id)/photos?&client_id=\(FourSquareAPI.client_id)&client_secret=\(FourSquareAPI.client_secret)&v=\(currentDate)")!
            
            Alamofire.request(url).responseJSON { (response) in
                guard
                    let dataDictionary = response.result.value as? [String: Any],
                    let response = dataDictionary["response"] as? [String: Any],
                    let photos = response["photos"] as? [String: Any],
                    let items = photos["items"] as? [[String: Any]],
                    let suffix = items[0]["suffix"] as? String
                
                else {
                    return
                }
                let imgAddress = "https://fastly.4sqi.net/img/general/360x240\(suffix)"
                let imgURL = URL(string: imgAddress)!
                self.spotImage.af_setImage(withURL: imgURL)
            }
        }
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
