//
//  GeniusPayload.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

struct GeniusPayload : Encodable {
    let code : String
    let clientSecret : String
    let grantType : String
    let clientId : String
    let redirectUri : String
    let responseType : String
    
    enum CodingKeys : String,CodingKey {
        case clientSecret = "client_secret"
        case grantType = "grant_type"
        case clientId = "client_id"
        case redirectUri = "redirect_uri"
        case responseType = "response_type"
        case code = "code"
    }
}
