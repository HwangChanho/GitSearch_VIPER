# GitSearch_VIPER

# VIPER Pattern

![VIPER_Pattern.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e8d3aeb7-86ea-4b2e-b49e-411994ee898e/VIPER_Pattern.png)

VIPER는 책임 분리의 원칙(SRP)을 기반으로 한다. 

SRP: 작성된 클래스는 하나의 기능만 가지며 클래스가 제공하는 모든 서비스는 그 하나의 책임(기능)을 수행하는데 집중되어 있어야 한다. (응집도 > 결합도) → 재사용성과, 테스트가 용이

## 역할

### View

View는 ViewController를 의미하며 UI와 관련된 처리만 합니다.

Presenter에 대한 의존성을 가지고 있으며, viewDidLoad 같은 LifesCycle과 button touch 등의 Event에 대한 처리를 Presenter에게 위임하고 Presenter의 요청을 받아 UI를 Update 합니다.

> UI요소들, VIewController 포함.
유저입력 수신.
Presenter에 전달.
Presenter에게 ViewModel 수신하며 update.
Presenter을 소유함.
> 

### Presenter

Presenter는 View, Router, Interactor에 대한 의존성을 가지고 있으며,

View에서 Event를 전달받아 Interactor를 통해 처리하고 View에 data와 함께 UI Update 요청을 보내거나 Router를 통한 화면 이동을 처리합니다.

> View에게 유저 입력을 전달받음.
Interactor에게 데이터 관련 요청 ( 데이터 만들어, 변경해, 나한테 줘. 등 ).
Interactor에게 전달받은 데이터를 ViewModel로 가공하여 View에게 넘겨줌.
Router에게 네비게이션 요청.
Interactor을 소유함.
Router에게 ViewController에 종속적인 명령을 내리기 위해, View를 weak로 소유함.
> 

### Interactor

Business 로직을 담당하며, API 통신 등의 Networking이나 Entity(data)에 대한 처리를 하고 결과를 Presenter에 전달합니다.

> Presenter의 요청대로 생성, 변경.
Presenter에게 데이터를 넘겨줌.
네트워크 통신.
데이터를 소유 ( 일반적인 변수 + Entity 객체들을 말함 )
비지니스 로직. ( "주문서에 담긴 n개의 상품 중 가장 싼 배송비를 최종 배송비로 책정한다." 같은 로직들을 말함.
> 

### Router(WireFrame)

WireFrame 이라고도 불리며 화면 전환과 각 구성요소에 DI(의존성 주입)를 처리합니다.

> Presenter에게 요청받음.
다른 VIPER 모듈간의 전환을 담당. ( 네비게이션 로직 )
새로 만들어지는 VIPER의 모든 구성요소를 생성 및 DI 작업.
Push/Pop, Present/Dismiss
> 

### Entity

속성들을 가지고 있는 Data Model을 의미합니다.

> Interactor에게 소유됨.
네트워크 통신을 위해 만들어지는 Codable struct들.
> 

## 연결 방법

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d1563f30-9640-46c6-8c20-5d949c5db5b9/Untitled.png)

## 언제 VIPER를 사용할까?

![VIPER.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/25efccb3-55bf-420f-951a-a6d3f2fc3fd9/VIPER.png)

## 장점

재사용성, 테스트용이, 기능추가편리등

## 단점

모든 사용자 액션, 모델 업데이트, 라우팅이 presenter를 통하고 presenter는 scene의  모든 구성 요소에 대한 참조를 갖습니다. (= VIPER puts the presenter at the center of the universe.)

따라서 Clean Architecture에 설명된 간단한 단방향 제어 흐름 대신 모든 참조에서 메서드를 호출하기가 매우 쉬워졌고 결과적으로 **massive presenter**로 끝납니다.

참고문서:
