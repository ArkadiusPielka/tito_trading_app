//
//  CustomTabBar.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var activTab: Tab
    
    // Color oben und opacity
    var color1 = Color("bar")
    var opacity1 = 0.9
    
    
    var color2 = Color("bar")
    var color3 = Color(.black)
    
    var colorStroke = Color.white
    var colorIndicator = Color.white
    var colorIcon = Color.white
    
//    var colorGlow1 = Color.red
//    var colorGlow2 = Color.green
    
    var colorText = Color(.white)
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    
                    Image(systemName: tab.image)
                        .resizable()
                        .symbolEffect(.bounce.down.byLayer, value: true)
                        .foregroundColor(colorIcon)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 30, height: 30)
                        .offset(y: offset(tab))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activTab = tab
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                    
                }
                .padding(.top, 12)
                .padding(.bottom, 20)
            }
        }
        .padding(.bottom, safeArea.bottom == 0 ? 15 : safeArea.bottom)
        .background(content: {
            ZStack {
                TabBarTopCurve()
                    .stroke(colorStroke, lineWidth: 0.5)
                    .blur(radius: 0.5)
                    .padding(.horizontal, -10)
                
                TabBarTopCurve()
                    .fill(color1.opacity(opacity1).gradient)
            }
        })
        .overlay(content: {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxWidth = width * 5
                let height = rect.height
                
                Circle()
                    .fill(.clear)
                    .frame(width: maxWidth, height: maxWidth)
                    .background(alignment: .top) {
                        Rectangle()
                            .fill(.linearGradient(colors: [color1, color2, color3], startPoint: .top, endPoint: .bottom))
                            .frame(width: width, height: height)
                            .mask(alignment: .top) {
                                Circle()
                                    .frame(width: maxWidth, height: maxWidth, alignment: .top)
                            }
                    }
                    .overlay(content: {
                        Circle()
                            .stroke(colorStroke, lineWidth: 0.2)
                            .blur(radius: 0.5)
                    })
                    .frame(width: width)
                    .background(content: {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            Rectangle()
                                .fill(colorIndicator)
                                .frame(width: 25, height: 4)
                                .glow(for: tab, activeTab: activTab, radius: 50)
                                .glow(for: tab, activeTab: activTab, radius: 50)
                                .offset(y: -1.5)
                                .offset(y: -maxWidth / 2)
                                .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxWidth / 2, actualWidth: width, true)))
                                .rotationEffect(.init(degrees: calculateRotation(maxedWidth: maxWidth / 2, actualWidth: width)))
                        }
                    })
                
                    .offset(y: height / 2.1)
                
            }
            .overlay(alignment: .bottom) {
                Text(activTab.title)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(colorText)
                    .offset(y: safeArea.bottom == 0 ? -15 : -safeArea.bottom + 12)
            }
        })
    }
    
    func calculateRotation(maxedWidth y: CGFloat, actualWidth: CGFloat, _ isInitial: Bool = false) -> CGFloat {
        let tabWidth = actualWidth / Tab.count
        let firstPositionX: CGFloat = -(actualWidth - tabWidth) / 2
        let tan = y / firstPositionX
        let radius = atan(tan)
        let degree = radius * 180 / .pi
        
        if isInitial {
            return -(degree + 90)
        }
        
        let x = tabWidth * activTab.index
        let tan_ = y / x
        let radius_ = atan(tan_)
        let degree_ = radius_ * 180 / .pi
        
        return -(degree_ - 90)
    }
    
    func offset(_ tab: Tab) -> CGFloat {
        let totalIndices = Tab.count
        let currentIndex = tab.index
        let progress = currentIndex / totalIndices
        
        return progress < 0.5 ? (currentIndex * -10) : ((totalIndices - currentIndex - 1) * -10)
    }
}

#Preview {
    ContentView()
}

struct TabBarTopCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            let midWidth = width / 2
            
            path.move(to: .init(x: 0, y: 5))
            
            path.addCurve(to: .init(x: midWidth, y: -20), control1: .init(x: midWidth / 2, y: -20), control2: .init(x: midWidth, y: -20))
            path.addCurve(to: .init(x: width, y: 5), control1: .init(x: (midWidth + (midWidth / 2)), y: -20), control2: .init(x: width, y: 5))
            
            path.addLine(to: .init(x: width, y: height))
            path.addLine(to: .init(x: 0, y: height))
            
            path.closeSubpath()
        }
    }
}
