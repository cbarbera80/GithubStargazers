//
//  DetailsViewController.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DetailsViewControllerDelegate: class { }

class DetailsViewController: UIViewController {
    
    // MARK: - UI properties
    
    var aview: DetailsView? {
        return view as? DetailsView
    }
    
    // MARK: - Business properties
    weak var delegate: DetailsViewControllerDelegate?
    private let viewModel: DetailsViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Object lifecycle

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        view = DetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    private func bind() {
        guard let aView = aview else { return }
        
        viewModel.stargazersRelay
            .bind(to: aView.tableView.rx.items(cellIdentifier: UserTableViewCell.defaultReuseIdentifier, cellType: UserTableViewCell.self)) { _, userVM, cell in
                cell.configureCell(withViewModel: userVM)
            }
            .disposed(by: self.disposeBag)
        
        aView.tableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] _, indexPath in self?.manageInfiniteScrolling(currentIndexPath: indexPath) })
            .disposed(by: disposeBag)
        
        viewModel.statusRelay
            .asObservable()
            .subscribe { [weak self] status in self?.aview?.status = status }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configure methods
    private func manageInfiniteScrolling(currentIndexPath: IndexPath) {
        
        if currentIndexPath.row == viewModel.stargazersRelay.value.count - Constants.infiniteScrollingOffset {
            viewModel.makeRequest()
        }
    }
    
    private func configureUI() {
        aview?.tableView.register(UserTableViewCell.self)
        title = viewModel.titleText
    }

}
