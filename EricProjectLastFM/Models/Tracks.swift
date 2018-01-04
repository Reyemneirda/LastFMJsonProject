//
//  Tracks.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation


class Tracks: NSObject
{
    var trackRank: String
    var trackName: String
    var images: [BigImageForAlbumDetail]
    var duration: String
    
    init( result: [String:AnyObject])
    {
        let attribute = result["@attr"] as! [String:Any]
        
        let trackRank = attribute["rank"] as! String
        
        let trackName = result["name"] as! String
        var images : [BigImageForAlbumDetail] = []
        if let imageDicts : [[String : Any]] = result["image"] as? [[String : Any]]
        {
            for imageDict : [String : Any] in imageDicts
            {
                print(imageDict)
                let albumImages = BigImageForAlbumDetail(json: imageDict)
                
                
                images.append(albumImages!)
            }
        }
        let duration = result["duration"] as! String
        
        self.trackName = trackName
        self.trackRank = trackRank
        self.duration = duration
        self.images = images
    }
}
