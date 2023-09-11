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
                        Text(card.type.title)
                            .padding(.all, 4)
                            .foregroundColor(Color(uiColor: .label))
                    case .clock:
                        ClockView()
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
                }
            }
            .background(isSelected ? card.type.color : .clear)
            .position(
                x: viewModel.xPositionForCardComponent(card: card) ?? .zero,
                y: viewModel.yPositionForCardComponent(card: card) ?? .zero
            )
            .gesture(repositionGesture)
            .onTapGesture { toggleIsSelected() }
        }
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

    func toggleIsSelected() {
        if viewModel.selectedCard == nil {
            viewModel.selectedCard = card
        } else {
            if viewModel.selectedCard != card {
                viewModel.selectedCard = card
            } else {
                viewModel.selectedCard = nil
            }
        }
    }
}
