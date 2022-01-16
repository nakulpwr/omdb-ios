//
//  MovieCastCrewCell.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class MovieCastCrewCell: UITableViewCell {

    
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var writerLbl: UILabel!
    @IBOutlet weak var actorsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCellData(movieData: MoviewDetailModel) {
        
        directorLbl.text = movieData.Director
        writerLbl.text = movieData.Writer
        actorsLbl.text = movieData.Actors
        
    }

}
