//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ContentView: View {
    let fakeCard = Card(type: .text, origin: .init(x: 300, y: 300), size: .init(width: 200, height: 200), id: "1")
    @StateObject var cardViewModel = CardViewModel()

    var body: some View {
        ResizeableCard(card: fakeCard, viewModel: cardViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
