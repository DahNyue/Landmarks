//
//  APIConstants.swift
//  SKPlastic
//
//  Created by ChulHyun Jun on 2022/06/09.
//

import Foundation

struct APIConstants {
    
    /// 서버 도메인
    static var serverBaseURL: String {
        return "http://115.68.184.90:8080"
    }
    
    // MARK: - API Request Make URL
    
    static func appUserLoginURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/member/login")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func signUpURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/member/join")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func userInfoURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/member/selectMyInfo")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func updateUserInfoURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/member/updateMyInfo")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // 공지 사항
    static func noticeInfoURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/notice/selectNoticeList")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // 버전 체크
    static func versionCheckURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/setting/appVersion")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // MARK: 폴더 & 파일 관리
    // 회원 탈퇴
    static func deleteAccountURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/member/deleteMember")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    // 서비스 이용약관
    static func serviceTermsURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/web/terms/service")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // 개인정보 처리방침
    static func privacyTermsURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/web/terms/privacyPolicy")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    
    static func getFolderListURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/folder/selectFolderList")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func createFolderURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/folder/insertFolder")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func updateFolderURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/folder/updateFolder")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func deleteFolderURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/folder/deleteFolder")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func getFileListURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/selectFileList")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }

    static func uploadFileURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/uploadMultipleFiles")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func insertFileURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/insertFile")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func deleteFileURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/deleteFile")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func selectMainValidListURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/selectMainValidList")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // MARK: 전송관련
    static func sendEmailURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/mail/mailSend")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func sendKakaoURL() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/kakao/kakaoSend")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func sendKakaoHistory() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/kakao/insertSendKakaoHistory")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // MARK: 유효기간
    static func createExpireDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/insertValidDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func modifyExpireDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/updateValidDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func deleteExpireDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/deleteValidDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    // MARK: 작성일
    static func createMakeDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/insertWritingDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func modifyMakeDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/updateWritingDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
    static func deleteMakeDate() -> URL? {
        let requestURLstr = (APIConstants.serverBaseURL + "/app/file/deleteWritingDate")
        guard let url = URL(string: requestURLstr) else { return nil }
        return url
    }
    
}
