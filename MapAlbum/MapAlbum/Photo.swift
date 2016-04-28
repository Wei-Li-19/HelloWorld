//
//  Photo.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit

class Photo {
    var fileName: String = ""
    var title: String = ""
    var description: String = ""
    var latitude: Double
    var longitude: Double
    var date: NSDate
    
    // 照片模型初始化
    init(fileName: String, title: String, description: String, latitude: Double, longitude: Double, dateString: String) {
        self.fileName = fileName
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.dateFromString(dateString) {
            self.date = date
        } else {
            // 返回当前时间
            self.date = NSDate(timeIntervalSinceNow: 0)
        }
    }
    
}
