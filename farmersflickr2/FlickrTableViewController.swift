//
//  FlickrTableViewController.swift
//  farmersflickr2
//
//  Created by Lawrence Chang on 3/28/16.
//  Copyright © 2016 Lawrence Chang. All rights reserved.
//

import UIKit

class FlickrTableViewController: UITableViewController {

    var feeds : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print ("In numberOfSectionsInTableView...")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print ("In numberOFRowsInSection...")
        let count = self.feeds!.count
        //print ("I think I have \(count) items in the table.")
        return count
    }
    
    func setup() {
        
        self.feeds = NSMutableArray()
        
        if let flickrURL = NSURL(string: "https://api.flickr.com/services/feeds/photos_public.gne?tags=gardenning&;tagmode=any&format=json&nojsoncallback=1") {
            
            NSURLSession.sharedSession().dataTaskWithURL(flickrURL,completionHandler: { (data :NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                var error:NSError? = nil
                
                let list : NSDictionary?
                    
                do {
                    let fixed = self.fixBadJSON(data!)
                    list = try NSJSONSerialization.JSONObjectWithData(fixed, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                    print("Successfully parsed the JSON from Flickr.")
                } catch {
                    print("Error attempting to parse JSON from Flickr:")
                    print(result)
                    //print(data!)
                    print("Error message: \(error)")
                    return
                }
                

                let items = list!.valueForKey("items") as! NSArray
                
                for item in items {
                    let dictionaryItem = item as! NSDictionary
                    let feed = FlickrFeed()
                    feed.title = dictionaryItem.valueForKey("title") as? NSString
                    feed.media = dictionaryItem.valueForKeyPath("media.m") as? NSString
                    self.feeds?.addObject(feed)
                }
                print("Parsed dictionary.")
                dispatch_async(dispatch_get_main_queue(),
                    { () -> Void in
                        self.tableView.reloadData()
                        print("Called table's reloadData")
                })
            }).resume()
        }
    }
    
    // Flickr returns improper JSON. This code replaces the \' escape character.
    func fixBadJSON(data: NSData) -> NSData {
        let result = NSString(data: data, encoding: NSUTF8StringEncoding)
        let corrected = result!.stringByReplacingOccurrencesOfString("\\'", withString: "'")
        return corrected.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! FlickrFeedTableViewCell

        // Configure the cell...
        let feed = self.feeds![indexPath.row] as! FlickrFeed
        //cell.textLabel?.text = feed.title as! String
        cell.nameLabel?.text = feed.title as! String
        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: NSURL(string: feed.media as! String)!)!)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
