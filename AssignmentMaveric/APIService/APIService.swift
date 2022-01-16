//
//  APIService.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import Foundation


class APIService {
    private let backgroundQue: DispatchQueue!
    private init() {
        backgroundQue = DispatchQueue.global()
    }
    public static let shared = APIService()
    
    func fetchMoviList(pageNumber: Int, searchStr: String, completion: @escaping (Error?, String?) -> (Void)) {
        
        backgroundQue.async {
            guard let url = URL(string: "https://www.omdbapi.com/?apikey=b9bd48a6&s=\(searchStr)&type=movie&page=\(pageNumber)") else { return }
            
            var request = URLRequest(url: url)
            
            
            
            request.httpMethod = "GET"
            
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                if let error = error {
                    completion(error,nil)
                } else {
                    let json = String(data: data ?? Data(), encoding: .utf8)
                    completion(nil,json)
                }
            })
            
            task.resume()
        }
        
        
    }
    
    
    func fetchMovieDetail(movieId: String, completion: @escaping (Error?,Data?) -> (Void)) {
        backgroundQue.async {
            guard let url = URL(string: "https://www.omdbapi.com/?apikey=b9bd48a6&i=\(movieId)") else { return }
            
            var request = URLRequest(url: url)
            
            
            
            request.httpMethod = "GET"
            
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                if let error = error {
                    completion(error,nil)
                } else {
                    completion(nil,data)
                }
            })
            
            task.resume()
        }
        
    }
    
}
