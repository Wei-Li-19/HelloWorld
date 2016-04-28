//
//  MapPhotoViewController.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit
import MapKit

class MapPhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    let latDelta = 0.04
    let lonDelta = 0.04
    
    var photo:Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "照片位置"
        
        if let p = photo {
            photoImageView.image = UIImage(named: "\(p.fileName)")
            
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(p.latitude, p.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            mapView.region = region
            
            let annotation:MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = p.title
            annotation.subtitle = p.description
            
            mapView.addAnnotation(annotation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
}
