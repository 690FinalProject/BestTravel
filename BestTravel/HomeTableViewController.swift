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

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var spots: [Spot] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let spot = spots[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.spot = spot
        }
    }

}
