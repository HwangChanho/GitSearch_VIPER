//
//  SearchPresenter.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import UIKit

import RxCocoa
import RxSwift

// 뷰 처리관련 (viewModel)
final class SearchPresenter {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var searchData: [Repo] = []
    // Interactor가 참조하는 프로퍼티
    var PresentorToInterectorSubject = PublishSubject<Void>()
    
    
    let disposeBag = DisposeBag()
    
    init(interactor: SearchInteractorProtocol) {
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
        print("초기 셋팅 부")
    }
    
    func numberOfSections() -> Int {
        return searchData.count
    }
    
    func searchRepo(_ text: String) {
        interactor?.fetchData(text: text)
        loadDataFinished() // Rx로 바인딩 할때 사용 지금은 필요없음
    }
    
    func didClickOnRepoCell(from view: UIViewController?) {
        router?.pushDetailView(from: view)
    }
    
    func loadDataFinished() {
        PresentorToInterectorSubject.onNext(())
    }
    
    func loadDataFailed() {
        PresentorToInterectorSubject.onError(ToPresenterError.error)
    }
}
                          
