//
//  LabelCell.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import UIKit

protocol DataCellProtocol {
    static var reuseId: String { get }
}

class LabelCell: UITableViewCell, DataCellProtocol {

    static let reuseId = "LabelCell"
    
    var viewModel: LabelCellViewModel! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.text
            contentConfiguration = content
        }
    }
    
}
