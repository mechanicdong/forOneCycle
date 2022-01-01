//
//  Diary.swift
//  Diary
//
//  Created by 이동희 on 2022/01/01.
//

import Foundation

//Diary 구조체 생성 20220101@LDH
struct Diary {
    var title : String //일기의 제목 저장
    var contents : String
    var date : Date //일기가 작성된 날짜 저장
    var isStar : Bool // 즐겨찾기 여부 저장
}
