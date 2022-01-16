//
//  MoviewDetailHedingCell.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class MovieDetailHedingCell: UITableViewCell {

    @IBOutlet weak var movieCoverImgView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var releaseYearLbl: UILabel!
    @IBOutlet weak var imgContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCellData(movieData: MoviewDetailModel) {
        let imgUrl = movieData.Poster ?? ""
    
        if let url = URL(string: imgUrl){
            movieCoverImgView.loadUrl(url: url)
        }
        
        imgContainerView.layer.shadowRadius = imgContainerView.bounds.width/2
        imgContainerView.layer.shadowColor = UIColor.gray.cgColor
        imgContainerView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        imgContainerView.layer.shadowOpacity = 0.7
        imgContainerView.layer.cornerRadius = imgContainerView.bounds.width/2
        imgContainerView.clipsToBounds = false
        
        movieTitleLbl.text = movieData.Title ?? ""
        releaseYearLbl.text = movieData.Released ?? ""
        
    }

}
