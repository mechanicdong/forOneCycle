//
//  CardListViewController.swift
//  CreditCardList
//
//  Created by 이동희 on 2022/01/25.
//

import UIKit
import Kingfisher
import Firebase

class CardViewListController: UITableViewController {
    var ref: DatabaseReference! //Firebase Realtime Database를 가져올 수 있는 reference 값
    
    //전달받은 데이터의 가공형태를 지정
    var creditCardList: [CreditCard] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        self.ref = Database.database().reference()
        
        //Realtime db는 snapshot을 이용해서 data를 불러옴
        self.ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            //JSON Decoding
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted {
                    //1위부터 10위까지 순차 표기
                    $0.rank < $1.rank
                }
                //tableview reload -> UI 움직임 -> Main Thread에서 제공됨 -> 클로저안에서 메인에서 돌도록 지정
                //main thread에 해당 action 넣기
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON parsing \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    //custom cell과 그 cell에 전달된 데이터 지정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() } //없다면 일반적인 UITableViewCell을 반환
        
        //Image를 로컬에 저장하지 않고 URL로 불러오기(Kingfisher Opensource)
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = creditCardList[indexPath.row].name
    
        return cell
    }
    
    //cell의 높이 지정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세화면전달
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else { return }
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        //Option 1 : cardID라는 key value를 가져와서 찾는 방식
        let cardID = creditCardList[indexPath.row].id
        //ref.child("Item\(cardID)/isSelected").setValue(true)
        
        //Option 2 : 특정 key 값이 cardID와 같은 객체를 찾아 스냅샷으로 찍음
        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
            guard let self = self,
                  let value = snapshot.value as? [String: [String: Any]],
                  let key = value.keys.first else { return }
            
            self.ref.child("\(key)/isSelected").setValue(true)
        } //cardID와 같은 객체를 가져오라는 명령
        
    }
}
