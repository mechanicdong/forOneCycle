//
//  ViewController.swift
//  TodoList
//
//  Created by 이동희 on 2021/12/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //할 일을 저장하는 배열 선언
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
    @IBAction func tabEditButton(_ sender: UIBarButtonItem) {
    }
    
    // '+' 버튼을 눌렀을 때 Alert이 뜨도록 설정
    @IBAction func tabAddButton(_ sender: UIBarButtonItem) {
        //preferredStyle은 두 가지가 있음. actionSheet, alert
        let alert = UIAlertController(title : "할 일 등록", message : nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: {[weak self]  _ in
            //등록버튼을 눌렀을 때 textFields에 입력된 값을 가져오기, guard로 Optional 바인딩
            guard let title =  alert.textFields?[0].text else { return }
            //Task 구조체 인스턴스
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            //여기까지 하면 할일은 입력할 때 마다 tasks 배열에 추가 됨
            self?.tableView.reloadData() //입력할 때 마다 갱신
            
        })
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        //클로저 사용
        alert.addTextField(configurationHandler: {UITextField in UITextField.placeholder = "할 일을 입력해주세요"})
        self.present(alert, animated: true, completion: nil)
    }
}

//코드의 가독성을 위해 ViewCOntroller를 따로 뺌
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int ) -> Int {
        //numberOfRowsInSection : 각 세션에 표시할 행의 개수를 묻는 메소드
        return self.tasks.count //배열의 개수 반환
    }
    
   
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        //스토리보드에서 정의한 셀을 dequeueReusableCell 메소드를 이용해 가져오게 됨
        //이를 가져온 Cell을 리턴하게 되면 스토리보드에서 구현된 셀이 테이블뷰에 표시 됨
        //dequeueReusableCell : 지정된 재사용 가능한 테이블 뷰 객체를 반환하고, 테이블 뷰에 추가하는 메소드
        //indexPath 위치에 해당 셀을 재사용하기 위해 넘겨줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //배열에 저장되어 있는 할 일 요소들을 가져오기
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
}

