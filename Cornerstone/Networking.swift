//
//  Networking.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 22/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import Foundation


// MARK: - REST over HTTP

struct Networking {
    //let ServerURL = URL(string: "https://raboczi.id.au/test/value")!
    let serverURL = URL(string: "http://radiostar.local:8181/test/value")!
        
    func getTestValue() -> String {
        let task = URLSession.shared.dataTask(with: serverURL) { data, response, error in
            do {
                if let error = error {
                    throw error
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NSError(domain: "Application error domain", code: 5, userInfo: [NSLocalizedDescriptionKey: "Bad response"])
                }
                
                if let data = data {
                    print("Received \(String(data: data, encoding: .utf8) ?? "oops")")
                }
                
            } catch {
                DispatchQueue.main.async {
                    print("Error \(error)")
                }
            }
        }
        task.resume()
        
        return "Beep"
    }
    
    func setTestValue(to newValue: String) {
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setBasicAuthorization(username: "karaf", password: "karaf")
        
        let task = URLSession.shared.uploadTask(with: request, from: newValue.data(using: .utf8)) {
            data, response, error in
            do {
                if let error = error {
                    throw error
                }
                
                guard let response = response as? HTTPURLResponse else {
                    throw NSError(domain: "Application error domain", code: 5, userInfo: [NSLocalizedDescriptionKey: "Bad response"])
                }
                
                switch response.statusCode {
                case 204:  // No content
                    // Success!
                    break
                    
                case 401:  // Unauthorized
                    let scheme = response.allHeaderFields["Www-Authenticate"] as? String
                    switch scheme {
                    case "Basic":
                        throw NSError(domain: "Application error domain", code: 5, userInfo: [NSLocalizedDescriptionKey: "Retry using Basic authentication"])
                        
                    default:
                        throw NSError(domain: "Application error domain", code: 5, userInfo: [NSLocalizedDescriptionKey: "Server at \(self.serverURL) requires \(scheme ?? "unspecified") authentication method, which this app does not support"])
                    }
                    
                default:
                    throw NSError(domain: "Application error domain", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)])
                }
            } catch {
                DispatchQueue.main.async {
                    //NSApplication.shared.presentError(error)
                    print("Error \(error)")
                }
            }
        }
        task.resume()
    }
}

extension URLRequest {
    mutating func setBasicAuthorization(username: String, password: String) {
        guard let authorization = "\(username):\(password)"
            .data(using: .utf8)?
            .base64EncodedString() else { fatalError() }
        setValue("Basic \(authorization)", forHTTPHeaderField: "Authorization")
    }
}
