//
//  ArtistDetail.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation


class ArtistDetail: NSObject {
    
    var name: String
    var images: [AlbumImages]
    

    
    
    init( result: [String:AnyObject])
    {
        
        let name = result["name"] as! String
        var images : [AlbumImages] = []
        if let imageDicts : [[String : Any]] = result["image"] as? [[String : Any]]
        {
            for imageDict : [String : Any] in imageDicts
            {
                print(imageDict)
                let albumImages = AlbumImages(json: imageDict)
                
                
                images.append(albumImages!)
            }
        }
        
        self.name = name
        self.images = images
    }
    
}

    

    

