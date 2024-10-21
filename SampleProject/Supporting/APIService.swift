//
//  API.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class APIService {
    func fetchSponsors(completion: @escaping (Result<[SponsorCategory], NetworkError>) -> Void) {
        guard let url = URL(string: "https://admin.gpufestival.com/api/sponsors") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching sponsors: \(error)")
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(SponsorResponse.self, from: data)
                completion(.success(apiResponse.data))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchSeminars(completion: @escaping (Result<[Seminar], NetworkError>) -> Void) {
        guard let url = URL(string: "https://admin.gpufestival.com/api/seminars") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching seminars: \(error)")
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(SeminarResponse.self, from: data)
                completion(.success(apiResponse.data))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
