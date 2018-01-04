//
//  ArtistsCell.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 30/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import SDWebImage

protocol PopularArtistsCollectionViewDelegate : NSObjectProtocol
{
    func updateArtists(artist: Artists?)
}


class ArtistsCell: UICollectionViewCell {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var listeners: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    weak var delegate:PopularArtistsCollectionViewDelegate?
    
    var artist :Artists?
    
    
    func updateArtists(artist: Artists) {
        self.artist = artist
        self.artistName?.text = (self.artist?.name)
        self.listeners?.text = "Listeners: \((self.artist?.listeners)!)"
        
        for i in artist.images{
            loadImage(imageurl: i)
        }
    }
    
    
    func loadImage(imageurl: ArtistImage)
    {
    
        if imageurl.size == "small" {
            artistImage.sd_setImage(with: imageurl.imageUrl)
            }
    }
    
    
}
