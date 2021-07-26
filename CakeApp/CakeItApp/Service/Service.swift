//  Created by Roy DeVatt on 06/25/21.

import Foundation

protocol Servicable:JsonDecodable {
    func fetchData<T:Codable>(networkClient:NetworkClient, type:T.Type, completionHandler:@escaping Completion<T>)
}

typealias Completion<T:Decodable> =  ((Result<[T], NetworkError>) -> Void)


/*Created Class to inject as dependency in veiwModel and use MockService for Unit testing*/
class Service: Servicable {
  
    let urlSesson = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?
    func fetchData<T:Codable>(networkClient:NetworkClient, type:T.Type, completionHandler:@escaping Completion<T>) {
        dataTask?.cancel()
        guard var urlComponents = URLComponents(string:networkClient.baseUrl + networkClient.path) else {
            completionHandler(.failure(.malformedURL(message:Constants.urlNotCorrect)))
            return
        }
        urlComponents.query = "\(networkClient.params)"
        guard let url = urlComponents.url else {
            completionHandler(.failure(.malformedURL(message:Constants.urlNotCorrect)))
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = networkClient.method
                
        dataTask =  urlSesson.dataTask(with:urlRequest) { [weak self] (data, responce, error)  in
            guard  let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                completionHandler(.failure(.errorWith(message: Constants.noResponse)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.errorWith(message: Constants.noData)))
                return
            }
            // Parsing data using JsonDecoder
            if let result = self?.decode(input:data, type:type) {
                completionHandler(.success(result))
            }else {
                completionHandler(.failure(.parsinFailed(message:Constants.parsingFailed)))
            }
        }
        dataTask?.resume()
    }
}
