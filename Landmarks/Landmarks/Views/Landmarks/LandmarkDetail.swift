//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import SwiftUI

struct LandmarkDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id }) ?? 0
    }
    
    var color :Color? {
//        if let avgColor = Image(landmark.imageNames.last!).averageColor {
//            return Color(uiColor: avgColor)
//        } else {
        return Color(landmark.primeColorHexStr)
//        }
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                MapView(coordinate: landmark.locationCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                CircleImage(imageNames: landmark.imageNames)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(landmark.name)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(color)
                            .multilineTextAlignment(.center)
                        FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                    }
                    HStack {
                        Text(landmark.address)
                            .font(.subheadline)
                        Spacer()
                        Text(landmark.state)
                            .font(.subheadline)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text("About \(landmark.name)")
                        .font(.title2)
                    Text(landmark.description)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle(landmark.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            dismiss()
                                        }
                                , trailing:
                                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
            )
        }
        .ignoresSafeArea()
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks.last!)
    }
}
