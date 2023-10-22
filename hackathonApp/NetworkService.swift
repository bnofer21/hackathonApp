//
//  NetworkService.swift
//  hackathonApp
//
//  Created by Юрий on 22.10.2023.
//

import Foundation

final class NetworkService {
    
    let endpoint = "http://localhost:8000/report_error/"
    
    func reportError(error: ErrorEntry, completion: @escaping(String?) -> Void) {
        guard let url = URL(string: endpoint) else { return }
        let data = try! JSONEncoder().encode(error)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "POST"
        request.httpBody = data
        
        print(data)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(nil)
                } else {
                    completion("status code \(response.statusCode)")
                }
            }
            if let data = data {
                completion(nil)
                print(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
}
