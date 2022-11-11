//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/02.
//

import SwiftUI
import Alamofire

@main
struct LandmarksApp: App {
    
    @StateObject private var modelData = ModelData()
    
    func requestUserInfo<T: Decodable>(modelType: T.Type, completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        let url = URL(string: "http://115.68.184.90:8080/swiftUi/landmark/selectLandmarkList")!
        return APIService.shared.requestApi(defaultAppToken: true, requestURL:url, requestType: .post, completion: completion)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    _ = requestUserInfo(modelType: [Landmark].self) { [self] result in
                        switch result {
                        case .success(let landmarks):
                            self.modelData.landmarks = landmarks ?? []
                        case .failure(let error):
                            print("e. \(error.localizedDescription)")
                            self.modelData.landmarks = []
                        }
                    }
                }
                .environmentObject(modelData)
        }
    }
}
