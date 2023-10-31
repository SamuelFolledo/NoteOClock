//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

/*
 TODO: Must-haves
 - Edit text without showing keyboard (Done button?)
 - Handle orientation changes
 - Resize font size to fully fill resizeable card

 TODO: Nice-to-haves
 - User font's type, weight, size, color customization
 - Customize clock style (hasDate, hasWeather, isVertical)
 - Customize text's style (border, solid bg)
 */

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let fakeClockCard = Card(type: .clock, origin: .init(x: screenWidth / 5, y: 100), size: .init(width: screenWidth / 1.4, height: 150), id: "0")

struct ContentView: View {
    @StateObject var cardViewModel = CardViewModel()
    @State var addCardCounter: Int = 0
    let addButtonWidth: CGFloat = 35
    let newCardSize: CGFloat = 100

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(cardViewModel.cards.indices, id: \.self) { index in
                    ResizeableCard(index: index,
                                   viewModel: cardViewModel)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Menu {
                            Button {
                                createNewCard(type: .clock, proxy)
                            } label: {
                                Label("Time", systemImage: "clock")
                            }
                            Button {
                                createNewCard(type: .clock, proxy)
                            } label: {
                                Label("Weather", systemImage: "cloud.sun.rain")
                            }
                            Button {
                                createNewCard(type: .text, proxy)
                            } label: {
                                Label("Text", systemImage: "text.bubble")
                            }
                        } label: {
                            Button {

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
            }
            .background(Color(uiColor: .systemBackground))
            .onAppear {
                if cardViewModel.cards.isEmpty {
                    cardViewModel.createNewCard(fakeClockCard)
                }
            }
        }
        .onTapGesture {
            cardViewModel.deselectAllCards()
        }
    }

    func createNewCard(type: CardType, _ proxy: GeometryProxy) {
        let newCard = Card(type: type,
                           origin: type.getDefaultOrigin(cardCount: addCardCounter, proxy),
                           size: type.defaultSize,
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
