//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이동희 on 2022/04/12.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    //View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
