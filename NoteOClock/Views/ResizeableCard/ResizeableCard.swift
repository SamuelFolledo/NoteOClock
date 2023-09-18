//
//  ResizeableCard.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ResizeableCard: View {
    @ObservedObject var viewModel: CardViewModel
    var isSelected: Bool
    weak var card: Card?
    let menuButtonWidth: CGFloat = 25

    init(card: Card, viewModel: CardViewModel) {
        self.viewModel = viewModel
        self.isSelected = viewModel.selectedCard == card
        self.card = card
    }

    var body: some View {
        if let card {
            VStack {
                Group {
                    switch card.type {
                    case .text:
                        EditableTextView(card: card)
                    case .clock:
                        ClockView(isSelected: isSelected, selectedTextColor: card.type.textColor)
                    }
                }
            }
            .frame(
                width: viewModel.widthForCardComponent(card: card) ?? .zero,
                height: viewModel.heightForCardComponent(card: card) ?? .zero,
                alignment: card.type == .clock ? .center : .topLeading
            )
            .overlay {
                if isSelected {
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
            .background(isSelected ? card.type.backgroundColor : .clear)
            .position(
                x: viewModel.xPositionForCardComponent(card: card) ?? .zero,
                y: viewModel.yPositionForCardComponent(card: card) ?? .zero
            )
            .gesture(repositionGesture)
            .onTapGesture {
                viewModel.updateSelectedCard(card: card)
            }
        }
    }

    var deleteButton: some View {
        VStack(alignment: .trailing) {
            Button {
                if let card,
                   let index = viewModel.cards.firstIndex(of: card) {
                    viewModel.cards.remove(at: index)
                }
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
                if isSelected {
                    viewModel.draggedCard = card
                    viewModel.updateForDrag(deltaX: gesture.translation.width, deltaY: gesture.translation.height)
                }
            }
            .onEnded { _ in
                if isSelected {
                    viewModel.dragEnded()
                }
            }
    }
}
