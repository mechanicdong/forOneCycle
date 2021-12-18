//
//  ViewController.swift
//  TodoList
//
//  Created by 이동희 on 2021/12/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //Edit 버튼으로 수정 모드 - Strong @20211218LDH start
    @IBOutlet var editButton: UIBarButtonItem!
    var doneButton : UIBarButtonItem?
    //Edit 버튼으로 수정 모드 - Strong @20211218LDH end
    
    //할 일을 저장하는 배열 선언
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap)) //Edit 버튼으로 수정 모드 @20211218LDH
        self.tableView.dataSource = self
        self.tableView.delegate = self //체크마크 생성 @20211218LDH
        self.loadTasks()
    }
    //Edit 버튼으로 수정 모드 @20211218LDH start
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true) //편집모드에서 빠져 나오게끔
    }

    @IBAction func tabEditButton(_ sender: UIBarButtonItem) {

        guard !self.tasks.isEmpty else { return } //tableView가 비어있으면 편집모드로 들어갈 필요가 없음
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    //Edit 버튼으로 수정 모드 @20211218LDH end
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
    func saveTasks() {
        //할일들을 UserDefaults에 dictionaries 형태로 저장
        let data = self.tasks.map {
            [
                "title": $0.title, //key
                "done" : $0.done
            ]
        }
        //UserDafaults : 싱글톤이기 때문에 하나의 인스턴스에만 존재, RunTime환경에 동작하면서 앱이 실행되는 동안
        //기본저장소에 접근해 데이터를 기록하고 가져오는 인터페이스, 키 밸류 쌍으로 저장, 싱글톤 패턴, 하나의 인스턴스만 존재
        //userDafaluts에 할 일을 저장하기
        let userDefaluts = UserDefaults.standard //UserDefaults에 접근할 수 있게 만듦
        userDefaluts.set(data, forKey: "tasks")
    }
    //userDafaluts에 저장된 할 일을 load
    func loadTasks() {
        let userDefaults = UserDefaults.standard //UserDafaults에 접근
        //할 일 불러오기
        //object method는 Any Type 리턴이므로 딕셔너리로 저장했으니 딕셔너리 배열형식으로 타입캐스팅
        guard let data = userDefaults.object(forKey: "tasks") as? [[String : Any]] else { return }
        
        //다시 tasks 배열에 저장
        self.tasks = data.compactMap{
        guard let title = $0["title"] as? String else {return nil}
        guard let done = $0["done"] as? Bool else {return nil}
        return Task(title: title, done: done)
        }
    }
}



//코드의 가독성을 위해 ViewController를 따로 뺌
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
        //체크마크 생성 @20211218LDH Start
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        //체크마크 생성 @20211218LDH End
        return cell
    }
    
    //Edit 모드에서 '-' 버튼 or 스와이프 하여 할 일 삭제 @20211218LDH start
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    }
    //Edit 모드에서 '-' 버튼 or 스와이프 하여 할 일 삭제 @20211218LDH end
    
    //Edit 모드에서 moveRowAt 사용하여 할 일의 순서의 변경 기능 구현 @20211218LDH start
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
    //Edit 모드에서 moveRowAt 사용하여 할 일의 순서의 변경 기능 구현 @20211218LDH end
}

//체크마크 생성 @20211218LDH Start
extension ViewController : UITableViewDelegate {
    //어떤셀이 선택되었는지 알려주는 셀
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done = !task.done //true -> false, false -> true
        self.tasks[indexPath.row] = task
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
//체크마크 생성 @20211218LDH End

