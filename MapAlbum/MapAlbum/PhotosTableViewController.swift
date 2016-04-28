//
//  TableViewController.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController, UISearchResultsUpdating {
    let photoCollection = PhotoCollection.sharedInstance //Singleton an instance of an object that allows other objects to ask for the information. Holds 1 instance of the json and can be asked for it. sharedInstance is the model/ static method of the app
    var filteredPhotos: [Photo]!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "相册"
        
        filteredPhotos = photoCollection.photos
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredPhotos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photocell", forIndexPath: indexPath) as! PhotoTableViewCell
        
        let photo = filteredPhotos[indexPath.row]
        cell.imageTitle.text = photo.title
        cell.imageDescription.text = photo.description
        cell.thumbnailImageView.image = UIImage(named: photo.fileName)
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller:PhotoViewController = segue.destinationViewController as! PhotoViewController
        
        if let row = self.tableView.indexPathForSelectedRow?.row {
            controller.photo = filteredPhotos[row]
        }
    }
    
    // 更新搜索结果
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredPhotos = photoCollection.filter(searchText)
            self.tableView.reloadData()
        }
    }
    
    // 添加编辑事件
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "分享") { (action , indexPath) -> Void in
            self.editing = false
            print("点击了分享")
        }
        shareAction.backgroundColor = UIColor.greenColor()
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "删除") { (action , indexPath) -> Void in
            self.editing = false
            print("点击了删除")
            self.filteredPhotos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [shareAction, deleteAction]
    }
    
    
    // 是否可编辑
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    
    
    
    // 返回编辑类型
    /*
     case None
     case Delete
     case Insert
     */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            filteredPhotos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            
        }
    }
    
}
