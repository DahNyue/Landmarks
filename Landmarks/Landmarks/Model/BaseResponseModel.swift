//
//  BaseResponseModel.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/11.
//

import Foundation

struct BaseResponseModel<T: Decodable>: Decodable {
    let resultCode : ResultCode?
    let resultMessage : String?
    let data: T?
}

struct EmptyModel: Decodable {}

