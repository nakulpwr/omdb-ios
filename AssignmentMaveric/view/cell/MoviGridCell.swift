//
//  MoviGridCell.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class MoviGridCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0.3)
        clipsToBounds = false
        
        containerView.layer.cornerRadius = 8
        
    }
    
    
    func setupCellData(movieData: MovieModel) {
        
        coverImageView.loadUrl(url: URL(string: movieData.Poster ?? "") ?? URL(string: "")!)
        titleLabel.text = movieData.Title ?? ""
        titleLabel.textColor = .black
        
    }
}



extension UIImageView {
    
    func loadUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
