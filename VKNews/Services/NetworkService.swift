//
//  NetworkService.swift
//  VKNews
//
//  Created by Антон Усов on 26.10.2021.
//

import Foundation


protocol Networking {
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
       
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.sceme
        components.path = API.newsFeed
        components.host = API.host
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
