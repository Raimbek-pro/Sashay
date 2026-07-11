//
//  ReferentsService.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import Foundation

class ReferentsService {
     var base = URLComponents(string: "https://api.genius.com/referents")
    
    func getReferents( text : Int,  page: Int) async -> Result<ReferentsResponse , SongsServiceError> {
        base?.queryItems = [
            URLQueryItem(name: "song_id", value: "\(text)"),
            URLQueryItem(name: "text_format", value: "plain")
        ]
        var req = URLRequest(url: base!.url!)
        req.setValue("Bearer \(KeychainService.shared.getToken()!)", forHTTPHeaderField: "Authorization")
        do {
            let (data , response) = try await URLSession.shared.data(for: req)
            
            let text = String(data: data, encoding: .utf8)

            print(text ?? "Couldn't decode response as UTF-8")
            
           var songs =  try JSONDecoder().decode(ReferentsResponse.self, from: data)
           return .success(songs)
        }
        catch let DecodingError.keyNotFound(key, context) {

            print(" Missing key: \(key)")

            print(context.debugDescription)

            print(context.codingPath)

        } catch let DecodingError.typeMismatch(type, context) {

            print(" Type mismatch: \(type)")

            print(context.debugDescription)

            print(context.codingPath)

        } catch let DecodingError.valueNotFound(type, context) {

            print(" Value not found: \(type)")

            print(context.debugDescription)

            print(context.codingPath)

        } catch let DecodingError.dataCorrupted(context) {

            print(" Data corrupted")

            print(context.debugDescription)

        } catch {

            print(error)
    
        }
        return .failure(SongsServiceError.dataError)
    }
  
}

enum ReferentsServiceError : Error {
    case dataError
}
