//
//  SongTableViewCell.swift
//  itunes
//
//  Created by Bamby on 31/7/17.
//
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageArtwork: UIImageView!
    @IBOutlet weak var labelSongName: UILabel!
    @IBOutlet weak var labelArtistName: UILabel!
    @IBOutlet weak var labelAlbumName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var song: Song? {
        didSet {
            guard let song = song else { return }
            
            labelSongName.text = song.trackName
            labelArtistName.text = song.artist
            labelAlbumName.text = song.album
            labelPrice.text = "$\(String(song.price))"
            labelDuration.text = song.milisecondsToSeconds(miliseconds: song.duration)
            labelGenre.text = song.genre
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageArtwork.layer.cornerRadius = 5
        self.imageArtwork.layer.masksToBounds = true
        
        self.labelGenre.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
