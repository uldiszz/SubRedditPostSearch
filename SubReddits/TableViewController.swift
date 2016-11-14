//
//  TableViewController.swift
//  SubReddits
//
//  Created by Uldis Zingis on 14/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        searchBar.resignFirstResponder()

        PostsController.sharedInstance.searchForPostsIn(subreddit: term) { (isSuccess, error) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                NSLog("Search for posts in subreddit '\(term)' was unsuccessful. Error: \(error)")
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        PostsController.sharedInstance.clearSearch()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsController.sharedInstance.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let post = PostsController.sharedInstance.posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.author

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            guard let nextVC = segue.destination as? WebViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let post = PostsController.sharedInstance.posts[indexPath.row]
            nextVC.urlString = post.url
        }
    }
}


