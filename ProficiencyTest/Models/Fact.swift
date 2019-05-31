//
//  Fact.swift
//  ProficiencyTest
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
    
    func isTitleNullOrEmpty() -> Bool {
        guard let title = title, !title.isEmpty else {
            return true
        }
        return false
    }
}
