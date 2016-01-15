//
//  ViewController.swift
//  Instagram
//
//  Created by Chun Kwok on 1/14/16.
//  Copyright © 2016 Chun Kwok. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var photoView: UIImageView!
    
    var posts: [NSDictionary]?
    
    // BONUS
    let CellIdentifier = "TableViewCell", HeaderViewIdentifier = "TableViewHeaderView"
    // END BONUS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //BONUS
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
        //END BONUS
        
        tableView.rowHeight = 320
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.posts = responseDictionary["data"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // BONUS
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section][1].count
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier) as UITableViewHeaderFooterView
        header.textLabel.text = data[section][0]
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    //END BONUS
    
    
    /* Excluded to implement bonus
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        else {
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        let post = posts![indexPath.row]
        let image = post["images"]
        //let lowRes = image["low_resolution"] as! String
        
        let lowRes = image!["low_resolution"]
        let imageURL = lowRes!!["url"] as! String
        
        let imageUrl = NSURL(string: imageURL)
        
        cell.photoView.setImageWithURL(imageUrl!)
        
        
        print("row \(indexPath.row)")
        
        return cell
    }
    */


}

