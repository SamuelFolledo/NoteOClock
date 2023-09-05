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

    var card: Card

    init(card: Card, viewModel: CardViewModel) {
        self.viewModel = viewModel
        self.isSelected = viewModel.selectedCard == card
        self.card = card
    }

    var body: some View {
        ZStack {
            Text(card.type.title)

            if isSelected {
                handlesView
            }
        }
        .frame(
            width: viewModel.widthForCardComponent(card: card),
            height: viewModel.heightForCardComponent(card: card)
        )
        .background(isSelected ? card.type.color : .gray)
        .position(
            x: viewModel.xPositionForCardComponent(card: card),
            y: viewModel.yPositionForCardComponent(card: card)
        )
        .gesture(resizeGesture)
        .onTapGesture { toggleIsSelected() }
    }

    var handlesView: some View {
        CardHandlesView(
            dragged: { point, deltaX, deltaY in
                viewModel.resizedCard = card
                viewModel.updateForResize(using: point, deltaX: deltaX, deltaY: deltaY)
            }, dragEnded: {
                viewModel.resizeEnded()
            })
    }
}

//MARK: - Gestures
private extension ResizeableCard {
    var resizeGesture: some Gesture {
        DragGesture()
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
            viewModel.selectedCard = nil
        }
    }
}
