//
//  Repo.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/03.
//

import Foundation

import ObjectMapper

struct Repo {
    var fullName = ""
    var description = ""
    var htmlUrl = ""
}

extension Repo: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        self.fullName <- map["full_name"]
        self.description <- map["description"]
        self.htmlUrl <- map["html_url"]
    }
}
