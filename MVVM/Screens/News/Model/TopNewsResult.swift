//
//  TopNewsResult.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import Foundation

struct TopNewsResult : Codable {
    let status : String?
    let num_results : Int?
    let articles : [TopNews]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case num_results = "num_results"
        case articles = "articles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        articles = try values.decodeIfPresent([TopNews].self, forKey: .articles)
    }

}
