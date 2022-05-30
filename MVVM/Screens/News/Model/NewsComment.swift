//
//  NewsComment.swift
//  MVVM
//
//  Created by suganthi on 29/05/22.
//

import Foundation

struct NewsComment : Codable {
    
    let comments : Int?
    

    enum CodingKeys: String, CodingKey {

        case comments = "comments"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
    }

}
