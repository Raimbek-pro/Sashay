//
//  SongsShow.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//
import Foundation

struct Songs  : Identifiable{
    let id : Int
    let headerImageThumbnailUrl: URL?
    let primaryArtist: Artist
    let fullTitle: String
    let artistNames: String
}
