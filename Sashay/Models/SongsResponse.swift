//
//  Songs.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//


import Foundation



// MARK: - Root Response
struct SongsResponse: Decodable {
    let meta: Meta
    let response: ResponseData
}

struct Meta: Decodable {
    let status: Int
}

struct ResponseData: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let index: String
    let type: String
    let matchedWords: Int
    let nbExactWords: Int
    let nbTypos: Int
    let highlights: [String]
    let result: SongResult

    enum CodingKeys: String, CodingKey {
        case index, type, highlights, result
        case matchedWords = "matched_words"
        case nbExactWords = "nb_exact_words"
        case nbTypos = "nb_typos"
    }
}

// MARK: - Song Result
struct SongResult: Decodable {
    let id: Int
    let title: String
    let fullTitle: String
    let artistNames: String
    let primaryArtistNames: String
    let path: String
    let url: URL?
    let annotationCount: Int
    let lyricsOwnerId: Int
    let lyricsState: String
    let pyongsCount: Int?
    let pendingLyricsEditsCount: Int
    let releaseDateForDisplay: String?
    let releaseDateWithAbbreviatedMonthForDisplay: String?
    let headerImageThumbnailUrl: URL?
    let headerImageUrl: URL?
    let songArtImageThumbnailUrl: URL?
    let songArtImageUrl: URL?
    let relationshipsIndexUrl: URL?
    let featuredArtists: [Artist]
    let primaryArtist: Artist
    let primaryArtists: [Artist]

    enum CodingKeys: String, CodingKey {
        case id, title, path, url
        case fullTitle = "full_title"
        case artistNames = "artist_names"
        case primaryArtistNames = "primary_artist_names"
        case annotationCount = "annotation_count"
        case lyricsOwnerId = "lyrics_owner_id"
        case lyricsState = "lyrics_state"
        case pyongsCount = "pyongs_count"
        case pendingLyricsEditsCount = "pending_lyrics_edits_count"
        case releaseDateForDisplay = "release_date_for_display"
        case releaseDateWithAbbreviatedMonthForDisplay = "release_date_with_abbreviated_month_for_display"
        case headerImageThumbnailUrl = "header_image_thumbnail_url"
        case headerImageUrl = "header_image_url"
        case songArtImageThumbnailUrl = "song_art_image_thumbnail_url"
        case songArtImageUrl = "song_art_image_url"
        case relationshipsIndexUrl = "relationships_index_url"
        case featuredArtists = "featured_artists"
        case primaryArtist = "primary_artist"
        case primaryArtists = "primary_artists"
    }
}

// MARK: - Artist
struct Artist: Decodable {
    let id: Int
    let name: String
    let apiPath: String
    let url: URL?
    let imageUrl: URL?
    let headerImageUrl: URL?
    let isMemeVerified: Bool
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, url
        case apiPath = "api_path"
        case imageUrl = "image_url"
        case headerImageUrl = "header_image_url"
        case isMemeVerified = "is_meme_verified"
        case isVerified = "is_verified"
    }
}
