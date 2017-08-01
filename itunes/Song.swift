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
        let date = myFormatter.date(from: "1982-11-30T08:00:00Z")
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date!)
        let month = calendar.component(.month, from: date!)
        let day = calendar.component(.day, from: date!)
        
        return "\(year)/\(month)/\(day)"
        
    }
    
}

/*
 {
 "resultCount":50,
 "results": [
     {
        "wrapperType":"track", 
        "kind":"song", 
        "artistId":32940, 
        "collectionId":159292399, 
        "trackId":159293848, 
        "artistName":"Michael Jackson", 
        "collectionName":"The Essential Michael Jackson", 
        "trackName":"Billie Jean", 
        "collectionCensoredName":"The Essential Michael Jackson", 
        "trackCensoredName":"Billie Jean (Single Version)", 
        "artistViewUrl":"https://itunes.apple.com/us/artist/michael-jackson/id32940?uo=4", 
        "collectionViewUrl":"https://itunes.apple.com/us/album/billie-jean-single-version/id159292399?i=159293848&uo=4", 
        "trackViewUrl":"https://itunes.apple.com/us/album/billie-jean-single-version/id159292399?i=159293848&uo=4",
        "previewUrl":"http://audio.itunes.apple.com/apple-assets-us-std-000001/AudioPreview122/v4/c6/50/11/c6501132-e865-3711-175a-ddb79114e42f/mzaf_3806132797788612279.plus.aac.p.m4a", 
        "artworkUrl30":"http://is2.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/30x30bb.jpg", 
        "artworkUrl60":"http://is2.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/60x60bb.jpg", 
        "artworkUrl100":"http://is2.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg", 
        "collectionPrice":16.99, 
        "trackPrice":1.29, 
        "releaseDate":"1982-11-30T08:00:00Z", 
        "collectionExplicitness":"notExplicit", 
        "trackExplicitness":"notExplicit", 
        "discCount":2, 
        "discNumber":1,
        "trackCount":21, 
        "trackNumber":16, 
        "trackTimeMillis":294601, 
        "country":"USA", 
        "currency":"USD", 
        "primaryGenreName":"Pop", 
        "isStreamable":true
     }
 ]
 }
 */
