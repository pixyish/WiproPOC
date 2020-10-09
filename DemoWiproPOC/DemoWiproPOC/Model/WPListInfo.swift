//
//  WPListInfo.swift
//  DemoWiproPOC
//
//  Created by Piyush on 08/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import Foundation
struct ListInfo : Codable {
    let title : String?
    let rows : [Rows]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }
}

struct Rows : Codable {
    let title : String?
    let description : String?
    let imageHref : String?
    init(with ttl:String,description:String,imgHref:String) {
        title = ttl
        self.description = description
        imageHref = imgHref
    }
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }

}
