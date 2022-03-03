//
//  GithubService.swift
//  GitSearch_VIPER
//
//  Created by AlexHwang on 2022/03/02.
//

import RxSwift
import Alamofire
import SwiftyJSON
import ObjectMapper

final class GithubService {
    private let baseURL = "https://api.github.com"
    
    func searchRepos(with keyword: String, page: Int = 1) -> Observable<[Repo]?> {
        let url = baseURL + "/search/repositories"
        
        let params: Parameters = [
            "q": keyword,
            "page": page
        ]
        
        let headers: HTTPHeaders = ["accept": "application/vnd.github.v3+json"]
        
        return .create() { subscriber in
            guard
                let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                return Disposables.create()
            }
            
            AF.request(encodedURL, method: .get, parameters: params, headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)
                        let items = json["items"].arrayObject
                        let repos = Mapper<Repo>().mapArray(JSONObject: items)
                        
                        subscriber.onNext(repos)
                        
                    case .failure(let error):
                        subscriber.onError(error)
                    }
                }
            
            return Disposables.create()
        }
    }
}
