//
//  DetailViewController.swift
//  BestTravel
//
//  Created by Jangey Lu on 12/5/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var spot: Spot?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = spot?.spotName
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
