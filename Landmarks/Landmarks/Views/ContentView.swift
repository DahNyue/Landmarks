//
//  ContentView.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI

struct ContentView: View {
    /// @State vs @Binding https://stackoverflow.com/questions/59247183/swiftui-state-vs-binding
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        /// 하단 탭바를 가진 탭 뷰를 생성
        TabView(selection: $selection, content: {
            /// 탭바 컨텐츠 Tuple View ( some View, some View, ... , some View) 한계가 있음, 많이 넣으면 More가 되어서 보여주는 뷰가 따로 생김
            CategoryHome()
                .tabItem({
                    Label("Featured", systemImage: "photo.on.rectangle.angled")
                })
                .tag(Tab.featured)
            
            LandmarkList()
                .tabItem({
                    Label("List", systemImage: "list.bullet")
                })
                .tag(Tab.list)
        })
        .tint(.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
