//
//  TitleTextFieldViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이동희 on 2022/04/12.
//

import RxCocoa
//ViewModel
struct TitleTextFieldViewModel {
    let titleText = PublishRelay<String?>() //UIEvent 받는 PublishRelay 타입 선언
    //이 Cell에는 위 하나의 액션이 전부일 것..
}
