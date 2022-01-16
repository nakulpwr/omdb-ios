//
//  MovieDetailModel.swift
//  AssignmentMaveric
//
//  Created by Nakul on 15/01/22.
//

import Foundation
struct MoviewDetailModel: Codable {
    
    let Title, Year, Rated, Released, Runtime, Genre, Director, Writer, Actors, Plot, Language, Country, Awards, Poster, Metascore, imdbRating,
        imdbVotes, imdbID, type, DVD, BoxOffice, Production, Website, Response: String?
    
    let Ratings: [Rating]?

    struct Rating: Codable {
        let Source, Value: String?
    }
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, Rated, Released, Runtime, Genre, Director, Writer, Actors, Plot, Language, Country, Awards, Poster, Metascore, imdbRating,
             imdbVotes, imdbID, DVD, BoxOffice, Production, Website, Response, Ratings
        
        case type = "Type"
    }
    
}

