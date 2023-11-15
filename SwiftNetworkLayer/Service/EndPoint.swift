//
//  EndPoint.swift
//  SwiftNetworkLayer
//
//  Created by macbook pro on 15.11.2023.
//

import Foundation

enum HTTPMethod: String {  // işlem yapacakken kullandığımız HTTP methodlarını bir enum içine koyduk
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}
enum EndPoint {  // kullanabileceğimiz endpointleri enum içine koyduk
    case getUsers
    case getComment
    case posts
}


protocol EndPointProtocol {
    // bu urlde neler var onları söyleyecek bir protokol yazalım
    
    var baseURL : String {get} // okuyabikememiz için get olarak tanımladık
    var path : String {get}
    var method : HTTPMethod {get}
    var header : [String:String]? {get}  // istek atıp baiarılı olunca gelecek datayı(headerı) da ekledik
    
    func request() -> URLRequest // bir fonksiyonum olsun bana urlrequest döndürsün
}

extension EndPoint : EndPointProtocol {
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self { // endpoint caselerini tek tek ele al demek
        case .getUsers:
            return "/users"
        case .posts:
            return "/posts"
            
        case .getComment:
            return "/comments"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .getUsers:
            return .get
        case .posts:
            return .get
        case .getComment:
            return .get
        }
    }
    
    var header: [String : String]? {
        //  var header : [String:Any] = ["Authorization" : "Bearer \(token)"]
        return nil
    }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseURL) else {
            fatalError("url error")
            
        }
        component.path = path
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue // rawvalue dediğimiz methodlardan birisini aldığımız (get) anlamına geliyor
        
        if let header = header {
            for (key,value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
        
        
    }
    
}


