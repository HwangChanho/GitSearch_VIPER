//
//  SearchProtocols.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import UIKit

import RxSwift
import RxCocoa

protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get }
    
    func display() // Draw View
}

protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get }
    var interactor: SearchInteractorProtocol? { get }
    var router: SearchRouterProtocol? { get }
    
    var PresentorToInterectorSubject: PublishSubject<Void> { get }
    var searchData: [Repo] { get set }
    
    func numberOfSections() -> Int
    func viewDidLoad() // 뷰가 로드될 때, 주로 interactor에서 초기값 가져와서 뷰 업데이트
    func searchRepo(_ text: String) // repo를 검색
    
    func didClickOnRepoCell(from view: UIViewController?) // repo 탭시
}

protocol SearchInteractorProtocol {
    var presenter: SearchPresenterProtocol? { get }
    
    func fetchData(text: String) // 데이터 가져오기
    func updateData() // 데이터 업데이트
}

protocol SearchRouterProtocol {
  static func createModule() -> SearchView // VIPER통에 넣은 View return
  
  func pushDetailView(from view: UIViewController?) // 디테일뷰로 이동
}
