//
//  CategoryItem.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Image(landmark.imageNames.last!)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                
                Text(landmark.name)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(landmark.primeColorHexStr))
                    .font(.caption)
            }
            .shadow(color: Color(landmark.primeColorHexStr) ?? .white, radius: 6, x: 0, y: 0)
            .padding(.leading, 15)
            .padding(.vertical, 15)
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .padding(EdgeInsets(top: 0, leading: 140, bottom: 150, trailing: 0))
                    .shadow(color: .yellow, radius: 6, x: 0, y: 0)
            }
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: ModelData().landmarks[2])
    }
}
