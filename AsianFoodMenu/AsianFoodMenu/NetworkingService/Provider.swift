//
//  Provider.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 21.09.2023.
//

import UIKit

class Provider {

    // MARK: - Request
    
    func request(withRoute route: ApiRoute, formBody: [String: String]? = nil) async throws -> Data {
        guard let url = route.urlComponents?.url else {
            throw RequestProcessorError.wrongUrl(route.urlComponents?.url)
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: formBody, boundary: boundary)
        request.httpBody = dataBody
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func fetchFoodImage(at stringUrl: String) async throws -> UIImage {
        guard let baseStringUrl = Config.baseStringUrl else {
            throw RequestProcessorError.invalidBaseStringURL }
        
        let imageStringUrl = baseStringUrl + stringUrl
        
        guard let imageUrl = URL(string: imageStringUrl) else {
            throw RequestProcessorError.wrongUrl(URL(string: imageStringUrl))
        }
        
        let (data, _) = try await URLSession.shared.data(from: imageUrl)
        
        guard let image = UIImage(data: data) else {
            throw RequestProcessorError.failedToDecodeJSON
        }
        return image
    }
  
    // MARK: - Decode
    
    func decode<Type: Decodable>(_ file: Type, data: Data) throws -> Type {
       let decoder = JSONDecoder()
       guard let userData = try? decoder.decode(Type.self, from: data) else {
           throw RequestProcessorError.failedToDecodeJSON
       }
       return userData
   }

    // MARK: - Private Methods

    private func generateBoundary() -> String {
        "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters params: [String: String]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

// MARK: - RequestProcessorError

enum RequestProcessorError: Error {
    case invalidBaseStringURL
    case wrongUrl(URL?) // todo
    case failedToDecodeJSON
}

// MARK: - Extension Data

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
