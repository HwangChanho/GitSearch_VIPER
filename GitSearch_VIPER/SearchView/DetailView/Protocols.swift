//
//  Protocols.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/04.
//

import UIKit

import RxSwift
import RxCocoa

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get }
    
    func display() // Draw View
}

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get }
    var interactor: DetailInteractorProtocol? { get }
    var router: DetailRouterProtocol? { get }
    
    var PresentorToInterectorSubject: PublishSubject<Void> { get }
    
    func backToSearchView(from view: UIViewController?)
    func viewDidLoad() // 뷰가 로드될 때, 주로 interactor에서 초기값 가져와서 뷰 업데이트
}

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get }
    
}

protocol DetailRouterProtocol {
    static func showDetailRouter() -> DetailView // VIPER통에 넣은 View return
    
    func backToSearchView(from view: UIViewController?)
}
