//
//  AlbumsViewCell.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit

protocol ArtistDetailDelegate : NSObjectProtocol
{
    func updateDetails(artist: ArtistDetail?)
}



class AlbumsViewCell: UICollectionViewCell {

    
    weak var delegate: ArtistDetailDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var albumName: UILabel!
    
    var artist: ArtistDetail?
    
    
    func updateDetails(artist: ArtistDetail)
    {
        self.artist = artist
        self.albumName?.text = (self.artist?.name)

        for i in artist.images{
            
            loadImage(imageurl: i)
        }
    }
    
    
    func loadImage(imageurl: AlbumImages)
    {
        
        if imageurl.size == "large" {
            imageView.sd_setImage(with: imageurl.imageUrl)
        }
    }
    

}
