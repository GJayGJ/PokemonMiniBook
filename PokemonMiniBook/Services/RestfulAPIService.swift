//
//  RestfulAPIService.swift
//  PokemonMiniBook
//
//  Created by 黃冠傑 on 2024/7/21.
//

import Foundation

class RestfulAPIService {
    static let shared = RestfulAPIService()

    private init() {}

    func httpGetFetchData<T: Decodable>(url: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func httpGetFetchData<T: Decodable>(url: String, responseType: T.Type) async -> T? {
        guard let url = URL(string: url) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("\(error)")
            return nil
        }
    }
}
