//
//  CustomSegue.swift
//  Weather App
//
//  Created by Dawood Khan on 4/6/16.
//  Copyright © 2016 Dawood Khan. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController
        
        //Add destination view controller as subview
        sourceVC.view.addSubview(destinationVC.view)
        
        //Transform destination view controller
        destinationVC.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
        
        //Animation
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            
            //Bring in new view controller at 0.8 scale
            destinationVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8)
                
            }) { (finished) -> Void in
                //Remove from superview
                destinationVC.view.removeFromSuperview()
                    
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
                    
                dispatch_after(time, dispatch_get_main_queue()) {
                        
                sourceVC.presentViewController(destinationVC, animated: false, completion: nil)
                        
                    }
            }
        }
    
}
