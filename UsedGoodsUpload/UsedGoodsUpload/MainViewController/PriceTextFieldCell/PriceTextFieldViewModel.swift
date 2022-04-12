//
//  PriceTextFieldViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이동희 on 2022/04/12.
//

import RxSwift
import RxCocoa

struct PriceTextFieldViewModel {
    //ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    //View -> ViewModel
    let priceValue = PublishRelay<String?>()
    let freeSharedButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge (
                priceValue.map { $0 ?? "" == "0" },
                freeSharedButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
            
        self.resetPrice = freeSharedButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
