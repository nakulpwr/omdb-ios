//
//  MovieDecriptionCell.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class MovieDescriptionCell: UITableViewCell {

   
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var timeDurationLbl: UILabel!
    @IBOutlet weak var ratingStarLbl: UILabel!
    @IBOutlet weak var movieDescriptionLbl: UILabel!

    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellData(movieData: MoviewDetailModel) {
        
        categoriesLbl.text = movieData.Genre
        timeDurationLbl.text = movieData.Runtime
        ratingStarLbl.text = movieData.Ratings?[0].Value ?? "0.0"
        movieDescriptionLbl.text = movieData.Plot
        
        scoreLbl.text = movieData.Metascore
        reviewLbl.text = movieData.imdbRating
        popularityLbl.text = movieData.imdbVotes
        
    }

}
