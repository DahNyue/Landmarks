//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        HStack {
            Image(landmark.imageNames.first ?? "")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(4)
                .shadow(color: Color(landmark.primeColorHexStr) ?? .white, radius: 6, x: 0, y: 0)
            
            Text(landmark.name)

            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .shadow(color: .yellow, radius: 6, x: 0, y: 0)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks.first!)
        }
        .previewLayout(.fixed(width: 300, height: 70))
        .previewDisplayName(landmarks.first?.name ?? "")
    }
}
