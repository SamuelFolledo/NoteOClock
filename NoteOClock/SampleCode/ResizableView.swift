////
////  HomeView.swift
////  NoteOClock
////
////  Created by Samuel Folledo on 9/4/23.
////
//
//import SwiftUI
//
//struct ResizableView: View {
//    @GestureState private var dragState = DragState.inactive
//    @State private var size = CGSize(width: 200, height: 200)
//    @State private var position = CGPoint(x: 100, y: 100)
//    @State private var maxWidth: CGFloat = UIScreen.main.bounds.width
//    @State private var maxHeight: CGFloat = UIScreen.main.bounds.height
//    @State private var isActive = false
//
//    var body: some View {
//        // Rectangle with handles
//        Rectangle()
//            .frame(width: size.width, height: size.height)
//            .position(position)
//            .foregroundColor(isActive ? .blue : .gray)
//            .onTapGesture {
//                isActive.toggle()
//            }
//            .overlay(
//                GeometryReader { geometry in
//                    // Top-left handle
//                    Handle(color: .red)
//                        .offset(x: -size.width / 2 - 10, y: -size.height / 2 - 10)
//                        .gesture(resizeGesture(corner: .topLeading, geometry: geometry))
//
//                    // Top-right handle
//                    Handle(color: .green)
//                        .offset(x: size.width / 2 + 10, y: -size.height / 2 - 10)
//                        .gesture(resizeGesture(corner: .topTrailing, geometry: geometry))
//
//                    // Bottom-left handle
//                    Handle(color: .blue)
//                        .offset(x: -size.width / 2 - 10, y: size.height / 2 + 10)
//                        .gesture(resizeGesture(corner: .bottomLeading, geometry: geometry))
//
//                    // Bottom-right handle
//                    Handle(color: .orange)
//                        .offset(x: size.width - 10, y: size.height - 10)
//                        .gesture(resizeGesture(corner: .bottomTrailing, geometry: geometry))
//                }
//            )
//            .gesture(dragGesture)
//    }
//
//    var dragGesture: some Gesture {
//        DragGesture()
//            .updating($dragState) { (value, state, _) in
//                state = .dragging(translation: value.translation)
//            }
//            .onEnded { (value) in
//                let newX = position.x + value.translation.width
//                let newY = position.y + value.translation.height
//
//                position.x = max(min(newX, maxWidth - size.width / 2), size.width / 2)
//                position.y = max(min(newY, maxHeight - size.height / 2), size.height / 2)
//            }
//    }
//
//    func resizeGesture(corner: Corner, geometry: GeometryProxy) -> some Gesture {
//        DragGesture()
//            .onChanged { value in
//                if isActive {
//                    var newWidth = size.width
//                    var newHeight = size.height
//
//                    if corner.isTop {
//                        newHeight += -value.translation.height
//                    } else if corner.isBottom {
//                        newHeight += value.translation.height
//                    }
//
//                    if corner.isLeft {
//                        newWidth += -value.translation.width
//                    } else if corner.isRight {
//                        newWidth += value.translation.width
//                    }
//
//                    let maxWidth = geometry.size.width
//                    let maxHeight = geometry.size.height
//
//                    size.width = max(min(newWidth, maxWidth - position.x + size.width / 2), 50)
//                    size.height = max(min(newHeight, maxHeight - position.y + size.height / 2), 50)
//
//                    // Update handle positions based on the resized size
////                    position.x = min(max(position.x, size.width / 2), maxWidth - size.width / 2)
////                    position.y = min(max(position.y, size.height / 2), maxHeight - size.height / 2)
//                }
//            }
//    }
//}
//
//enum DragState {
//    case inactive
//    case dragging(translation: CGSize)
//}
//
//enum Corner {
//    case topLeading, topTrailing, bottomLeading, bottomTrailing
//
//    var isTop: Bool { self == .topLeading || self == .topTrailing }
//    var isBottom: Bool { self == .bottomLeading || self == .bottomTrailing }
//    var isLeft: Bool { self == .topLeading || self == .bottomLeading }
//    var isRight: Bool { self == .topTrailing || self == .bottomTrailing }
//}
//
//struct Handle: View {
//    var color: Color
//
//    var body: some View {
//        Circle()
//            .fill(color)
//            .frame(width: 20, height: 20)
//            .shadow(radius: 5)
//    }
//}
//
//struct ResizableView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResizableView()
//    }
//}
