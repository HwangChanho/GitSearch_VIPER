//
//  Interactor.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/04.
//

import RxSwift
import RxCocoa

final class DetailInteractor {
    weak var presenter: DetailPresenterProtocol?
    
    var InterectorToPresenterSubject: PublishSubject<Void>?
    // Presenter가 참조하는 변수
    
    let disposeBag = DisposeBag()
}

extension DetailInteractor: DetailInteractorProtocol {
    
}
