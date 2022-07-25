//
//  ImageCell.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import UIKit

class ImageCell: UITableViewCell, DataCellProtocol {
    
    static let reuseId = "ImageCell"
    
    var viewModel: ImageCellViewModel! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.text
            guard let imageData = viewModel.imageData else { return }
            content.image = UIImage(data: imageData)
            contentConfiguration = content
        }
    }
}
