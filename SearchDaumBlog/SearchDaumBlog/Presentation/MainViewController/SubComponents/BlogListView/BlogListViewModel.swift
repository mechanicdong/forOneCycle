//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 이동희 on 2022/04/07.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    //cellData는 외부에서 가지고 오게 됨
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
