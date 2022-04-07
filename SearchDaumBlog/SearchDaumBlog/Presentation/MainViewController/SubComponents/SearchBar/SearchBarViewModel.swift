//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 이동희 on 2022/04/07.
//

import RxSwift
import RxCocoa

struct SearchbarViewModel {
    let searchButtonTapped = PublishRelay<Void>()
    let shouldLoadResult: Observable<String>
    
    let queryText = PublishRelay<String?>()
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" } //text: String?
            .filter {
                !$0.isEmpty //$0: error
            }
            .distinctUntilChanged() //동일조건으로 불필요한 네트워크 요청이 발생하지 않도록
    }
}
