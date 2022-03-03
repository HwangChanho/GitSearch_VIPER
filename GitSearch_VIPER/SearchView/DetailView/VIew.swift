//
//  SearchView.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import UIKit

import SnapKit
import RxSwift

// UI요소와 뷰의 컨트롤러
final class DetailView: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func back(_ sender: UIButton) {
        presenter?.backToSearchView(from: self)
    }
}

extension DetailView: DetailViewProtocol {
    private func setupView() {
    }
    
    func display() {
        setupView()
    }
}

