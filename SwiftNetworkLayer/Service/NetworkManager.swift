//
//  NetworkManager.swift
//  SwiftNetworkLayer
//
//  Created by macbook pro on 15.11.2023.
//

import Foundation

// https://jsonplaceholder.typicode.com/users
// ----------------BASEURL-------------
//                                      ------  ENDPOINT(PATH)


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    private func request<T: Decodable>(_ endpoint: EndPoint , completion: @escaping (Result<T,Error>) -> () ) {
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "invalid response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "data not found", code: 1)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                // generic olarak decodable T değerini döndüğümüz için bu fonksiyonu sadece user için değil gelecek herhangi bir değer için kullanabiliriz
            }catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getUser(completion : @escaping (Result<[User],Error>) -> ()) {
        let endpoint = EndPoint.getUsers
        request(endpoint, completion: completion)
    }
}
