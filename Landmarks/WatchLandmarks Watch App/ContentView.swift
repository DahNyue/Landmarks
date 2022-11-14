//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by 김보겸 on 2022/11/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
