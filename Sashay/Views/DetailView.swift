//
//  DetailView.swift
//  Sashay
//
//  Created by Райымбек Омаров on 11.07.2026.
//

import SwiftUI

struct DetailView: View {
   @State var vm : DetailViewModel
    init(vm: DetailViewModel) {
        self.vm = vm
    }
    var body: some View {
        VStack{
            List {
                ForEach(vm.referents) { ref in
                    switch ref {
                    case .referent(let pairref) :
                        ReferentsView(current: pairref)
                            .onAppear{
                                if ref.id == vm.referents.last?.id{
                                    Task {
                                        await vm.getReferents(id: vm.id)
                                    }
                                }
                            }
                    }
                    
                    
                }
            }.task {
                await vm.getReferents(id: vm.id)
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

struct ReferentsView : View {
    let current : ReferentPair
    var body: some View {
        Grid {
            GridRow {
                Text(current.fragment)
                Text(current.explanation)
            }
        }    }
}

#Preview {
    DetailView(vm: DetailViewModel(id: 1))
}
