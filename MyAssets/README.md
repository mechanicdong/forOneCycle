# MyAssets


<img width="300" alt="MyAsset" src="https://user-images.githubusercontent.com/67154245/157443608-b45aba8b-e176-4e3d-a170-4a238fa99ee4.png">
<img width="300" alt="MyAsset2" src="https://user-images.githubusercontent.com/67154245/157443710-e94d49ed-04bb-45e1-9afd-6818651e2b35.png">
<img width="300" alt="MyAsset3" src="https://user-images.githubusercontent.com/67154245/157443753-ba360cac-b5f9-4d16-abca-70c2e96822f2.png">
Card Section에서는 tabs로 update가 발생할 경우 빨간색 점으로 알림 표현



# SwiftUI Framework을 사용한 MyAssets(내 자산) 프로젝트


SwiftUI는 UIKit을 감싼 형태이며 storyboard를 사용했을 땐 명령형 언어지만 SwiftUI는 선언형이다



### UIHostingController
#### UIKit에서 SwiftUI 사용 시


---> UIHostingController는 UIViewController를 상속받고 있음

#### SwiftUI에서 UIKit에 접근할 때와 같이 반대 상황에서는?


UIViewControllerRepresentable protocol을 사용하며 필수 메서드를 구현해야 함!

참고 사이트 : 


https://zeddios.tistory.com/763


https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit


#### ObservableObject protocol used in AssetSummaryData class 


---> decoding된 (assets) data 내보내기(@Published, class에서만 사용가능)
