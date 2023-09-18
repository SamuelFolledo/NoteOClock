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
    @Published private(set) var cards: [Card] = []
    @Published var draggedCard: Card? = nil
    @Published var dragOffset: CGSize? = nil
    @Published var resizedCard: Card? = nil
    @Published var resizeOffset: CGSize? = nil
    @Published var previousResizeOffset: CGSize? = nil
    @Published var resizePoint: ResizePoint? = nil

    init(cards: [Card] = []) {
        self.cards = cards
    }

    //MARK: - Public Methods
    func createNewCard(_ card: Card) {
        if card.isSelected {
            deselectAllCards()
        }
        cards.append(card)
    }

    func deleteCard(_ card: Card) {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
        }
    }

    func selectCard(cardId: String) {
        for card in cards {
            if card.id == cardId {
                card.isSelected.toggle()
            } else {
                card.isSelected = false
            }
        }
    }

    func deselectAllCards() {
        cards.forEach { $0.isSelected = false }
    }
}

//MARK: - Size and Position methods
extension CardViewModel {
    func widthForCardComponent(card: Card?) -> CGFloat? {
        if let card {
            let widthOffset = (resizedCard?.id == card.id) ? (resizeOffset?.width ?? 0.0) : 0.0
            //TODO: Prevent from shrinking too much
            return card.size.width + widthOffset
        }
        return nil
    }

    func heightForCardComponent(card: Card?) -> CGFloat? {
        if let card {
            let heightOffset = (resizedCard?.id == card.id) ? (resizeOffset?.height ?? 0.0) : 0.0
            //TODO: Prevent from shrinking too much
            return card.size.height + heightOffset
        }
        return nil
    }

    func xPositionForCardComponent(card: Card?) -> CGFloat? {
        //TODO: Prevent from shrinking too much
        if let card {
            let xPositionOffset = (draggedCard?.id == card.id) ? (dragOffset?.width ?? 0.0) : 0.0
            return card.origin.x + (card.size.width / 2.0) + xPositionOffset
        }
        return nil
    }

    func yPositionForCardComponent(card: Card?) -> CGFloat? {
        //TODO: Prevent from shrinking too much
        if let card {
            let yPositionOffset = (draggedCard?.id == card.id) ? (dragOffset?.height ?? 0.0) : 0.0
            return card.origin.y + (card.size.height / 2.0) + yPositionOffset
        }
        return nil
    }

    //MARK: Resize Functions
    func updateForResize(point: ResizePoint, deltaX: CGFloat, deltaY: CGFloat) {
        resizeOffset = CGSize(width: deltaX, height: deltaY)
        resizePoint = point
    }

    ///Source: https://stackoverflow.com/questions/74916203/how-to-make-code-that-resizes-swiftui-views-using-a-drag-gesture-more-performant
    func updateForResize(using resizePoint: ResizePoint, deltaX: CGFloat, deltaY: CGFloat) {
        guard let resizedCard else { return }
        updateForResize(point: resizePoint, deltaX: deltaX, deltaY: deltaY)
        var width: CGFloat = resizedCard.size.width
        var height: CGFloat = resizedCard.size.height
        var x: CGFloat = resizedCard.origin.x
        var y: CGFloat = resizedCard.origin.y
        // Adjust the values of deltaY and deltaX to mimic a local coordinate space.
        // TODO: Improve this algorithm
        let adjDeltaY = deltaY - (previousResizeOffset?.height ?? 0)
        let adjDeltaX = deltaX - (previousResizeOffset?.width ?? 0)
        switch resizePoint {
        case .topLeft:
            width -= adjDeltaX
            height -= adjDeltaY
            x += adjDeltaX
            y += adjDeltaY
        case .topMiddle:
            height -= adjDeltaY
            y += adjDeltaY
        case .topRight:
            width += adjDeltaX
            height -= adjDeltaY
            y += adjDeltaY
        case .rightMiddle:
            width += adjDeltaX
        case .bottomRight:
            width += adjDeltaX
            height += adjDeltaY
        case .bottomMiddle:
            height += adjDeltaY
        case .bottomLeft:
            width -= adjDeltaX
            height += adjDeltaY
            x += adjDeltaX
        case .leftMiddle:
            width -= adjDeltaX
            x += adjDeltaX
        }
        resizedCard.size = CGSize(width: width, height: height)
        resizedCard.origin = CGPoint(x: x, y: y)
        previousResizeOffset = .init(width: deltaX, height: deltaY)
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
        self.previousResizeOffset = nil
        self.resizeOffset = nil
        self.resizePoint = nil
        self.resizedCard = nil

    }

    //MARK: Drag Methods
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
}
