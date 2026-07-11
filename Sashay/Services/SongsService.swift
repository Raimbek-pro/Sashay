//
//  SongsService.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import Foundation

protocol  SongsServiceProtocol {
    func getSongs( text : String,  page: Int) async -> Result<SongsResponse , SongsServiceError>
}
class MockSongsService  : SongsServiceProtocol{
    func getSongs(text: String, page: Int) async -> Result<SongsResponse, SongsServiceError> {
        return .success(SongsResponse(meta: Meta(status: 1), response: ResponseData(hits: [Hit(index: "", type: "", matchedWords: 1, nbExactWords: 1, nbTypos: 1, highlights: [""], result: SongResult.mock)])))
    }
    
   
}
class SongsService : SongsServiceProtocol{
     var base = URLComponents(string: "https://api.genius.com/search")
    
    func getSongs( text : String,  page: Int) async -> Result<SongsResponse , SongsServiceError> {
        base?.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        var req = URLRequest(url: base!.url!)
        req.setValue("Bearer \(KeychainService.shared.getToken()!)", forHTTPHeaderField: "Authorization")
        do {
            let (data , response) = try await URLSession.shared.data(for: req)
            
            let text = String(data: data, encoding: .utf8)

            print(text ?? "Couldn't decode response as UTF-8")
            
           var songs =  try JSONDecoder().decode(SongsResponse.self, from: data)
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

enum SongsServiceError : Error {
    case dataError
}
