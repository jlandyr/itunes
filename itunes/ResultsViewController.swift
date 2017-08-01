//
//  ResultsViewController.swift
//  itunes
//
//  Created by Juan S. Landy on 31/7/17.
//
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var arraySongs : [Song] = []
    var cache:NSCache<AnyObject, AnyObject>!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonSort: UIBarButtonItem!
    
    var sortOption = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.becomeFirstResponder()
        self.buttonSort.isEnabled = false
        self.cache = NSCache()
        self.task = URLSessionDownloadTask()
        self.session = URLSession.shared
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSortOptions" {
            if let vctr = segue.destination as? SortOptionsTableViewController {
                vctr.modalPresentationStyle = .popover
                vctr.popoverPresentationController?.delegate = self
                vctr.popoverPresentationController?.sourceView = self.view
            }
        }
    }
    @IBAction func unwindToResultsController(segue: UIStoryboardSegue) {
        if segue.source is SortOptionsTableViewController {
            print("from SortOptionsTableViewController, \(self.sortOption)")
            sortResults(option: self.sortOption)
            self.tableView.reloadData()
        }
    }
    
    func sortResults(option:Int){
        switch option {
        case 0:
            self.arraySongs.sort {($0.price < $1.price)}
            self.buttonSort.title = "Price"
            return
        case 1:
            self.arraySongs.sort {($0.genre < $1.genre)}
            self.buttonSort.title = "Genre"
            return
        case 2:
            self.arraySongs.sort {($0.duration < $1.duration)}
            self.buttonSort.title = "Duration"
            return
        default:
            return
        }
    }

}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySongs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! SongTableViewCell
        let theSong = self.arraySongs[indexPath.row]
        cell.labelSongName.text = theSong.trackName
        cell.labelArtistName.text = theSong.artist
        cell.labelGenre.text = theSong.genre
        cell.labelPrice.text = "$\(String(theSong.price))"
        
        cell.labelDuration.text = theSong.milisecondsToSeconds(miliseconds: theSong.duration)
        cell.labelAlbumName.text = "\(theSong.album), \(theSong.dateFormat(stringDate: theSong.releaseDate))"
        
        
        if (self.cache.object(forKey: theSong.artwork as AnyObject) != nil){
            //Cached image used, no need to download it
            
            DispatchQueue.global(qos: .background).async {
                let theImage = self.cache.object(forKey: theSong.artwork as AnyObject) as? UIImage
                
                DispatchQueue.main.async {
                    cell.activityIndicator.isHidden = true
                    cell.imageArtwork?.image = theImage
                }
            }
        }else{
            //downloading image
            cell.activityIndicator.isHidden = false
            let url:URL! = URL(string: theSong.artwork)
            self.task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    
                    let img:UIImage! = UIImage(data: data)
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        cell.imageArtwork.image = img
                        self.cache.setObject(img, forKey: theSong.artwork as AnyObject)
                        cell.activityIndicator.isHidden = true
                        
                    })
                }
            })
            task.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        nextViewController.arraySongs = self.arraySongs
        nextViewController.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
}
// MARK: - UISearchBarDelegate
extension ResultsViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.arraySongs = []
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
                self.buttonSort.isEnabled = false
                self.buttonSort.title = "Sort"
            })
        }else {
            let a = searchText.replacingOccurrences(of: " ", with: "+")
            DataManage.getDataFromItunesWithSuccess(text: a) {( data) -> Void in
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    return
                }
                guard let apps = json?["results"] as? [[String: Any]] else {
                    return
                }
                self.arraySongs = []
                for item in apps{
                    let song = Song(json: item)
                    self.arraySongs.append(song!)
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView.reloadData()
                    if self.arraySongs.count > 0 {
                        self.buttonSort.isEnabled = true
                    }
                })
            }
            
        }
    }
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
}

extension ResultsViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController)
        -> UIModalPresentationStyle {
            return UIModalPresentationStyle.none
    }
}
