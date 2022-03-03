//
//  Presenter.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/04.
//

import UIKit

import RxCocoa
import RxSwift

// 뷰 처리관련 (viewModel)
final class DetailPresenter {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    // Interactor가 참조하는 프로퍼티
    var PresentorToInterectorSubject = PublishSubject<Void>()
    
    
    let disposeBag = DisposeBag()
    
    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        print("초기 셋팅 부")
    }
    
    func backToSearchView(from view: UIViewController?) {
        router?.backToSearchView(from: view)
    }
}
