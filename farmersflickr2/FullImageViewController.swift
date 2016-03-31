//
//  FullImageViewController.swift
//  farmersflickr2
//
//  Created by Lawrence Chang on 3/30/16.
//  Copyright © 2016 Lawrence Chang. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    var myID = 0
    var myTitle = ""
    var image = UIImage()
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myLabel.text = myTitle + "... right?"
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
