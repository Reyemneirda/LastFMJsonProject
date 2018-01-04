//
//  TracksCollectionViewCell.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit

protocol TracksCollectionDelegate : NSObjectProtocol
{
    func updateTracks(tracks: Tracks?)
}


class TracksCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: TracksCollectionDelegate?

    @IBOutlet weak var trackRank: UILabel!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackTime: UILabel!
    var trackDetails: Tracks? 
    
    
    func secondsMinutesSeconds (seconds : Int) -> String {
        return "(\((seconds % 3600) / 60):\((seconds % 3600) % 60))"
    }
    
    
    
    func updateTracks(tracks: Tracks)
    {
        self.trackDetails = tracks
        self.trackRank.text = tracks.trackRank
        self.trackTitle.text = tracks.trackName
        self.trackTime.text = "Duration: \(secondsMinutesSeconds(seconds: Int(tracks.duration)!))"
        
        
    }
    
    
    
    
}
