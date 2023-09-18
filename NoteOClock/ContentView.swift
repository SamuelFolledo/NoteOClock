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
    let addButtonWidth: CGFloat = 35
    let newCardSize: CGFloat = 100

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
                            createNewCard(proxy)
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(uiColor: .label))
                                .scaledToFit()
                                .frame(width: addButtonWidth, height: addButtonWidth)
                                .padding(.vertical)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .background(Color(uiColor: .systemBackground))
            .onAppear {
                let fakeCard = Card(type: .text, origin: .init(x: 80, y: 390), size: .init(width: 200, height: 200), id: "1")
                cardViewModel.cards.append(fakeCard)
                let fakeCard2 = Card(type: .text, origin: .init(x: 250, y: 350), size: .init(width: 150, height: 150), id: "2")
                cardViewModel.cards.append(fakeCard2)
                let clockCard = Card(type: .clock, origin: .init(x: screenWidth / 5, y: 100), size: .init(width: screenWidth / 1.5, height: 150), id: "0")
                cardViewModel.cards.append(clockCard)
            }
        }
        .onTapGesture {
            cardViewModel.selectedCard = nil
        }
    }

    func createNewCard(_ proxy: GeometryProxy) {
        let newCard = Card(type: .text,
                           origin: CGPoint(x: proxy.size.width / 2 + addCardCounter * 10, y: proxy.size.height / 2 + addCardCounter * 10),
                           size: CGSize(width: newCardSize, height: newCardSize),
                           id: "\(cardViewModel.cards.count)",
                           isSelected: true)
        cardViewModel.createNewCard(newCard)
        addCardCounter += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
