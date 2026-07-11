//
//  HomeView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 10.07.2026.
//

import SwiftUI

struct HomeView : View {
    @State var vm = HomeViewModel()
    @State var songName = ""
    var body : some View {
        VStack {
            HStack {
                TextField("Find artist or song", text: $songName )
                    .frame(maxWidth: .infinity)
                Button("Find"){
                    Task{
                        await vm.search(text: songName)
                    }
                }
                .padding()
                .buttonStyle(GreenButton())
            }
            List{
                ForEach(vm.songs) { song in
                    NavigationLink(destination : DetailView(vm: DetailViewModel(id: song.id))){
                        SongShow(song: song)
                    }
                   // .buttonStyle(.plain)
                   
                        .onAppear {
                            if song.id == vm.songs.last?.id {
                                Task {
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
