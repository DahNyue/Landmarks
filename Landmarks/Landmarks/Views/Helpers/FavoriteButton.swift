//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import SwiftUI

struct FavoriteButton: View {
    var id: Int
    @Binding var isSet: Bool {
        didSet {
            ModelData().updateFavorite(id: id, isOn: isSet)
        }
    }
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(id: 0, isSet: .constant(true))
    }
}
