//
//  ArtistDetailVC.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 02/01/2018.
//  Copyright © 2018 Developer.Institute. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ArtistDelegate : NSObjectProtocol // MUST inherit from NSObjectProtocol
{
    func artistInfo(artist: ArtistDetail)
}

class ArtistDetailVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, PopularArtistsCollectionViewDelegate, ArtistDelegate {
    
    func artistInfo(artist: ArtistDetail) {
     print("updating")
    }
    
    
    
    weak var delegate : ArtistDelegate?
    
    @IBOutlet weak var artistTitle: UINavigationItem!
    
    @IBOutlet weak var collectionViewAlbum: UICollectionView!
    
    var stringPassed: String = ""
    var artistName: String?
    var albumDetails: [ArtistDetail] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if stringPassed.contains(" "){
            let newString = stringPassed.replacingOccurrences(of:" ", with: "+")
            artistName = newString
            print(newString)
        } else {
        artistName = (stringPassed)
        }
        artistTitle.title = stringPassed
        AccessDetails()
        
        self.collectionViewAlbum.register(UINib(nibName: "AlbumsViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : AlbumsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath) as! AlbumsViewCell
        
        let list : ArtistDetail = self.albumDetails[indexPath.row]
        
        cell.delegate = self as? ArtistDetailDelegate
        
        cell.updateDetails(artist: list)
        
        
        return cell
    }
    
    func updateArtists(artist: Artists?) {
        print("updating")
    }
    


    func AccessDetails()
    {
        
        let jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&limit=20&artist=\(String(describing: (artistName?.lowercased())!))&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json"
        
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else { return }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data){
                        if let dict = json as? [String:AnyObject] {
                            if let topalbums = dict["topalbums"] as? [String:AnyObject] {
                                
                                if let album = topalbums["album"] as? [[String:AnyObject]]{
                                    for result in album
                                    {
                                        let artist = ArtistDetail(result: result)
                                        
                                        self.albumDetails.append(artist)
                                        
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                    }
                                    
                                    self.collectionViewAlbum.reloadData()
                                }
                                
                                
                            }
                        }
                    }
                }
            }
            }.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let myVC: AlbumDetailVC = (storyboard?.instantiateViewController(withIdentifier: "AlbumDetailVC") as? AlbumDetailVC)!
        
        myVC.artistPassed = self.artistName!
        myVC.albumDetail = self.albumDetails[indexPath.row];        navigationController?.pushViewController(myVC, animated: true)
        //        performSegue(withIdentifier: "artistInfo", sender: self)
    }
    
}


