//
//  Referents.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

struct ReferentsResponse: Decodable {
    let response: ReferentsWrapper
}

struct ReferentsWrapper: Decodable {
    let referents: [Referent]
}

struct Referent: Decodable {
    let fragment: String
    let annotations: [Annotation]
}

struct Annotation: Decodable {
    let body: AnnotationBody
}

struct AnnotationBody: Decodable {
    let plain: String?
}
