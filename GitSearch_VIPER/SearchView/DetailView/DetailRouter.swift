//
//  Detail.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/04.
//

import UIKit

final class DetailRouter { }

extension DetailRouter: DetailRouterProtocol {
    static func showDetailRouter() -> DetailView {
        let view = DetailView()
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(interactor: interactor)
        let router = DetailRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
    
    func backToSearchView(from view: UIViewController?) {
        guard let navigationController = view?.navigationController else {
            fatalError("Can't push without a navigation controller")
        }
        
        navigationController.popViewController(animated: true)
    }
}
