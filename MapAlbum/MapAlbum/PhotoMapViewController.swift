//
//  PhotoMapViewController.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let photoCollection = PhotoCollection.sharedInstance
    var selectedPhoto: Photo?
    
    var latDelta:Double = 90.0
    var lonDelta:Double = 180.0
    var latitude:Double = 45.0
    var longitude:Double = -90.0
    var scaleFactor:Double = 1.2
    var templatDelta = 1.0
    var templonDelta = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "相册地图"
        
        determineLocationParameters()
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta * scaleFactor, longitudeDelta: lonDelta * scaleFactor)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.region = region
        
        addPhotoMKAnnotationPoints()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 设置定位参数   让所有的照片的位置都能在地图上显示
    func determineLocationParameters() {
        var minLatitude: Double = 0.0
        var maxLatitude: Double = 90.0
        var minLongitude: Double = -180.0
        var maxLongitude: Double = 0.0
        
        if photoCollection.photos.count > 0 {
            let firstPhoto = photoCollection.photos[0]
            minLatitude = firstPhoto.latitude
            maxLatitude = firstPhoto.latitude
            minLongitude = firstPhoto.longitude
            maxLongitude = firstPhoto.longitude
            
            for photo in photoCollection.photos {
                if photo.latitude < minLatitude {
                    minLatitude = photo.latitude
                } else if photo.latitude > maxLatitude {
                    maxLatitude = photo.latitude
                }
                if photo.longitude < minLongitude {
                    minLongitude = photo.longitude
                } else if photo.longitude > maxLongitude {
                    maxLongitude = photo.longitude
                }
            }
        }
        
        latDelta = maxLatitude - minLatitude
        lonDelta = maxLongitude - minLongitude
        latitude = minLatitude + latDelta / 2
        longitude = minLongitude + lonDelta / 2
    }
    
    /// 添加照片大头针
    func addPhotoMKAnnotationPoints() {
        for photo in photoCollection.photos {
            let annotation:PhotoMKPointAnnotation = PhotoMKPointAnnotation()
            annotation.photo = photo
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(photo.latitude, photo.longitude)
            annotation.coordinate = location
            annotation.title = photo.title
            annotation.subtitle = photo.description
            
            mapView.addAnnotation(annotation)
        }
    }
    
    /// MKMapViewDelgate 的代理方法 返回一个大头针视图
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = PhotoMKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
        let photoPointAnnotation = annotation as! PhotoMKPointAnnotation
        pinView.photo = photoPointAnnotation.photo
        pinView.canShowCallout = true
        let button = UIButton(type: .DetailDisclosure)
        pinView.rightCalloutAccessoryView = button
        if let photo = photoPointAnnotation.photo {
            let imageView = UIImageView(image: UIImage(named: photo.fileName))
            imageView.contentMode = .ScaleAspectFill
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            pinView.leftCalloutAccessoryView = imageView
        }
        return pinView
    }
    
    ///MKMapViewDelgate 的代理方法  点击注释视图按钮
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let photoPinView = view as! PhotoMKPinAnnotationView
        if let photo = photoPinView.photo {
            selectedPhoto = photo
            self.performSegueWithIdentifier("PhotoDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController:PhotoViewController = segue.destinationViewController as? PhotoViewController {
            viewController.photo = selectedPhoto
        }
    }
    
    
}
