//
//  SearchRouter.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import UIKit

final class SearchRouter { }

// 라우터 또는 와이어프레임이라 부른다.
extension SearchRouter: SearchRouterProtocol {
    static func createModule() -> SearchView {
        let view = SearchView()
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor)
        let router = SearchRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func pushDetailView(from view: UIViewController?) {
        guard let navigationController = view?.navigationController else {
            fatalError("Can't push without a navigation controller")
        }
        
        let viewController = DetailRouter.showDetailRouter()
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
