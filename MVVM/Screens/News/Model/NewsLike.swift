//
//  NewsLike.swift
//  MVVM
//
//  Created by suganthi on 29/05/22.
//

import Foundation

struct NewsLike : Codable {
    
    let likes : Int?
    

    enum CodingKeys: String, CodingKey {

        case likes = "likes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
    }

}
