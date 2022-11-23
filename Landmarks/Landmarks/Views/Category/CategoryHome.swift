//
//  CategoryHome.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/04.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView { // 네비게이션의 시작
            List {
                /// 페이지 컨트롤러가 있는 페이지 뷰
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    /// 카테고리 행 뷰
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            }
            .listStyle(.inset)
            .navigationTitle("Landmarks")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                        .tint(.accentColor)
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
