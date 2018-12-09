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

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    var spots: [Spot] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //navigationItem.titleView = searchBar
        getCurrentLocation()
        
        fetchSpots()
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
                self.tableView.reloadData()
            }
        }
    }
    
    func getCurrentLocation() {
        
        // get user location
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization() // access the location when the app is using
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }
    
    // searchBar function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let newSpot = searchText
        print(newSpot)
        //self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        fetchSpots()
        searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let spot = spots[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.spot = spot
        }
    }

}
