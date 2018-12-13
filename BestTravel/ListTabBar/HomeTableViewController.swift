//
//  HomeTableViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 11/29/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import CoreLocation

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate{
    
    var spots: [Spot] = []
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    static var errorMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        self.searchTextfield.delegate = self
        
        
        getCurrentLocation()
        fetchSpots()
    }
    
    // hidden keyboard when user touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hidden keyboard when "Search" press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.resignFirstResponder()
        
        // replace whitespeace for "%20" for url using.
        FourSquareAPI.currentLocation = textField.text!.replacingOccurrences(of: " ", with: "%20")
        fetchNewSpots()
        
        searchTextfield.text = ""
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as! SpotCell
        cell.spot = spots[indexPath.row]
        return cell
    }
    
    func fetchSpots() {
        FourSquareAPI().getVenue { (spots: [Spot]?, error: Error?) in
            if let spots = spots {
                self.spots = spots
                MapViewController.spots = spots
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let locationLag: Double = (locationManager.location?.coordinate.latitude),
            let locationLng: Double = (locationManager.location?.coordinate.longitude) {
            FourSquareAPI.currentLocation = "\(locationLag),\(locationLng)"
        } else {
            FourSquareAPI.currentLocation = "SF"
        }
    }
    
    func fetchNewSpots() {
        FourSquareAPI().getNewVenue { (spots: [Spot]?, error: Error?) in
            if let spots = spots {
                self.spots = spots
                MapViewController.spots = spots
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            } else {
                let alertController = UIAlertController(title: "Invalid Input", message: FourSquareAPI.errorMessage , preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tapMyLocation(_ sender: Any) {
        getCurrentLocation()
        fetchSpots()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GotoDetailView") {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let spot = spots[indexPath.row]
                let detailViewController = segue.destination as!  DetailViewController
                detailViewController.spot = spot
            }
        }
    }

}
