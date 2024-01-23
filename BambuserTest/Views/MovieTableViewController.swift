//
//  MovieTableViewController.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

class MovieTableViewController: BaseViewController {

    let presenter: MoviePresenter = MoviePresenter()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("TMDB Popular Movies", comment: "TMDB Popular Movies")
        
        self.presenter.delegate = self
        self.presenter.getPopularMovies()
        
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reloadMovies), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? MovieDetailViewController, let movie = sender as? Movie {
            viewController.posterImageUrl = self.presenter.getPosterOriginalFullPath(identifier: movie.posterPath)
            viewController.movie = movie
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func reloadMovies() {
        if self.searchBar.isFirstResponder {
            self.tableView.refreshControl?.endRefreshing()
        } else {
            self.presenter.getPopularMovies(refresh: true)
        }
    }

    // TODO: Move to a custom navigation controller subclass
    @IBAction func toggleMode(_ sender: UISwitch) {
        Self.applicationUserInterfaceStyle = sender.isOn ? UIUserInterfaceStyle.dark : UIUserInterfaceStyle.light
        NotificationCenter.default.post(name: Self.STYLE_CHANGED, object: nil)
    }
    
}

extension MovieTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterMovies(text: searchText.lowercased())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
    }
    
}

extension MovieTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter.filteredMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie: Movie = self.presenter.filteredMovies[indexPath.row]
        
        let cell: MovieTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell

        // Configure the cell...
        cell.titleLabel.text = movie.title
        cell.releaseLabel.text = ConstantsAndUtilityFunctions.dateString(date: movie.releaseDate)
        cell.posterImageView.setImage(url: self.presenter.getPosterIconFullPath(identifier: movie.posterPath))

        return cell
    }
    
}

extension MovieTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !self.searchBar.isFirstResponder && indexPath.row >= self.presenter.movies.count - 1 {
            self.presenter.getPopularMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowDetail", sender: self.presenter.filteredMovies[indexPath.row])
    }
    
}

extension MovieTableViewController: MoviePresenterDelegate {
    
    func didGetPopularMovies(message: String?) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            if let message = message {
                let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: message, preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default))
                self.present(alertController, animated: true)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func didFilterMovies(text: String) {
        DispatchQueue.main.async {
            if text.isEmpty {
                self.view.endEditing(true)
            }
            self.tableView.reloadData()
        }
    }
    
}
