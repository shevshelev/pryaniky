//
//  LabelCellViewModel.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import Foundation

protocol DataCellViewModelProtocol {
    var reuseId: String { get }
    var rowHeight: Double { get }
    init? (data: ResponseData)
}

class LabelCellViewModel: DataCellViewModelProtocol {
    
    let reuseId: String = "LabelCell"
    let rowHeight: Double = 50
    let text: String?
    
    required init?(data: ResponseData) {
        guard let data = data.data as? [String: String] else { return nil }
        text = data["text"]
    }
    
    
}
