//
//  AuthService.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import Foundation
import AuthenticationServices

class AuthService :  NSObject , ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        
        for  scene in UIApplication.shared.connectedScenes {
            guard let windowScene =  scene as? UIWindowScene else { continue}
            for window in windowScene.windows where  window.isKeyWindow {
                return window
            }
        }
        return ASPresentationAnchor()
    }
    
    
   var session :   ASWebAuthenticationSession?
    func authGenius() async -> Result<AccessToken,AuthServiceError> {
      
        var base = URLComponents(string: "https://api.genius.com/oauth/authorize")
        base?.queryItems = [
            URLQueryItem(name: "client_id", value:  keysGenius.clientId.rawValue),
            URLQueryItem(name: "redirect_uri", value:  "sashay://oauth"),
            URLQueryItem(name: "scope", value: "me"),
            URLQueryItem(name: "state", value: "\(UUID())"),
            URLQueryItem(name: "response_type", value: "code")
        ]
        let scheme = "sashay"
   
        var code = ""
        do {
             code = try await withCheckedThrowingContinuation{ continuation in
                 self.session = ASWebAuthenticationSession(url: base!.url!, callbackURLScheme: scheme)
                { callbackURL, error in
                    // Handle the callback.
                    guard error == nil, let callbackURL = callbackURL else {
                        continuation.resume(throwing: error ?? AuthServiceError.codeError)
                        return
                    }
                    
                    let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                    
                    if let  codeCallback = queryItems?.filter({ $0.name == "code" }).first?.value {
                        code = codeCallback
                    }
                    continuation.resume(returning: code)
                }
                 self.session?.presentationContextProvider = self
                 self.session?.start()
            }
        }
        catch {
            return .failure(AuthServiceError.codeError)
        }
        
        let urlString = URL(string:  "https://api.genius.com/oauth/token")!
          
          var request = URLRequest(url: urlString)
          request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          let payload = GeniusPayload(code: code, clientSecret: keysGenius.secret.rawValue, grantType: "authorization_code", clientId:  keysGenius.clientId.rawValue , redirectUri: keysGenius.redirect.rawValue, responseType: "code")
          do {
              let body = try JSONEncoder().encode(payload)
              request.httpBody = body
              let (data , response) = try await URLSession.shared.data(for: request)
              
//              if let resp = response as URLResponseda
              let acc = try JSONDecoder().decode(AccessToken.self, from: data)
              return .success(acc)
              
          }
          catch {
              return .failure(AuthServiceError.codeError)
          }
        
    }
}

enum AuthServiceError : Error {
    case codeError
}

struct AccessToken : Decodable {
    let accessToken : String
    enum CodingKeys : String,CodingKey {
        case accessToken = "access_token"
    }
}
