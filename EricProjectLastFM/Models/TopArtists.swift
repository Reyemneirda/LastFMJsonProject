//
//  Topartist.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 31/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import Foundation

class TopArtists: Decodable
{
    var topartists: [String:[String]]
    
    
    init(json: [String:Any]) {
        self.topartists = json["topartists"] as? [String:[String]] ?? ["":[""]]
        
        
    }
    
    
}
// var topartists = [artist,@attr]
//var artist = [0,1,2,3,4,5]
// artist[0] = [name:Radiohead,country:Israel]

