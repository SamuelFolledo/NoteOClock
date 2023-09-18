//
//  ResizeableCard.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ResizeableCard: View {
    @ObservedObject var viewModel: CardViewModel
    @ObservedObject var card: Card
    let menuButtonWidth: CGFloat = 25

    init(index: Int, viewModel: CardViewModel) {
        self.viewModel = viewModel
        self.card = viewModel.cards[index]
    }

    var body: some View {
        VStack {
            Group {
                switch card.type {
                case .text:
                    TextView(card: card)
                case .clock:
                    ClockView(card: card)
                }
            }
        }
        .frame(
            width: viewModel.widthForCardComponent(card: card) ?? .zero,
            height: viewModel.heightForCardComponent(card: card) ?? .zero,
            alignment: card.type == .clock ? .center : .topLeading
        )
        .overlay {
            if card.isSelected {
                CardHandlesView(
                    dragged: { point, deltaX, deltaY in
                        if viewModel.resizedCard != card {
                            viewModel.resizedCard = card
                        }
                        viewModel.updateForResize(using: point, deltaX: deltaX, deltaY: deltaY)
                    }, dragEnded: {
                        viewModel.resizeEnded()
                    })

                deleteButton
            }
        }
        .background(card.backgroundColor)
        .position(
            x: viewModel.xPositionForCardComponent(card: card) ?? .zero,
            y: viewModel.yPositionForCardComponent(card: card) ?? .zero
        )
        .gesture(repositionGesture)
        .onTapGesture {
            viewModel.selectCard(cardId: card.id)
        }
    }

    var deleteButton: some View {
        VStack(alignment: .trailing) {
            Button {
               viewModel.deleteCard(card)
            } label: {
                Image(systemName: "trash.fill")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(uiColor: .systemRed))
                    .scaledToFit()
                    .frame(width: menuButtonWidth, height: menuButtonWidth)
            }
            Spacer()
        }
        .offset(y: -menuButtonWidth - 20)
    }
}

//MARK: - Gestures
private extension ResizeableCard {
    var repositionGesture: some Gesture {
        DragGesture(coordinateSpace: .global)
            .onChanged { gesture in
                if card.isSelected {
                    viewModel.draggedCard = card
                    viewModel.updateForDrag(deltaX: gesture.translation.width, deltaY: gesture.translation.height)
                }
            }
            .onEnded { _ in
                if card.isSelected {
                    viewModel.dragEnded()
                }
            }
    }
}
