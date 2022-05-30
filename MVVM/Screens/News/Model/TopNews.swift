//
//  TopNews.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import UIKit

struct TopNews: Codable {
        var status: String?
        var title: String?
        var author: String?
        var description: String?
        var url: String?
        var urlToImage: String?
    enum CodingKeys: String, CodingKey {
            case title = "title"
            case author = "author"
            case description = "description"
            case url = "url"
            case urlToImage = "urlToImage"
    }
     init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            author = try values.decodeIfPresent(String.self, forKey: .author)
            description = try values.decodeIfPresent(String.self, forKey: .description)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
    }
}
