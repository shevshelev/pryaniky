//
//  TableViewController.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 18.07.2022.
//

import UIKit
import RxCocoa
import RxSwift

class DataListViewController: UITableViewController {
    
    private let bag = DisposeBag()
    private var viewModel: DataListViewModelProtocol! {
        didSet {
            viewModel.fetchData { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DataListViewModel()
        tableView.registerCells([LabelCell(), ImageCell(), SelectorCell()])
        tableViewBinding()
            
    }
    
    // MARK: - Private Functions
    
    private func tableViewBinding() {
        tableView.rx.itemSelected.asControlEvent()
            .bind (onNext: { indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)
                let view = self.viewModel.views[indexPath.row]
                self.showAlertController(for: indexPath.row, and: view, or: nil)
            }).disposed(by: bag)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = viewModel.views[indexPath.row]
        switch view {
        case .label:
            guard let viewModel = viewModel.cellViewModel(dataType: .label) as? LabelCellViewModel else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseId, for: indexPath) as? LabelCell else  { return UITableViewCell() }
            cell.viewModel = viewModel
            return cell
        case .picture:
            guard let viewModel = self.viewModel.cellViewModel(dataType: .picture) as? ImageCellViewModel else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseId, for: indexPath) as? ImageCell else { return UITableViewCell() }
            cell.viewModel = viewModel
            return cell
        case .selector:
            guard let viewModel = self.viewModel.cellViewModel(dataType: .selector) as? SelectorCellViewModel else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseId, for: indexPath) as? SelectorCell else { return UITableViewCell() }
            cell.delegate = self
            cell.viewModel = viewModel
            return cell
        }
    }
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let view = viewModel.views[indexPath.row]
        switch view {
        case .label:
            let viewModel = viewModel.cellViewModel(dataType: .label) as? LabelCellViewModel
            return CGFloat(viewModel?.rowHeight ?? 0)
        case .picture:
            let viewModel = self.viewModel.cellViewModel(dataType: .picture) as? ImageCellViewModel
            return CGFloat(viewModel?.rowHeight ?? 0)
        case .selector:
            let viewModel = self.viewModel.cellViewModel(dataType: .selector) as? SelectorCellViewModel
            return CGFloat(viewModel?.rowHeight ?? 0)
        }
    }
}

extension DataListViewController: AlertShow {
    func showAlert(sender: UISegmentedControl) {
        showAlertController(for: nil, and: nil, or: sender)
    }
}

extension DataListViewController {
    private func showAlertController(for row: Int?, and view: ResponseData.DataType?, or segmentControl: UISegmentedControl?) {
        let title = row != nil
        ? "Выбрана ячейка № \(row ?? 0)"
        : "Выбран сегмент id \((segmentControl?.selectedSegmentIndex ?? 0) + 1)"
        let message = view != nil
        ? "Объект: \(view?.rawValue ?? "")"
        : "\(segmentControl?.titleForSegment(at: segmentControl?.selectedSegmentIndex ?? 0) ?? "")"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
