//
//  ContentView.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 01/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                
                MainView(AddWinnerVM: AddWinnerViewModel(), MatchWinnerListVM: MatchWinnerListViewModel())
                    .navigationTitle("Tic Tac")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 Pro")
    }
}



