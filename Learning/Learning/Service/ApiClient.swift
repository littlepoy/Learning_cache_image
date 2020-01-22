//
//  ApiClient.swift
//  Learning
//
//  Created by LivingMobile on 13/1/2563 BE.
//  Copyright © 2563 LivingMobile. All rights reserved.
//

import Alamofire

class ApiClient {
    
    let baseUrl = "https://jsonplaceholder.typicode.com/photos"
    
    func requestDataList(completion: @escaping ([DataModel]?, Error?)->()) {
        Alamofire.request(self.baseUrl, method: .get)
            .validate(statusCode: 200..<299)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    self.parseJSON(data: response.data, completion: completion)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    func parseJSON<T> (data : Data?, completion: @escaping ([T]?, Error?)->()) where T : Codable {
        var decodeData: [T]?
        var error: Error?
        guard let data = data else {
            return
        }
        
        defer {
            completion(decodeData, error)
        }
        
        do {
            decodeData = try JSONDecoder().decode(Array<T>.self, from: data)
        } catch let err {
            error = err
            debugPrint(err)
        }
    }
}
