//
//  CountryFacts.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

struct CountryFacts: Decodable {
    let title: String?
    let factList: [Fact]?
    var factsFiltered: [Fact]? {
        get {
            let list = factList?.filter({$0.title != nil || $0.description != nil})
            return list
        }
    }
    
    private enum Keys: String, CodingKey {
        case title
        case factList = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        factList = try values.decodeIfPresent([Fact].self, forKey: .factList)
    }
}
