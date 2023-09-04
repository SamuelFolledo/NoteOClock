//
//  ResizeableCard.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

struct ResizeableCard: View {
    let card: Card
    @ObservedObject var viewModel: CardViewModel

    var body: some View {
        ZStack {
            Text(card.type.title)

            CardHandlesView { point, deltaX, deltaY in
                //when drag ends...
                viewModel.resizedCard = card
                viewModel.updateForResize(using: point, deltaX: deltaX, deltaY: deltaY)
            } dragEnded: {
                viewModel.resizeEnded()
            }
        }
        .frame(
            width: viewModel.widthForCardComponent(card: card),
            height: viewModel.heightForCardComponent(card: card)
        )
        .background(card.type.color)
        .position(
            x: viewModel.xPositionForCardComponent(card: card),
            y: viewModel.yPositionForCardComponent(card: card)
        )
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    viewModel.draggedCard = card
                    viewModel.updateForDrag(deltaX: gesture.translation.width, deltaY: gesture.translation.height)
                }
                .onEnded { _ in
                    viewModel.dragEnded()
                }
        )
    }
}
