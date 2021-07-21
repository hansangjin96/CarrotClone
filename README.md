# CarrotClone

# 구현 영상

<center><img src="https://github.com/hansangjin96/CarrotClone/blob/main/%EC%98%81%EC%83%81/%ED%99%94%EB%A9%B4-%EA%B8%B0%EB%A1%9D-2021-07-22-%EC%98%A4%EC%A0%84-2.03.11.gif" width="40%" height="40%"></center>

# 아키텍쳐

- 클린아키텍쳐 구조로 Presentation Layer, Business Layer, DataLayer 구분

# 구현 기간

- 2021년 7월 20일 9pm ~ 2021년 7월 22일 3am

# 구현 사항

- Home화면 구현

### 세부 사항

1. HomeVC가 보여지면 Reactor에 뷰가 보여졌다고 알려줌
2. Reactor에서는 CarrotService에 fakeAPI 요청
3. CarrotService에서는 어떤 endpoint를 타서 어떤 Model로 Decode를 해야하는지 판단 후 NetworkRepository에 raw한 Entity Model 요청
4. CarrotService에서 NetworkRepository에서 받아온 Entity를 실제 뷰모델에서 사용할 모델로 변경
5. CarrotService에서 받아온 Model을 Reactor가 ViewController에 뿌려줌
6. ViewController에서는 받은 데이터를 테이블 뷰와 셀에 바인딩
7. 셀에서는 받은 모델의 url을 가지고 ImageService를 통해 이미지 다운로드
8. ImageService는 cache를 확인 후 이미지 다운로드 처리
9. NetworkRepository Test Code 

# 디펜던시 - SPM 사용

- RxSwift, RxCocoa: 비동기 처리를 위해 사용
- Quick, Nimble: 테스트를 위해 사용
- SnapKit, Then: 코드로 UI를 그림에 있어 사용성 추가
- ReactorKit: 단방향 반응형 구조 작성
