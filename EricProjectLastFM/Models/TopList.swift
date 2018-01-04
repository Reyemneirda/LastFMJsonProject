//
//  ArtistsJSON.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 30/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation

let api_key = "9c0cbfb76c4b7e2b3e4e559d8d0ff13c"

class TopList: Decodable
{
    var artist: [Artists?]
    
    
    init(json: [String:Any]) {
        self.artist = json["artist"] as? [Artists] ?? [nil]
        
       
    }

    
}

// var topartists = [artist,@attr]
//var artist = [0,1,2,3,4,5]
// artist[0] = [name:Radiohead,country:Israel]
