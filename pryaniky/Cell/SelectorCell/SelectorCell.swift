//
//  SelectorCell.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import UIKit

protocol AlertShow: AnyObject {
    func showAlert(sender: UISegmentedControl)
}

class SelectorCell: UITableViewCell, DataCellProtocol {
    
    static let reuseId = "SelectorCell"
    
    private lazy var segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    weak var delegate: AlertShow?
    
    var viewModel: SelectorCellViewModel! {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        addSubview(segmentedControl)
        setupConstraints()
        viewModel.variants.forEach {
            segmentedControl.insertSegment(withTitle: $0.text, at: $0.id, animated: false)
        }
        segmentedControl.selectedSegmentIndex = viewModel.selectedId - 1
        segmentedControl.addTarget(self, action: #selector(changeSegment(sender: )), for: .valueChanged)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func changeSegment(sender: UISegmentedControl) {
        delegate?.showAlert(sender: sender)
    }
}
