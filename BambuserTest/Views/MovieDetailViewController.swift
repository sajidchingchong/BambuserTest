//
//  MovieDetailViewController.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    var movie: Movie?
    var posterImageUrl: String?
    
    // TODO: Move to a subview class
    @IBOutlet weak var releasedOnLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.releasedOnLabel.text = NSLocalizedString("Released On:", comment: "Released On")
        self.userScoreLabel.text = NSLocalizedString("User Score:", comment: "User Score")
        self.overviewLabel.text = NSLocalizedString("Overview:", comment: "Overview")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = self.movie?.title
        self.overviewTextView.text = self.movie?.overview
        
        if let releaseDate = self.movie?.releaseDate {
            self.releaseLabel.text = ConstantsAndUtilityFunctions.dateString(date: releaseDate)
        }
        
        if let voteAverage = self.movie?.voteAverage {
            self.voteLabel.text = "\(Int(voteAverage * 10)) %"
        }
        
        self.posterImageView.setImage(url: self.posterImageUrl!)
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
