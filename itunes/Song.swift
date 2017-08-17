//
//  Song.swift
//  itunes
//
//  Created by Juan S. Landy on 31/7/17.
//
//

import Foundation

public struct Song{
    let trackName : String
    let album : String
    let artist : String
    let releaseDate : String
    let artwork : String
    let duration: Int
    let genre: String
    let price: Double
    let previewUrl: String
    let kind : String
    
    public init(trackName:String, album:String, artist:String, releaseDate:String, artwork: String, duration:Int, genre:String, price:Double, previewUrl:String, kind: String){
        (self.trackName, self.album, self.artist, self.releaseDate, self.artwork, self.duration, self.genre, self.price, self.previewUrl, self.kind) = (trackName, album, artist, releaseDate, artwork, duration, genre, price, previewUrl, kind)
    }
    
    public init?(json: [String: Any]) {

        self.trackName = (json["trackName"] as? String) ?? ""
        self.album = (json["collectionName"] as? String) ?? ""
        self.artist = (json["artistName"] as? String) ?? ""
        self.releaseDate = (json["releaseDate"] as? String) ?? ""
        self.artwork = (json["artworkUrl100"] as? String) ?? ""
        self.duration = (json["trackTimeMillis"] as? Int) ?? 0
        self.genre = (json["primaryGenreName"] as? String) ?? ""
        self.price = (json["trackPrice"] as? Double) ?? 0.0
        self.previewUrl = (json["previewUrl"] as? String) ?? ""
        self.kind = (json["kind"] as? String) ?? ""
    }
    
    public func milisecondsToSeconds(miliseconds:Int)->String{
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(miliseconds)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter.string(from: dateVar)
    }
    
    public func dateFormat(stringDate:String)->String{
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = myFormatter.date(from: stringDate)
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        let day = calendar.component(.day, from: date!)
        
        return "\(year)/\(month)/\(day)"
        
    }
    
}
