//
//  DetailViewController.swift
//  Weather App
//
//  Created by Dawood Khan on 4/6/16.
//  Copyright © 2016 Dawood Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var weatherDetails: UILabel!
    @IBOutlet var imageView: UIImageView!
    var image = UIImage()

    @IBAction func backSegue(sender: AnyObject) {
        //Perform custom "back" segue
        self.performSegueWithIdentifier("back", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = self.image
        
    }
     

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
