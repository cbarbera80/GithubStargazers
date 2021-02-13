//
//  DetailsView.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import Anchorage

enum DetailsViewStatus {
    case idle
    case loading
}

class DetailsView: UIView {
    
    // MARK: - Properties
    var status: DetailsViewStatus {
        didSet {
            refreshStatus()
        }
    }
    
    // MARK: - UI properties
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view
    }()
    
    var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.backgroundColor.color
        return view
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    // MARK: - Object lifecycle
        
    init() {
        status = .idle
        super.init(frame: .zero)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }

    // MARK: - Configure methods
    private func refreshStatus() {
        switch status {
        case .idle:
            loadingView.isHidden = true
            activityIndicatorView.stopAnimating()
        case .loading:
            loadingView.isHidden = false
            activityIndicatorView.startAnimating()
        }
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        // tableView
        addSubview(tableView)
        
        // activity
        loadingView.addSubview(activityIndicatorView)
        
        // loadingView
        addSubview(loadingView)
    }
    
    private func configureConstraints() {
        // tableView
        tableView.edgeAnchors == edgeAnchors
        
        loadingView.leadingAnchor == leadingAnchor
        loadingView.trailingAnchor == trailingAnchor
        loadingView.bottomAnchor == bottomAnchor
        loadingView.heightAnchor == 50
        
        activityIndicatorView.centerAnchors == loadingView.centerAnchors
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct DetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            DetailsView()
                .makePreview()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
            
            DetailsView()
                .makePreview()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
#endif
