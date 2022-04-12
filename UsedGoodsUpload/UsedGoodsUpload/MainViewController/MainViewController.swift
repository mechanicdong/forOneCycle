//
//  MainViewController.swift
//  UsedGoodsUpload
//
//  Created by 이동희 on 2022/04/11.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel) {
        
    }
    
    private func attribute() {
        navigationItem.title = "중고거래 글쓰기"
        view.backgroundColor = .white
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView() //TODO: 있고 없고 차이 확인
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)
extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> { //base = MainViewController
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(action)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
