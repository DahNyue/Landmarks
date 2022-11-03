//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import SwiftUI

struct LandmarkDetail: View {
    
    var landmark: Landmark
    
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
                    Text(landmark.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color(Int(landmark.primeColorHexStr) ?? 0x000000))
                    // .foregroundColor(Color(hue: 0.628, saturation: 1.0, brightness: 0.628))
                        .multilineTextAlignment(.center)
                    
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
        }
        .ignoresSafeArea()
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarks.last!)
    }
}
