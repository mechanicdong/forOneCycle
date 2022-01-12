# TimerApp
pomodoro 기법을 사용한 Timer App

Bug 
1. 카운트 시작 후 일시정지 후 취소를 누르며 RuntimeError 현상
-> 타이머를 suspend 메서드를 호출해서 일시정지 하게되면 아직 수행해야할 작업이 있음을 의미 
-> suspend된 Timer에 nil을 대입하면 RuntimeError 발생

해결 방법 : 취소하기 전 resume 메서드 호출
