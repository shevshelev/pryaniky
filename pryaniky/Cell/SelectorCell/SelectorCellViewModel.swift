//
//  SelectorCellViewModel.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import Foundation

class SelectorCellViewModel: DataCellViewModelProtocol {
    
    var reuseId: String = "SelectorCell"
    var rowHeight: Double = 80
    
    let selectedId: Int
    let variants: [SelectorData.Variants]
    
    required init?(data: ResponseData) {
        guard let data = data.data as? SelectorData else { return nil }
        selectedId = data.selectedId
        variants = data.variants
    }
}
