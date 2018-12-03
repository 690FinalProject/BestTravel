//
//  HomeTableViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 11/29/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit
import Alamofire

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var post: = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as! SpotCell
        return cell
    }
    

}
