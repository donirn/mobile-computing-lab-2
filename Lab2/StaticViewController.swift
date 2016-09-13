//
//  ViewController.swift
//  Lab1_Task3
//
//  Created by Hui Shen on 09/11/2016.
//  Copyright © 2016 Hui. All rights reserved.


import UIKit

class StatisticViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    @IBOutlet weak var booknbr: UILabel!
    
    @IBOutlet weak var totalCostText: UILabel!
    
    
    @IBOutlet weak var mostExpText: UILabel!
    
    @IBOutlet weak var leastExpText: UILabel!
    
    @IBOutlet weak var AverageText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //  simpleBookManager = appDelegate.simpleBookManager
        //   print("view did load")
        loadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // print("Will appear!")
        //  simpleBookManager = appDelegate.simpleBookManager
        loadData()
    }
    
    func loadData(){
        booknbr.text = String(SimpleBookManager.sharedInstance.count())
        totalCostText.text = String(SimpleBookManager.sharedInstance.totalCost()) + " SEK"
        mostExpText.text = String(SimpleBookManager.sharedInstance.maxPrice()) + " SEK"
        leastExpText.text = String(SimpleBookManager.sharedInstance.minPrice()) + " SEK"
        AverageText.text = String(SimpleBookManager.sharedInstance.meanPrice()) + " SEK"
    }
    
}

