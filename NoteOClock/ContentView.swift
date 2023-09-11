//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height

struct ContentView: View {
    @StateObject var cardViewModel = CardViewModel()
    @State var addCardCounter: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(cardViewModel.cards, id: \.id) { card in
                    ResizeableCard(card: card,
                                   viewModel: cardViewModel)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newCard = Card(type: .text, origin: CGPoint(x: proxy.size.width / 2 + addCardCounter * 10, y: proxy.size.height / 2 + addCardCounter * 10), size: CGSize(width: 100, height: 100), id: "\(cardViewModel.cards.count)")
                            cardViewModel.cards.append(newCard)
                            addCardCounter += 1
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(uiColor: .label))
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                        }
                    }
                }
            }
            .onAppear {
                let fakeCard = Card(type: .text, origin: .init(x: 80, y: 90), size: .init(width: 200, height: 200), id: "1")
                cardViewModel.cards.append(fakeCard)
                let fakeCard2 = Card(type: .text, origin: .init(x: 150, y: 150), size: .init(width: 150, height: 150), id: "2")
                cardViewModel.cards.append(fakeCard2)
                let clockCard = Card(type: .clock, origin: .init(x: 100, y: 100), size: .init(width: screenWidth / 1.4, height: 250), id: "0")
                cardViewModel.cards.append(clockCard)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
