//
//  HikeBadge.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct HikeBadge: View {
    
    var name: String
    
    var grayscale: CGFloat?
    var hueRotation: Angle?
    
    var callBack: ((_ id: String, _ isSelected: Bool) -> Void)?
    
    @State var isHover = false
    
    var body: some View {
        
        Button(action: {
            self.isHover.toggle()
            self.callBack?(self.name, self.isHover)
        }) {
            VStack(alignment: .center, spacing: 5) { // 6.8) {
                Badge()
                    .frame(width: 300, height: 300)
                    .scaleEffect(1.0 / 3.0)
                    .frame(width: 100, height: 100)
                    .hoverEffect(.lift)
                    .onHover { hover in
                        self.isHover = hover
                    }
                
                Text(name)
                    .font(.caption)
                    .accessibilityLabel("Badge for \(name).")
                    .tint(.accentColor)
            }
        }
        .grayscale(self.grayscale ?? 0)
        .hueRotation(self.hueRotation ?? Angle())
        
        .foregroundColor(.accentColor)
        .scaleEffect(self.isHover ? 1.2 : 1)
        .padding(.horizontal, self.isHover ? 7.5 : 0)
        .padding(.vertical, self.isHover ? 15 : 5)
        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(0x123456), lineWidth: isHover ? 0.5 : 0)
        )
        // .border(width: 1, edges: self.isHover ? [.bottom] : [], color: .accentColor)
        .animation(.spring(), value: self.isHover)
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
