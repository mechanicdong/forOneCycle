//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 이동희 on 2022/04/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()

/* MVVC Refactoring
 //searchbar 버튼 탭 이벤트
 let searchButtonTapped = PublishRelay<Void>()
 
 //Searchbar 외부로 내보낼 이벤트
 var shouldLoadResult = Observable<String>.of("")
 */

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //bind() //delete for MVVM Refactoring
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(_ viewModel: SearchbarViewModel) {
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        //1) keyboard의 search button이 tapped
        //2) 추가한 button이 tapped 된 경우
        Observable
            .merge (
                self.rx.searchButtonClicked.asObservable(), //searchButtonClicked 타입이 ControlEvent이기 때문에 asobservable
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped) //두가지 옵저버블이 이벤트를 발생할 때마다 해당 이벤트가 서치버튼 이벤트로 바인딩되어 해당 서브젝트가 이벤트를 가질 수있게 됨
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
/*      MVVM Refactoring
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" } //text: String?
            .filter {
                !$0.isEmpty //$0: error
            }
            .distinctUntilChanged() //동일조건으로 불필요한 네트워크 요청이 발생하지 않도록
 */
        
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
        
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in  //base는 SearchBar를 의미
            base.endEditing(true)
        }
    }
    
}
