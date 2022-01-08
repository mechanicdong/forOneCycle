//
//  Diary.swift
//  Diary
//
//  Created by 이동희 on 2022/01/01.
//

import Foundation

//Diary 구조체 생성 20220101@LDH
//Diary 객체에 고유한 값을 저장할 수 있게 UUID 추가, 이 값으로 일기장화면과 즐겨찾기 화면의 일기가 업데이트 되도록 수정 20220108@LDH
struct Diary {
    var uuidString : String
    var title : String //일기의 제목 저장
    var contents : String
    var date : Date //일기가 작성된 날짜 저장
    var isStar : Bool // 즐겨찾기 여부 저장
}
