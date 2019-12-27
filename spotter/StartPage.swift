//
//  ViewController.swift
//  spotter
//
//  Created by Артём Шишкин on 17.12.2019.
//  Copyright © 2019 Артём Шишкин. All rights reserved.
//

import UIKit

class StartPage: UIViewController {
    
    var location = Int()
    
    @IBOutlet weak var lableText: UILabel!
     
    @IBOutlet weak var location3: UIButton!
    @IBOutlet weak var location2: UIButton!
    @IBOutlet weak var location1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        location2.layer.cornerRadius = location2.frame.height / 5
        location2.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        location2.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        location2.layer.shadowOpacity = 1.0
        location2.layer.shadowRadius = 5.0
        location2.layer.masksToBounds = false
        
        location3.layer.cornerRadius =  location3.frame.height / 5
        location3.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        location3.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        location3.layer.shadowOpacity = 1.0
        location3.layer.shadowRadius = 5.0
        location3.layer.masksToBounds = false
        
        location1.layer.cornerRadius =  location1.frame.height / 5
        location1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        location1.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        location1.layer.shadowOpacity = 1.0
        location1.layer.shadowRadius = 5.0
        location1.layer.masksToBounds = false
        
        
        
    }
    
    
    
    
    
    @IBAction func pressed(_ sender: UIButton) {
        
        location = sender.tag
        print(location)
        performSegue(withIdentifier: "goToGame", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SecondPage
        
        destinationVC.location = location
        
    }
    
    
}



