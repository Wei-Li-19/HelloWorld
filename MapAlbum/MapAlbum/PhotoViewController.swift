//
//  PhotoViewController.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "照片"
        
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let p = photo {
            titleLabel.text = p.title
            descriptionLabel.text = p.description
            dateLabel.text = dateFormatter.stringFromDate(p.date)
            latitudeLabel.text = "\(p.latitude)"
            longitudeLabel.text = "\(p.longitude)"
            photoImageView.image = UIImage(named: p.fileName)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller:MapPhotoViewController = segue.destinationViewController as! MapPhotoViewController
        controller.photo = photo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
