//
//  HomeViewController.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GithubStargazersModels

protocol HomeViewControllerDelegate: class {
    func showResults(_ results: [GithubUser], user: String, repo: String)
}

class HomeViewController: UIViewController {
    
    // MARK: - UI properties
    var aview: HomeView? {
        return view as? HomeView
    }
    
    // MARK: - Business properties
    weak var delegate: HomeViewControllerDelegate?
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Object lifecycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    // MARK: - Configure methods
    private func configureUI() {
        title = L10n.Home.title
    }
    
    private func bind() {
        guard let aView = aview else { return }
        
        aView.userTextField.rx.text
            .bind(to: viewModel.userRelay)
            .disposed(by: disposeBag)
        
        aView.repoTextField.rx.text
            .bind(to: viewModel.repoRelay)
            .disposed(by: disposeBag)
        
        viewModel.confirmButtonEnabled
            .bind(to: aView.searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        aView.searchButton.rx.tap
            .asObservable()
            .subscribe { [weak self] _ in self?.search() }
            .disposed(by: disposeBag)
        
        aView.showDataButton.rx.tap
            .asObservable()
            .subscribe { [weak self] _ in self?.showData() }
            .disposed(by: disposeBag)
        
        viewModel.statusRelay
            .asObservable()
            .subscribe { [weak self] status in self?.aview?.status = status }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Private methods
    
    private func search() {
        viewModel.makeRequest()
        view.endEditing(true)
    }
    
    private func showData() {
        guard let data = viewModel.stargazersRelay.value, let user = viewModel.userRelay.value, let repo = viewModel.repoRelay.value else { return }
        delegate?.showResults(data, user: user, repo: repo)
    }
}
