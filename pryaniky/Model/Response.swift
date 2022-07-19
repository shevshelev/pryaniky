//
//  Response.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 18.07.2022.
//

import Foundation

struct Response: Decodable {
    let data: [ResponseData]
    let view: [ResponseData.DataType]
}

class ResponseData: Decodable {
    let type: DataType
    let data: Any
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        type = DataType(rawValue: name) ?? .label
        switch type {
        case .label, .picture:
            data = try container.decode([String: String].self, forKey: .data)
        case .selector:
            data = try container.decode(SelectorData.self, forKey: .data)
        }
    }
    
    private enum CodingKeys: CodingKey {
        case name
        case data
    }
    
    enum DataType: String, Decodable {
        case label = "hz"
        case picture
        case selector
    }
}

struct SelectorData: Decodable {
    let selectedId: Int
    let variants: [Variants]
    
    struct Variants: Decodable {
        let id: Int
        let text: String
    }
}
