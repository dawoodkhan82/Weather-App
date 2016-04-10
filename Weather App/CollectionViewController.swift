//
//  ViewController.swift
//  Weather App
//
//  Created by Dawood Khan on 4/6/16.
//  Copyright © 2016 Dawood Khan. All rights reserved.
//

import UIKit
import CoreLocation
import ForecastIO


let forecastIOClient = APIClient(apiKey: "7b78999728b449297e2fb88c919625e1")
var locManager = CLLocationManager()


class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var currentLocation = CLLocation()
    
    let iconArray = [UIImage(named: "clear-day"), UIImage(named: "clear-night"), UIImage(named: "rain"), UIImage(named: "snow"), UIImage(named: "sleet"), UIImage(named: "wind"), UIImage(named: "fog"), UIImage(named: "cloudy"), UIImage(named: "partly-cloudy-day")]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup location manager
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
//        locManager.startMonitoringSignificantLocationChanges()
        
        //If authorized, grab location
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                currentLocation = locManager.location!
        }
        
        //Units for weather in US system
        forecastIOClient.units = .US
 
    }
    
    //Return 7 collection view cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    //Update the temperature label, and corresponding weather icon for each day in collection view
    //Weather icons are in the Assets folder
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                
        if (locManager.location != nil) {
                
        forecastIOClient.getForecast(latitude: locManager.location!.coordinate.latitude, longitude: locManager.location!.coordinate.longitude) { (currentForecast, error) -> Void in
            if let currentForecast = currentForecast {
                cell.temperatureLabel.text = "\(currentForecast.daily!.data![indexPath.row].temperatureMin!)℉"
                let currentIcon = currentForecast.daily!.data![indexPath.row].icon?.rawValue
                cell.imageView?.image = UIImage(named: currentIcon!)
            } else {
                print("Could not retrieve forecast")
            }
        }
                
        }
        else {
            print("Cannot retrieve your location")
                }
        }
        
        return cell
        
    }
    
    //When specific cell is selected, perform the "showImage" custom segue
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    //Update the detailed view controller's specific cell that was tapped on
    //The weather details are updated here
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showImage") {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! DetailViewController
            
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                    
                    
                    if (locManager.location != nil) {
                    forecastIOClient.getForecast(latitude: locManager.location!.coordinate.latitude, longitude: locManager.location!.coordinate.longitude) { (currentForecast, error) -> Void in
                        if let currentForecast = currentForecast {
                            let currentIcon = currentForecast.daily!.data![indexPath.row].icon?.rawValue
                            vc.image = UIImage(named: currentIcon!)!
                            vc.title = "\(currentForecast.daily!.data![indexPath.row].temperatureMin!)℉"
                            vc.weatherDetails.text = "\(currentForecast.daily!.data![indexPath.row].summary!)" + " The Humidity is: " +
                                "\(currentForecast.daily!.data![indexPath.row].humidity!)%" + " The Cloud Cover is: " +
                                "\(currentForecast.daily!.data![indexPath.row].cloudCover!)%"
                            
                        } else {
                            print("Could not retrieve forecast")
                        }
                    }
            }
                    else {
                        print("Cannot retrieve your location")
                    }
            }
         
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

