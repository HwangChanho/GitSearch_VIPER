//
//  SearchInteractor.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import RxSwift
import RxCocoa

public enum ToPresenterError: Error {
    case error
}

final class SearchInteractor {
    weak var presenter: SearchPresenterProtocol?
    
    var InterectorToPresenterSubject: PublishSubject<Void>?
    // Presenter가 참조하는 변수
    
    let disposeBag = DisposeBag()
}

extension SearchInteractor: SearchInteractorProtocol {
    func fetchData(text: String) {
        GithubService()
            .searchRepos(with: text)
            .compactMap { $0 }
            .subscribe(onNext: { [self] repos in
                presenter?.searchData = repos
            }, onError: { [self] _ in
                InterectorToPresenterSubject?.onError(ToPresenterError.error)
            }).disposed(by: self.disposeBag)
    }
    
    func updateData() {
        
    }
}
