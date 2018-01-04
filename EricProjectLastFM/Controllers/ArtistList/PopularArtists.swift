//
//  ViewController.swift
//  EricProjectLastFM
//
//  Created by Adrien Meyer on 30/12/2017.
//  Copyright © 2017 Developer.Institute. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class PopularArtists: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, PopularArtistsCollectionViewDelegate {
    
    var artistsList: [Artists] = []
    
    var jsonURLString: String = ("http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=israel&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json")
    
    func updateArtists(artist: Artists?) {
        print("updating")
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return artistsList.count
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ArtistsCell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath) as! ArtistsCell
        
        let list : Artists = self.artistsList[indexPath.row]
        
        cell.delegate = self
        
        cell.updateArtists(artist: list)
    
    
        return cell
        
    }
    
   
    
    @IBOutlet weak var topArtists: UICollectionView!
    
    @IBOutlet weak var selectedCountry: UIButton!
    
    @IBOutlet var countries: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         AccessData()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        AccessData()
        
        self.topArtists.register(UINib(nibName: "ArtistsCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
     
        
        }
        
    
    
    
 
    
    
    
    @IBAction func selectCountry(_ sender: Any)
    {
        
        if selectedCountry.currentTitle == "🇮🇱" {
             countries.text = "france"
             jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=france&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json"
            AccessData()
        selectedCountry.setTitle("🇫🇷", for: .normal)
            AccessData()
            topArtists.reloadData()
        } else  if selectedCountry.currentTitle == "🇧🇪" {
             countries.text = "belgium"
            jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=belgium&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json"
            selectedCountry.setTitle("🇮🇱", for: .normal)
            AccessData()
            topArtists.reloadData()
        } else {
            countries.text = "israel"
            jsonURLString = "http://ws.audioscrobbler.com/2.0/?method=geo.gettopartists&country=israel&api_key=9c0cbfb76c4b7e2b3e4e559d8d0ff13c&format=json"
            selectedCountry.setTitle("🇧🇪", for: .normal)
            AccessData()
            topArtists.reloadData()
        }
    }
    
   
    
  
    func AccessData()
    {
    guard let url = URL(string: jsonURLString) else { return }
        
     MBProgressHUD.showAdded(to: self.mainView, animated: true)
        
    URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let data = data else {return}
   
        DispatchQueue.main.async {
    do {
    if let json = try? JSONSerialization.jsonObject(with: data){
    if let dict = json as? [String:AnyObject] {
if let topartists = dict["topartists"] as? [String:AnyObject] {
    
    if let artists = topartists["artist"] as? [[String:AnyObject]]{
                for result in artists
                {
                    let artist = Artists(result: result)
                    self.artistsList.append(artist)
                    MBProgressHUD.hide(for: self.mainView, animated: true)
        }
       

        
        
        self.topArtists.reloadData()
        }
        
        
        }
        }
    }
    }
        }
    }.resume()
}
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let myVC: ArtistDetailVC = (storyboard?.instantiateViewController(withIdentifier: "ArtistDetailVC") as? ArtistDetailVC)!
        
        myVC.stringPassed = self.artistsList[indexPath.row].name
                navigationController?.pushViewController(myVC, animated: true)
    }
 
    
}






