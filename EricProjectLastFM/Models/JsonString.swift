//
//  JsonString.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import Foundation
class JsonString {

    var country: String
    
    init(country:String){
            var jsonURL = ("http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=\(country)&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json")
    }
    
}
