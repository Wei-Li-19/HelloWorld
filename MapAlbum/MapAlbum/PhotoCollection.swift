//
//  PhotoCollection.swift
//  MapAlbum
//
//  Created by lw on 16/4/19.
//  Copyright © 2016年 一苇渡江. All rights reserved.
//

import UIKit

class PhotoCollection {
    
    // 创建照片数组的单例
    static let sharedInstance = PhotoCollection(fileName: "photos")
    
    private init(fileName:String) {
        loadFromJSONFile(fileName)
    }
    
    var photos:[Photo] = Array<Photo>()
    
    private func loadFromJSONFile(fileName: String) {
        let bundle = NSBundle.mainBundle()
        
        if let path = bundle.pathForResource(fileName, ofType: "json"), jsonData = NSData(contentsOfFile: path) {
            parseJson(jsonData)
        }
    }
    
    /// 解析json中的数据
    private func parseJson(jsonData: NSData) {
        photos = Array<Photo>()
        var jsonResultWrapped: NSDictionary?
        do {
            jsonResultWrapped = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        } catch {
            return
        }
        
        //
        if let jsonResult = jsonResultWrapped where jsonResult.count > 0 {
            if let status = jsonResult["status"] as? String where status == "ok" {
                if let photoList = jsonResult["photos"] as? NSArray {
                    
                    //将解析数据添加到照片数组中
                    for photo in photoList{
                        if let fileName = photo["image"] as? String,
                            title = photo["title"] as? String,
                            description = photo["description"] as? String,
                            latitude = photo["latitude"] as? Double,
                            longitude = photo["longitude"] as? Double,
                            date = photo["date"] as? String {
                            
                            self.photos.append(Photo(fileName: fileName, title: title, description: description,
                                latitude: latitude, longitude: longitude, dateString: date))
                        }
                    }
                }
            }
        }
    }
    
    // 返回搜索结果数组
    func filter(searchText: String) -> Array<Photo> {
        if searchText.isEmpty {
            return photos
        }
        
        var filteredPhotos = Array<Photo>()
        
        for photo in photos {
            
            // 不区分大小写，在photo的title和description中查找搜索栏中的字符串
            if photo.title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                filteredPhotos.append(photo)
            } else if photo.description.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                filteredPhotos.append(photo)
            }
        }
        return filteredPhotos
    }
    
}
