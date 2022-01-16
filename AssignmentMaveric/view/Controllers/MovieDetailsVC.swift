//
//  MovieDetailsVC.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var detailsTblView: UITableView!
    
    var moviewDetails: MoviewDetailModel?
    
    var movieDetail: MoviewDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTblView.dataSource = self
        detailsTblView.delegate = self
        
        detailsTblView.tableHeaderView = UIView()
        detailsTblView.tableFooterView = UIView()
        
        title = "Details"
        
    }
    

    

}

extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieData = movieDetail else { return UITableViewCell() }
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailHedingCell", for: indexPath) as! MovieDetailHedingCell
            cell.setupCellData(movieData: movieData)
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
            cell.setupCellData(movieData: movieData)
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastCrewCell", for: indexPath) as! MovieCastCrewCell
            cell.setupCellData(movieData: movieData)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
}
