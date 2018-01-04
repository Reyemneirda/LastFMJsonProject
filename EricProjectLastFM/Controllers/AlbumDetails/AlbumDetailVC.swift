//
//  AlbumDetailVC.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class AlbumDetailVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, TracksCollectionDelegate {

    
    

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TracksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath) as! TracksCollectionViewCell
        
        let list : Tracks = self.tracks[indexPath.row]
        
        cell.delegate = self
        
        cell.updateTracks(tracks: list)
        
        
        return cell
    }
    
    @IBOutlet weak var artistTitle: UINavigationItem!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tracksCollection: UICollectionView!
//    var albumPassed: String = ""
    var artistPassed: String = ""
    var albumDetail: ArtistDetail?
    var albumName: String?
    var artistName: String?
    var tracks: [Tracks] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if artistPassed.contains(" "){
            let newString = self.artistPassed.replacingOccurrences(of:" ", with: "+")
            artistName = newString
            print(newString)
        } else {
            artistName = self.artistPassed
        }
        if (albumDetail?.name.contains(" "))!{
            let newString = albumDetail?.name.replacingOccurrences(of:" ", with: "+")
            albumName = newString!
            print(newString)
        } else {
            albumName = albumDetail?.name
        }
        artistTitle.title = albumDetail?.name
        
        self.tracksCollection.register(UINib(nibName: "TracksCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        
        self.image.sd_setImage(with: self.albumDetail?.images.last?.imageUrl, completed: nil)
        
        AccessDetails()
        
        // Do any additional setup after loading the view.
    }

    
    
    func AccessDetails()
    {
        
        let jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&artist=\(String(describing: (artistName?.lowercased())!))&album=\(String(describing: (albumName?.lowercased())!))&format=json"
        
        
        print(jsonURLString)
        
        guard let url = URL(string: jsonURLString) else { return }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data){
                        
                        if let dict = json as? [String:AnyObject] {
                            
                            if let album = dict["album"] as? [String:AnyObject] {
                                
                                if let tracks = album["tracks"] as? [String:AnyObject]
                                {
                                    if let track = tracks["track"] as? [[String:AnyObject]]{
                                    
                                    for result in track
                                    {
                                        
                                        let artist = Tracks(result: result)
                                        
                                        self.tracks.append(artist)
                                        
                                      
            
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                    }
                                        
                                    self.tracksCollection.reloadData()
                                }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
            }.resume()
        
    }
    
    func loadImage(imageurl: BigImageForAlbumDetail)
    {
        
        if imageurl.size == "extralarge"
        {
            image.sd_setImage(with: imageurl.imageUrl)
        }
        
    }
 
    func updateTracks(tracks: Tracks?)
    {
        print("yeah")
    }
    
    

}
