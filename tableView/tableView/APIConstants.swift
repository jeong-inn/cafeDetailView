//
//  APIContants.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/22.
//

import Foundation


struct APIConstants {
    // MARK: -  Base URL
    static let baseURL = "https://cazait.shop"
    
    // MARK: - Feature URL
    static let allCafeURL = baseURL + "/api/cafes/all" // 카페 전체 조회
    
    static let searchCafeURL = baseURL + "/api/cafes/name" // 카페 이름 조회
    
    static let detailCafeURL = baseURL + "/api/cafes/id" // 카페 ID 조회
    
    static let detailCafeMenuURL = baseURL + "/api/menus/cafe" // 카페 메뉴 조회
    
    static let cafeReviewURL = baseURL + "/api/reviews" // 카페 리뷰 조회 및 평점 조회
    
    static let writeReviewURL = baseURL + "/api/reviews/user" // 카페 리뷰 작성
    
    static let signupURL = baseURL + "/api/users/sign-up" // 회원가입
    
    static let nicknamecheckURL = baseURL + "/api/users/nickname" // 닉네임 중복확인
    
    static let emailcheckURL = baseURL + "/api/users/email" // 이메일 중복확인
    
    static let loginURL = baseURL + "/api/auths/log-in?role=user" // 로그인(유저)
    
}
