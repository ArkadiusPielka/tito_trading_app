//
//  SwipeActionView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 30.01.24.
//

import SwiftUI

struct SwipeActionView<Content: View>: View {
    
    init(actions: [Action], @ViewBuilder content: () -> Content) {
        self.actions = actions
        self.content = content()
    }
    
    var content: Content
    
    @State var offset: CGFloat = 0
    @State var startOfset: CGFloat = 0
    @State var isDragging = false
    @State var isTriggered = false
    
    var triggerTrashHold: CGFloat = -250
    var expansionsTrashHold: CGFloat = -60
    var expansionOffset: CGFloat { CGFloat(actions.count) * -50 }
    
    let actions: [Action]
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if !isDragging {
                    startOfset = offset
                    isDragging = true
                }
                withAnimation(.interactiveSpring) {
                    offset = startOfset + value.translation.width
                }
                
                isTriggered = offset < triggerTrashHold
            }
            .onEnded { value in
                isDragging = false
                
                withAnimation {
                    if value.predictedEndTranslation.width < expansionsTrashHold && !isTriggered {
                        offset = expansionOffset
                    } else {
                        if let action = actions.last, isTriggered {
                            action.action()
                        }
                        offset = 0
                    }
                }
                
                isTriggered = false
            }
    }
    var body: some View {
       content
            .offset(x: offset)
//            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .overlay(alignment: .trailing) {
                ZStack(alignment: .trailing) {
                    ForEach(Array(actions.enumerated()), id: \.offset) { index, action in
                        let proportion = CGFloat(actions.count - index)
                        let isDefault = index == actions.count - 1
                        let width = isDefault && isTriggered ? -offset : -offset * proportion / CGFloat(actions.count)
                        ActionButton(action: action, width: width) {
                            withAnimation {
                                offset = 0
                            }
                        }
                    }
                    .animation(.spring, value: isTriggered)
                    .onChange(of: isTriggered) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }
                }
            }
            .highPriorityGesture(dragGesture)
    }
}

struct ActionButton: View {
    let action: Action
    var width: CGFloat
    var dismiss: () -> Void
    
    var body: some View {
        Button {
            action.action()
            dismiss()
        } label: {
            action.color
                .overlay(alignment: .leading) {
                    Label(action.name, systemImage: action.systemIcon)
                        .labelStyle(.iconOnly)
                        .padding(.leading)
                }
                .clipped()
                .frame(maxWidth: width)
        }
        .buttonStyle(.plain)
    }
}

struct Action {
    var color: Color
    var name: String
    var systemIcon: String
    var action: () -> Void
}

#Preview {
    SwipeActionView(actions: [
        Action(color: .red, name: "Delete", systemIcon: "trash.fill", action: { print("delete")}),
        Action(color: .blue, name: "Bearbeiten", systemIcon: "pencil", action: { print("bearbeiten")}),
        Action(color: .yellow, name: "folder", systemIcon: "folder", action: { print("folder")})
    ]) {   Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
         
    
    }
}
