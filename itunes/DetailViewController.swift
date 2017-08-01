//
//  DetailViewController.swift
//  itunes
//
//  Created by Juan S. Landy on 31/7/17.
//
//

import UIKit
import AVFoundation

var audioPlayer = AVPlayer()

class DetailViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelAlbum: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var buttonPlayPause: UIButton!
    
    var arraySongs : [Song] = []
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSelectedSong( index: selectedIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let buttonShareSong = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSong))
        navigationItem.rightBarButtonItems = [buttonShareSong]
    }
    
    func getSelectedSong(index: Int) {
        let selectedSong = arraySongs[index]
        
        self.imageCover.image = nil
        self.labelTitle.text = selectedSong.trackName
        self.labelArtist.text = selectedSong.artist
        self.labelAlbum.text = selectedSong.album
        self.labelReleaseDate.text = "\(selectedSong.dateFormat(stringDate: selectedSong.releaseDate))"
        
        DataManage.loadImageFromURL(url: URL(string: selectedSong.artwork)!) { (data, error) -> Void in
            if let imageData = data {
                
                DispatchQueue.global(qos: .background).async {
                    let playerItem = AVPlayerItem(url: URL(string: selectedSong.previewUrl)!)
                    audioPlayer = AVPlayer(playerItem:playerItem)
                    audioPlayer.volume = 1.0
                    
                    
                    DispatchQueue.main.async {
                        self.imageBackground.image = UIImage(data: imageData)
                        self.imageCover.image = UIImage(data: imageData)
                        self.pressPlayButton()
                    }
                }
                
            }
        }
        
    }
    
    //MARK: - Buttons
    @IBAction func previousSong(_ sender: UIButton) {
        if selectedIndex > 0{
            selectedIndex -= 1
            getSelectedSong(index: selectedIndex)
        }else if selectedIndex == 0
        {
            let time2: CMTime = CMTimeMake(Int64(0 * 1000 as Float64), 1000)
            audioPlayer.seek(to: time2)
        }
    }
    @IBAction func playPause(_ sender: UIButton) {
        if audioPlayer.rate <= 0.0 {
            pressPlayButton()
        }else{
            pressPauseButton()
        }
    }
    @IBAction func nextSong(_ sender: UIButton) {
        if selectedIndex < self.arraySongs.count - 1{
            selectedIndex += 1
            getSelectedSong(index: selectedIndex)
        }
    }

    func pressPlayButton(){
        self.buttonPlayPause.setTitle("Pause", for: .normal)
        audioPlayer.play()
    }
    func pressPauseButton(){
        self.buttonPlayPause.setTitle("Play", for: .normal)
        audioPlayer.pause()
    }
    
    //MARK: - Share song
    func shareSong(){
        
        let selectedSong = arraySongs[selectedIndex]
        let text = "\(selectedSong.trackName), \(selectedSong.artist), \(selectedSong.previewUrl)"
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.print ]
        self.present(activityViewController, animated: true, completion: nil)
    }

}
