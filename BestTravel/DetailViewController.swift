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
    @IBOutlet weak var spotTips: UILabel!
    
    
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
            let photoURL = URL(string: "https://api.foursquare.com/v2/venues/\(id)/photos?&client_id=\(FourSquareAPI.client_id)&client_secret=\(FourSquareAPI.client_secret)&v=\(currentDate)")!
            
            Alamofire.request(photoURL).responseJSON { (response) in
                if
                    let dataDictionary = response.result.value as? [String: Any],
                    let response = dataDictionary["response"] as? [String: Any],
                    let photos = response["photos"] as? [String: Any],
                    let count = photos["count"] as? Int {
                    if (count>0) {
                        let items = photos["items"] as? [[String: Any]]
                        let suffix = items![0]["suffix"] as! String
                        
                        let imgAddress = "https://fastly.4sqi.net/img/general/360x240\(suffix)"
                        let imgURL = URL(string: imgAddress)!
                        self.spotImage.af_setImage(withURL: imgURL)
                    } else {
                        let noImgAddress = "https://vignette.wikia.nocookie.net/simpsons/images/6/60/No_Image_Available.png/revision/latest?cb=20170219125728"
                        let noIMGURL = URL(string: noImgAddress)!
                        self.spotImage.af_setImage(withURL: noIMGURL)
                    }
                }
            }
            
            let tipsURL = URL(string: "https://api.foursquare.com/v2/venues/\(id)/tips?&client_id=\(FourSquareAPI.client_id)&client_secret=\(FourSquareAPI.client_secret)&v=\(currentDate)")!
            
            Alamofire.request(tipsURL).responseJSON { (response) in
                if
                    let dataDictionary = response.result.value as? [String: Any],
                    let response = dataDictionary["response"] as? [String: Any],
                    let tips = response["tips"] as? [String: Any],
                    let count = tips["count"] as? Int {
                    if (count>0) {
                        let items = tips["items"] as? [[String: Any]]
                        let text = items![0]["text"] as! String

                        self.spotTips.text = text
                    } else {
                        self.spotTips.text = "No tips guide for this spot yet!"
                    }
                }
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
