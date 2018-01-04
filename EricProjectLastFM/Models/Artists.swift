//
//  Artists.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 30/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation

 let jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=israel&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json"

class Artists: NSObject
{
    
    var name: String
    var mbid: String
    var url: String
    var images: [ArtistImage]
    var listeners: String

    init( result: [String:AnyObject])
    {
        
        let name = result["name"] as! String
        let mbid = result["mbid"] as! String
        let url = result["url"] as! String
        let listeners = result["listeners"] as? String ?? ""
        
        var images : [ArtistImage] = []
        if let imageDicts : [[String : Any]] = result["image"] as? [[String : Any]]
        {
            for imageDict : [String : Any] in imageDicts
            {
                let artistImage = ArtistImage(json: imageDict)
                images.append(artistImage!)
            }
        }
        
        self.name = name
        self.mbid = mbid
        self.url = url
        self.listeners = listeners
        self.images = images
    }
                        
}
