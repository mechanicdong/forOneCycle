# forOneCycle
## iOS study

## Kakao Map API 사용시 에러

arm64 아키텍처 Xcode 시뮬레이터 미지원으로 아이폰 무선연결 디버깅 진행

error - Showing Recent Messages Undefined symbol: __swift_FORCE_LOAD_$_XCTestSwiftSupport 

Build Phases - Link Binary with Libraries에 XCTest~Framework 추가

참고 https://rldd.tistory.com/297
