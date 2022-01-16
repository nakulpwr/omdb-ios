//
//  MovieModel.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import Foundation

struct MovieModel: Codable {
    let Title, Year, imdbID, type, Poster: String?
    
    enum CodingKeys: String, CodingKey {
        
        case Title, Year, imdbID, Poster
        
        case type = "Type"
    }
}

