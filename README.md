# Diary
Create 20211226@LDH


![DiaryApp_Design](https://user-images.githubusercontent.com/67154245/148645567-a62b0516-8205-42f7-a185-337887d45e18.jpg)

---

1. 메인 일기 탭
<img width="516" alt="스크린샷 2022-01-08 오후 10 18 57" src="https://user-images.githubusercontent.com/67154245/148645663-f9a1ac9a-71b4-4f9c-8f7d-ddc54e78dc75.png">

2. 즐겨찾기 탭
<img width="516" alt="스크린샷 2022-01-08 오후 10 20 08" src="https://user-images.githubusercontent.com/67154245/148645703-2623505a-f2bd-49b3-8c44-2e98c83c31a0.png">

3. 일기장 상세 화면
<img width="516" alt="스크린샷 2022-01-08 오후 10 21 19" src="https://user-images.githubusercontent.com/67154245/148645738-4d2226d5-e437-495e-b099-49104e639ac2.png">


4. 구현
+ 일기 최신순 나열, 날짜 버튼 클릭 시 키패드가 아닌 DatePicker가 뜨도록 구현(UIDatePicker)
+ NotificationCenter를 사용하여 일기 목록과 즐겨찾기 목록의 diaryList 공유
+ UserDefaults로 앱 재기동 후에도 데이터가 유지되도록 구현
+ init 생성자로 UIView가 스토리보드 생성 시 사각 테두리 구현
+ 옵저버를 사용하여 일기 생성, 수정, 삭제, 즐겨찾기 이벤트 발생 시 메서드 구현
+ UICollectionViewdelegateFlowlayout을 채택하여 CollectionView에 Layout 구현
+ 즐겨찾기에서 항목 선택 시 상세화면으로 이동하여 수정, 삭제, 즐겨찾기 해제가 가능
+ collectionView 속성 설정 중 dataSource 프로토콜 및 필수 메서드(numberOfItemsInSection, cellForItemAt) 구현
+ 제목, 내용, 날짜 중 하나라도 입력되어 있지 않으면 '등록버튼' 비활성화


