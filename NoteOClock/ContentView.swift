//
//  ContentView.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

/*
 TODO: Must-haves
 - TODO: Support weather CardType with different viewing mode
 - Add a toolbar on top of keyboard with text field and done button
 - Handle orientation changes
 - Resize font size to fully fill resizeable card

 TODO: Nice-to-haves
 - User font's type, weight, size, color customization
 - Customize clock style (hasDate, hasWeather, isVertical)
 - Customize text's style (border, solid bg)
 - Weather is forced the version to be iOS 16.0 and newer. Try to support iOS 15 and below
 */

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let fakeClockCard = Card(type: .clock, origin: .init(x: screenWidth / 5, y: 100), id: "0")
let fakeWeatherCard = Card(type: .weather, origin: .init(x: screenWidth / 5, y: 100), id: "0")

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
                                createNewCard(type: .weather, proxy)
                            } label: {
                                Label("Weather", systemImage: "cloud.sun.rain")
                            }
                            Button {
                                createNewCard(type: .text, proxy)
                            } label: {
                                Label("Text", systemImage: "text.bubble")
                            }
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
                           origin: type.defaultOrigin(cardCount: addCardCounter, proxy),
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
