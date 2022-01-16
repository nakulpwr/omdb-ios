//
//  ViewController.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var movieGridCollectionView: UICollectionView!
    @IBOutlet weak var apiIndicator: UIActivityIndicatorView!
    
    private var pageNumber: Int = 1
    
    private var searchedStr: String = ""
    
    private var searchBar: UISearchBar!
    
    private var movieList = [MovieModel]()
    
    private var searchItem: UIBarButtonItem!
    
    private var reachedLast = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
    
        
        navigationItem.title = "Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearchButtonTap))
        searchItem.tintColor = .blue
        
        
        movieGridCollectionView.dataSource = self
        movieGridCollectionView.delegate = self
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        movieGridCollectionView.setCollectionViewLayout(layout, animated: true)
        
        showSearchBarButton(shouldShow: true)
        
        onSearchButtonTap()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        movieGridCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    private func fetchMoviData(pageNumber: Int, searchStr: String) {
        apiIndicator.startAnimating()
        APIService.shared.fetchMoviList(pageNumber: pageNumber, searchStr: searchStr, completion: { [weak self] (error,response) in
            
            guard let self = self, let res = response else { return }
            
            
            do {
                if let jsonKeyVal = try JSONSerialization.jsonObject(with: res.data(using: .utf8)!, options: []) as? [String: Any] {
                    
                    
                    if let response = jsonKeyVal["Response"] as? Bool, !response {
                        print(jsonKeyVal)
                        self.hideApiIndicator()
                        return
                    }
                    
                    if let tempArray = jsonKeyVal["Search"]  as? [[String:Any]] {
                        
                        let jsonData = try JSONSerialization.data(withJSONObject: tempArray)
                        
                        let list = try JSONDecoder().decode([MovieModel].self, from: jsonData)
                        
                        self.reachedLast = list.isEmpty || list.count < 10
                        
                        let sizeBeforeUpdate = self.movieList.count
                        
                        if self.pageNumber > 1 {
                            self.movieList += list
                        } else {
                            self.movieList = list
                        }
                        
                        
                        
                        DispatchQueue.main.async {
                            
                            if !self.reachedLast {
                                self.pageNumber += 1
                            }
                            
                            var indexPaths = [IndexPath]()
                            for i in sizeBeforeUpdate..<self.movieList.count {
                                indexPaths.append(IndexPath(item: i, section: 0))
                            }
                            self.movieGridCollectionView.insertItems(at: indexPaths)
                        }
                    }
                    self.hideApiIndicator()
                }
                
            } catch let error{
                print(error)
                self.hideApiIndicator()
            }
        })
        
    }
    
    
    private func fetchMoviDetail(movieId: String) {
        apiIndicator.startAnimating()
        APIService.shared.fetchMovieDetail(movieId: movieId, completion: {[weak self] (error,response) in
            
            guard let self = self, let res = response else { return }
            
            
            do {
                if let jsonKeyVal = try JSONSerialization.jsonObject(with: res, options: []) as? [String: Any] {
                    
                    
                    if let response = jsonKeyVal["Response"] as? Bool, !response {
                        print(jsonKeyVal)
                        self.hideApiIndicator()
                        return
                    }
                    
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonKeyVal)
                    
                    let details = try JSONDecoder().decode(MoviewDetailModel.self, from: jsonData)
                    
                    
                    DispatchQueue.main.async {
                        let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
                        detailsVC.movieDetail = details
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    }
                    
                    self.hideApiIndicator()
                }
                
            } catch let error{
                print(error)
            }
        })
        
    }
    
    
    @objc func onSearchButtonTap() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = searchItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    private func hideApiIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.apiIndicator.stopAnimating()
        }
    }
    
    
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviGridCell
        let cellModel = movieList[indexPath.item]
        cell.setupCellData(movieData: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2 - 10
        
        return CGSize(width:widthPerItem, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchMoviDetail(movieId: movieList[indexPath.item].imdbID ?? "")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == movieList.count - 1 {
            if !apiIndicator.isAnimating && !reachedLast{
                fetchMoviData(pageNumber: pageNumber, searchStr: searchedStr)
            }
        }
    }
    
}




extension ViewController: UISearchBarDelegate {
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pageNumber = 1
        reachedLast = false
        searchedStr = searchBar.searchTextField.text ?? ""
       
        search(shouldShow: false)
        fetchMoviData(pageNumber: pageNumber, searchStr: searchedStr)
    }
}


