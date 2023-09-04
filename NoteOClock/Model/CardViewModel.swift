//
//  CardViewModel.swift
//  NoteOClock
//
//  Created by Samuel Folledo on 9/4/23.
//

import SwiftUI

enum ResizePoint {
    case topLeft, topMiddle, topRight, rightMiddle, bottomRight, bottomMiddle, bottomLeft, leftMiddle
}

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var draggedCard: Card? = nil
    @Published var dragOffset: CGSize? = nil
    @Published var resizedCard: Card? = nil
    @Published var resizeOffset: CGSize? = nil
    @Published var resizePoint: ResizePoint? = nil

    init(cards: [Card] = []) {
        self.cards = cards
    }

    func widthForCardComponent(card: Card) -> CGFloat {
        let widthOffset = (resizedCard?.id == card.id) ? (resizeOffset?.width ?? 0.0) : 0.0
        //TODO: Prevent from shrinking too much
        return card.size.width + widthOffset
    }

    func heightForCardComponent(card: Card) -> CGFloat {
        let heightOffset = (resizedCard?.id == card.id) ? (resizeOffset?.height ?? 0.0) : 0.0
        //TODO: Prevent from shrinking too much
        return card.size.height + heightOffset
    }

    func xPositionForCardComponent(card: Card) -> CGFloat {
        //TODO: Prevent from shrinking too much
        let xPositionOffset = (draggedCard?.id == card.id) ? (dragOffset?.width ?? 0.0) : 0.0
        return card.origin.x + (card.size.width / 2.0) + xPositionOffset
    }

    func yPositionForCardComponent(card: Card) -> CGFloat {
        //TODO: Prevent from shrinking too much
        let yPositionOffset = (draggedCard?.id == card.id) ? (dragOffset?.height ?? 0.0) : 0.0
        return card.origin.y + (card.size.height / 2.0) + yPositionOffset
    }

    func resizeEnded() {
        guard let resizedCard, let resizePoint, let resizeOffset else { return }
        var w: CGFloat = resizedCard.size.width
        var h: CGFloat = resizedCard.size.height
        var x: CGFloat = resizedCard.origin.x
        var y: CGFloat = resizedCard.origin.y
        switch resizePoint {
        case .topLeft:
            w -= resizeOffset.width
            h -= resizeOffset.height
            x += resizeOffset.width
            y += resizeOffset.height
        case .topMiddle:
            h -= resizeOffset.height
            y += resizeOffset.height
        case .topRight:
            w += resizeOffset.width
            h -= resizeOffset.height
        case .rightMiddle:
            w += resizeOffset.width
        case .bottomRight:
            w += resizeOffset.width
            h += resizeOffset.height
        case .bottomMiddle:
            h += resizeOffset.height
        case .bottomLeft:
            w -= resizeOffset.width
            h += resizeOffset.height
            x -= resizeOffset.width
            y += resizeOffset.height
        case .leftMiddle:
            w -= resizeOffset.width
            x += resizeOffset.width
        }
        resizedCard.size = CGSize(width: w, height: h)
        resizedCard.origin = CGPoint(x: x, y: y)
        self.resizeOffset = nil
        self.resizePoint = nil
        self.resizedCard = nil

    }

    func updateForDrag(deltaX: CGFloat, deltaY: CGFloat) {
        dragOffset = CGSize(width: deltaX, height: deltaY)
    }

    func dragEnded() {
        guard let dragOffset else { return }
        draggedCard?.origin.x += dragOffset.width
        draggedCard?.origin.y += dragOffset.height
        draggedCard = nil
        self.dragOffset = nil
    }

    func updateForResize(using resizePoint: ResizePoint, deltaX: CGFloat, deltaY: CGFloat) {
        guard let resizedCard else { return }

        var width: CGFloat = resizedCard.size.width
        var height: CGFloat = resizedCard.size.height
        var x: CGFloat = resizedCard.origin.x
        var y: CGFloat = resizedCard.origin.y

        switch resizePoint {
        case .topLeft:
            width -= deltaX
            height -= deltaY
            x += deltaX
            y += deltaY
        case .topMiddle:
            height -= deltaY
            y += deltaY
        case .topRight:
            width += deltaX
            height -= deltaY
            y += deltaY
            print(width, height, x)
        case .rightMiddle:
            width += deltaX
        case .bottomRight:
            width += deltaX
            height += deltaY
        case .bottomMiddle:
            height += deltaY
        case .bottomLeft: //
            width -= deltaX
            height += deltaY
            x += deltaX
        case .leftMiddle:
            width -= deltaX
            x += deltaX
        }
        resizedCard.size = CGSize(width: width, height: height)
        resizedCard.origin = CGPoint(x: x, y: y)
    }
}
