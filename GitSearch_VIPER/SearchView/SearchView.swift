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
final class SearchView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.barStyle = .default
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 74
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        return tableView
    }()
    
    var presenter: SearchPresenterProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display()
        presenter?.viewDidLoad()
        bindPresenter()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchView: SearchViewProtocol {
    private func setupView() {
        setSearchBar()
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "search..."
        self.navigationItem.titleView = searchBar
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        
        bindSearchBar()
    }
    
    private func bindPresenter() {
        presenter?.PresentorToInterectorSubject
            .subscribe(onNext: { [weak self] in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        // 텍스트 변경시
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [self] text in
                presenter?.searchRepo(text)
            })
            .disposed(by: disposeBag)
        
        // search 버튼 눌렸을 경우
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [self] data in
                presenter?.searchRepo(searchBar.text!)
            })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        print(presenter?.searchData[indexPath.row])
        
        cell.textLabel?.text = presenter?.searchData[indexPath.row].fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didClickOnRepoCell(from: self)
    }
    
    func display() {
        setupView()
    }
}
