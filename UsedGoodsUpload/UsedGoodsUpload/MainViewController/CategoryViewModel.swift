//
//  CategoryViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이동희 on 2022/04/12.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let disposeBag = DisposeBag()
    
    //이벤트 전달 방향: ViewModel -> View
    let cellData: Driver<[Category]> //카테고리를 나타낼 셀데이터를 뷰에게 전달
    let pop: Signal<Void>
    
    //이벤트 전달 방향: View -> ViewModel
    let itemSelected = PublishRelay<Int>() //몇번째 아이템인지 row 값 전달용
    
    //이벤트 전달 방향: ViewModel -> ParentsViewModel
    let selectedCategory = PublishRelay<Category>()
    
    init() {
        let categories = [
            Category(id: 1, name: "디지털/가전"),
            Category(id: 2, name: "게임"),
            Category(id: 3, name: "스포츠/레저"),
            Category(id: 4, name: "유아/아동용품"),
            Category(id: 5, name: "여성패션/잡화"),
            Category(id: 6, name: "뷰티/미용"),
            Category(id: 7, name: "남성패션/잡화"),
            Category(id: 8, name: "생활/식품"),
            Category(id: 9, name: "가구"),
            Category(id: 10, name: "도서/티켓/취미"),
            Category(id: 11, name: "기타")
        ]
        
        self.cellData = Driver.just(categories)
        
        self.itemSelected
            .map { categories[$0] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        self.pop = itemSelected
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
}
