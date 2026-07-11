//
//  DetailViewModel.swift
//  Sashay
//
//  Created by Райымбек Омаров on 11.07.2026.
//


import Combine
import Foundation

@Observable
class DetailViewModel {
    
    private let referentsService = ReferentsService()
    let id : Int
    init(id : Int){
        self.id = id
    }
    var page = 1
    var referents : [ReferentShow] = []
    var errorMessage = ""
    
    var isLoading = false
    
    func search() async {

        referents.removeAll()

        page = 1

        await getReferents(id : id)

    }
    
    func getReferents(id : Int) async {
        
        guard !isLoading else { return }

        isLoading = true

        defer { isLoading = false }
        
        let songsResponse =  await referentsService.getReferents(text: id, page: page)
        
        switch songsResponse {
        case .success(let songsResp):
            
        

            let pairs: [ReferentShow] = songsResp.response.referents.compactMap { referent in
                guard let text = referent.annotations.first?.body.plain, !text.isEmpty else { return nil }
                return ReferentPair(fragment: referent.fragment, explanation: text)
            }.map { ReferentShow.referent($0) }
         
            referents.append(contentsOf: pairs)
            page += 1
            
        case .failure(let error) :
            errorMessage = error.localizedDescription
            }
           
      
        }
        
        
    }
    


struct ReferentPair: Identifiable {
    let id = UUID()
    let fragment: String
    let explanation: String

}

enum ReferentShow: Identifiable {
    case referent(ReferentPair)
    var id: UUID {
        switch self {

        case .referent(let pair):

            return pair.id

        }

    }

}
