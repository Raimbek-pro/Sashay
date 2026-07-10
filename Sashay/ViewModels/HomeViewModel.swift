//
//  HomeViewModel.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import Combine
import Foundation

@Observable

class HomeViewModel {
    private let songsService = SongsService()
   
    var page = 1
    var songs : [Songs] = []
    var errorMessage = ""
    
    var isLoading = false
    
    func search(text: String) async {

        songs.removeAll()

        page = 1

        await getSongs(text: text)

    }
    
    func getSongs(text : String) async {
        
        guard !isLoading else { return }

        isLoading = true

        defer { isLoading = false }
        
           let songsResponse =  await songsService.getSongs(text: text,page: page)
        
        switch songsResponse {
        case .success(let songsResp):
            
            songsResp.response.hits.forEach{ hitSong in
                songs.append(getInfo(hit: hitSong ))
                
            }
            page += 1
        case .failure(let error) :
            errorMessage = error.localizedDescription
        }
        
        
    }
    
     private func getInfo(hit: Hit) -> Songs {
        Songs(
            id: hit.result.id,
            headerImageThumbnailUrl: hit.result.headerImageThumbnailUrl,
            primaryArtist: hit.result.primaryArtist,
            fullTitle: hit.result.fullTitle,
            artistNames: hit.result.artistNames
        )
    }
}
