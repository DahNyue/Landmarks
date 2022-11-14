//
//  APIClient.swift
//  SKPlastic
//
//  Created by ChulHyun Jun on 2022/06/09.
//

import Foundation
import Alamofire

class APIService: BaseService {
    
    static let shared = APIService()
    /// API 통신 요청.
    /// - Parameters:
    ///   - defaultAppToken: 기본 앱토큰 사용여부 (기본값 true)
    ///   - requestURL: 요청 url
    ///   - requestType: 요청 타입
    ///   - parameter: 요청  파라미터
    ///   - indicatorBgColor: 인디케이터 배경색
    ///   - completion: 통신 결과
    @discardableResult
    func requestApi<T: Decodable>(defaultAppToken: Bool = true, requestURL url : URL?, requestType type: HTTPMethod, parameter : Parameters? = nil, indicatorShow: Bool = true, alertShow: Bool = true ,completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        //인디케이터 노출
#if iOS
        if indicatorShow {
            DispatchQueue.main.async {
                LoadingIndicatorManager.shared.showIndicator(isShow: true, backgroundColor: .init(red: 0, green: 0, blue: 0, alpha: 0.3))
            }
        }
#endif
        
        //통신가능한 상태 체크
#if iOS
        guard Reachability.isConnectedToNetwork() else {
            //인디케이터 숨김
            LoadingIndicatorManager.shared.showIndicator(isShow: false)
            /*
            let vc = NetworkErrorPopupViewController.instantiate(storyboard: .NetworkError)
            vc.retryCompletion = { [weak self] in
                guard let `self` = self else {return}
                self.requestApi(defaultAppToken: defaultAppToken, requestURL: url, requestType: type, parameter: parameter, indicatorShow: indicatorShow, alertShow: alertShow, completion: completion)
            }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            AppDelegate.applicationDelegate.navigationController?.topViewController?.topViewController()?.present(vc, animated: true, completion: nil)
             */
            return nil
        }
#endif
        //URL 에러
        guard let requestUrl = url else {
            //인디케이터 숨김
#if iOS
            LoadingIndicatorManager.shared.showIndicator(isShow: false)
#endif
            completion(.failure(.urlError))
            return nil
        }
        
        var encParameterBody: Parameters? = nil
        if let parameters = parameter {
            do {
                let encBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let jsonString = String(data: encBody, encoding: .utf8)
                let jsonEncString = AESUtil.encrypt128(str: jsonString ?? "")
                //json암호화된 String값 value에 넣어서 body로 싣어 전송
                encParameterBody = ["param":jsonEncString ?? ""]
                
            } catch {
                completion(.failure(.paramEncryptError))
#if iOS
                LoadingIndicatorManager.shared.showIndicator(isShow: false)
#endif
                return nil
            }
        }
        
        print("requestURL :\(requestUrl) || parameter :\(parameter)")
//        let appToken = AccountManager.shared.appToken
        //공통헤더
        var header: HTTPHeaders = ["Content-Type": "application/json",
                                   "app_type":"I",
                                   "app_ver":"\(DataManager.shared.version)"]
        /*
        //기본 앱토큰 사용
        if defaultAppToken {
            print("appToken : \(appToken)")
            header["Authorization"] = appToken
            guard appToken?.isEmpty == false else {
                Alert.showOneButtonAlertController(title: "유효하지 않은 API 인증토큰 입니다.") {
//                    if let navigatable = AppDelegate.applicationDelegate.navigationController?.topViewController as? BaseViewController {
//                        navigatable.changeInitViewController(type: .SignIn)
//                    }
                }
                LoadingIndicatorManager.shared.showIndicator(isShow: false)
                return nil
            }
        }
        */
        return session.request(requestUrl,
                               method: type,
                               parameters: encParameterBody,
                               encoding: JSONEncoding.default,
                               headers: header,
                               interceptor: APIInterceptor()).response(queue: queue) { response in
#if iOS
            //인디케이터 숨김
            LoadingIndicatorManager.shared.showIndicator(isShow: false)
#endif
            switch response.result {
            case .success(_) :
                if let responseData = response.data {
                    do {
                        /*
                        //서버에서 전달받은 헤더 저장
                        if let authorization = response.response?.allHeaderFields["Authorization"] as? String {
                            AccountManager.shared.appToken = authorization
                        }
                        */
                        //jsonData -> jsonString
                        let jsonString = String(data: responseData, encoding: .utf8)
                        //json
                        let jsonDecString = AESUtil.decrypt128(str: jsonString ?? "")
                        guard let jsonDecData = jsonDecString?.data(using: .utf8) else {
                            print("e." + (jsonString ?? ""))
                            return
                        }
                        let decodeData = try JSONDecoder().decode(BaseResponseModel<T>.self, from: jsonDecData)
                        print("ResponseDataResult : \(decodeData)")
                        guard decodeData.resultCode == .success || decodeData.resultCode == .existInfo else {
                            //토큰만료
                            if decodeData.resultCode == .failToken {
                                //사용자 정보 초기화 및 로그아웃
                                Alert.showOneButtonAlertController(title: decodeData.resultMessage ?? "유효하지 않은 토큰입니다.") {
//                                    if let navigatable = AppDelegate.applicationDelegate.navigationController?.topViewController as? BaseViewController {
//                                        navigatable.changeInitViewController(type: .SignIn)
//                                    }
                                }
                            } else { //그외 에러
                                //에러 메세지 노출 후 확인 버튼 터치시 처리
                                if alertShow == true {
                                    Alert.showOneButtonAlertController(title: decodeData.resultMessage ?? "알수 없는 에러") {
                                        if Thread.isMainThread {
                                            completion(.failure(.error(decodeData.resultCode!)))
                                        } else {
                                            DispatchQueue.main.async {
                                                completion(.failure(.error(decodeData.resultCode!)))
                                            }
                                        }
                                    }
                                } else {
                                    if Thread.isMainThread {
                                        completion(.failure(.error(decodeData.resultCode ?? .fail)))
                                    } else {
                                        DispatchQueue.main.async {
                                            completion(.failure(.error(decodeData.resultCode ?? .fail)))
                                        }
                                    }
                                }
                            }
                            return
                        }
                        guard let resultData = decodeData.data else {
                            //데이터 성공 이지만 data 없음
                            //
                            if Thread.isMainThread {
                                completion(.success(nil))
                            } else {
                                DispatchQueue.main.async {
                                    completion(.success(nil))
                                }
                            }
                            return
                        }
                        
                        //데이터 성공
                        if Thread.isMainThread {
                            completion(.success(resultData))
                        } else {
                            DispatchQueue.main.async {
                                completion(.success(resultData))
                            }
                        }
                    } catch let catchedError {
                        if let decodeError = catchedError as? DecodingError {
                            switch decodeError {
                            case .keyNotFound(let key, let context):
                                print("could not find key \(key) in JSON: \(context.debugDescription)")

                            case .valueNotFound(let value, let context):
                                print("could not find value \(value) in JSON: \(context.debugDescription)")

                            case .typeMismatch(let type, let context):
                                print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                                
                            case .dataCorrupted(let context):
                                print("data found to be corrupted in JSON: \(context.debugDescription)")

                            default:
                                print(decodeError.localizedDescription)
                            }
                        }
#if iOS
                        //에러 메세지 노출 후 확인 버튼 터치시 처리
                        Alert.showOneButtonAlertController( title: catchedError.localizedDescription) {
                            completion(.failure(.jsonDecodeError))
                        }
#endif
                    }
                } else {
                    //reponse data 누락
                    completion(.failure(.jsonDecodeError))
                }
            case .failure(let error):
                print("response failure \(error)")
#if iOS
                //네트워크 에러
                Alert.showOneButtonAlertController( title: error.localizedDescription) {
                    completion(.failure(.networkError))
                }
#endif
            }
        }
    }
}
