//
//  HomeView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI

import FirebaseAnalytics
import FirebaseCrashlytics

struct HomeView : View {
    @State var vm = HomeViewModel(songsService: SongsService())
    @State var songName = ""
    var body : some View {
        VStack {
            HStack {
                TextField("Find artist or song", text: $songName )
                    .frame(maxWidth: .infinity)
                Button("Find"){
                    Task{
                        
                        Crashlytics.crashlytics().log("User tapped Find with query: \(songName)")
                        
                       /** this one does get sent, and shows up in your Analytics dashboard as a "search" event with the search term attached. Purpose: track what people are searching for. **/
                        Analytics.logEvent(AnalyticsEventSearch, parameters: [
                            AnalyticsParameterSearchTerm: songName
                        ])
                        
                        await vm.search(text: songName)
                    }
                }
                .padding()
                .buttonStyle(GreenButton())
            }
            List{
                ForEach(vm.songs) { song in
                    NavigationLink(destination : DetailView(vm: DetailViewModel(id: song.id, songName: song.fullTitle))){
                        SongShow(song: song)
                    }
                   /** Purpose of analytics log which song someone opened. **/
//                    .simultaneousGesture(TapGesture().onEnded {
//                        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//                            AnalyticsParameterContentType: "song",
//                            AnalyticsParameterItemID: song.id,
//                            AnalyticsParameterItemName: song.fullTitle
//                        ])
//                    })
                        .onAppear {
                            if song.id == vm.songs.last?.id {
                                Task {
                                    Crashlytics.crashlytics().log("Loading more songs, query: \(songName)")
                                    await vm.getSongs(text: songName)
                                    }
                            }
                        }
                }
            }
            if vm.isLoading {

                  HStack {

                      Spacer()

                      ProgressView()

                      Spacer()

                  }

              }
        }
        .onAppear {
                    Analytics.logEvent(AnalyticsEventScreenView, parameters: [
                        AnalyticsParameterScreenName: "HomeView",
                        AnalyticsParameterScreenClass: "HomeView"
                    ])
                }
        
    }
}


struct SongShow : View {
    let song : Songs
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: song.headerImageThumbnailUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {
                    ProgressView()
                }

                .frame(width: 80, height: 80)

                .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                VStack(alignment: .leading, spacing: 4) {
                    Text(song.artistNames)
                        .font(.headline)
                    Text(song.fullTitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }.padding()
            Divider()
        }
    }
}

#Preview {
    HomeView()
}
