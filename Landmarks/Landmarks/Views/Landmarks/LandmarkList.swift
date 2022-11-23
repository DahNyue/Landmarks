//
//  LandmarkList.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/03.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { (!showFavoritesOnly || $0.isFavorite) }
    }
    
    var body: some View {
        NavigationView {
            /*
            VStack {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                .tint(.brown)
                .padding(.horizontal, 20)
                
                List {
                    ForEach(filteredLandmarks) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationTitle("Landmarks")
             */
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                .tint(.orange)
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (3rd generation)", "iPhone 14 Pro Max", "iPad Pro (12.9-inch) (5th generation)"], id: \.self) { deviceName in
            LandmarkList()
                .environmentObject(ModelData())
            /// preview 용 Device 분류, 디바이스가 내 시뮬레이터로 동작이 되어야 제대로 동작하는 듯 함
                .previewDevice(PreviewDevice(rawValue: deviceName)).previewDisplayName(deviceName)
        }
    }
}
