//
//  SortOptionsTableViewController.swift
//  itunes
//
//  Created by Bamby on 1/8/17.
//
//

import UIKit

class SortOptionsTableViewController: UITableViewController {

    let arraySortOptions = ["Price","Genre","Duration"]
    var optionSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.preferredContentSize = CGSize(width: 150, height: 150)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultsView"{
            let vc = segue.destination as! ResultsViewController
            vc.sortOption = optionSelected
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySortOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arraySortOptions[indexPath.row]
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.optionSelected = indexPath.row
        self.performSegue(withIdentifier: "toResultsView", sender: self)
    }

}
