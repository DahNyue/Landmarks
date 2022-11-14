//
//  DataManager.swift
//  Landmarks
//
//  Created by 김보겸 on 2022/11/11.
//

import Foundation

struct DataManager {
    static var shared = DataManager()
    
    
    /** @brief AES128 Key */
    private let nKey128   = "paperpocket12345"                   // 16 bytes for AES128
    
    /** @brief iv Key */
    private let nIv       = "12345paperpocket"
    
    /** @brief AES256 Key */
    private let nKey256   = "abcdzfghijnkmnopqrstuvwxyz123456"  // 32 bytes for AES256
    
    /** @brief kakao app Key */
    private let kakaoAppKey = "5f39a8180c0ca3147593cc311679d1f2"
    
    
    /** @brief AES128 Key */
    var key128 : String {
        get {
            return nKey128
        }
    }
    
    /** @brief iv Key */
    var iv : String {
        get {
            return nIv
        }
    }
    
    /** @brief AES256 Key */
    var key256 : String {
        get {
            return nKey256
        }
    }

    /** @brief 번들 아이디 */
    var bundleIdentifier: String {
        if Bundle.main.bundleIdentifier != nil {
            return Bundle.main.bundleIdentifier!
        }
        return ""
    }
    
    
    /** @brief 현재 버젼 */
    var version : String {
        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleShortVersionString"] as? String {
                return version
            }
        }
        return ""
    }
    
    /** @brief 현재 빌드버전 */
    var buildVersion : String {
        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleVersion"] as? String {
                return version
            }
        }
        return ""
    }
    
    // var versionInfo: VersionCheckModel?
    
    /*
    var isJudgeable : Bool {
        // 현재 빌드된 버전 > 서버에서 전달 받은 버전(최신버전) -> 심사 버전
        if let serverAppVerStr = DataManager.shared.versionInfo?.avsName?.replacingOccurrences(of: ".", with: ""),
           let serverAppVerInt = Int(serverAppVerStr),
           let buildedAppVerInt = Int(DataManager.shared.version.replacingOccurrences(of: ".", with: "")),
           buildedAppVerInt > serverAppVerInt {
            // && 심사여부가 Y
            if DataManager.shared.versionInfo?.avsJudgeAt == "Y" {
                return true
            }
        }
        return false
    }
    */
}
