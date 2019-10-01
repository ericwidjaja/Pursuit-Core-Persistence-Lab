//
//  PixabayAPIHelper.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 9/30/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation

class PixabayApiHelper {
    private init() {}
    static let manager = PixabayApiHelper()
    
    func getPixabayWrapper(str: String,completionHandler: @escaping (Result<PixabayWrapper,AppError>) -> ()) {
        let key = SecretAPIKey.apiKey
        guard let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(str)") else {completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let wrapper = try JSONDecoder().decode(PixabayWrapper.self, from: data)
                    completionHandler(.success(wrapper))
                } catch { completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
