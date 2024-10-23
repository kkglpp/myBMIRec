# 이 프로젝트는...  

- Flutter/dart 를 사용하여 개발하였습니다.
    
- 상태관리로는 GetX 라이브러리를 선택하였고, Sqlite 를 사용하였습니다.

- MVVM 패턴을 지향하고자 하였습니다.

---   
---  
### 시연 영상 링크 
[![Watch the video](https://img.youtube.com/vi/B-EZPtX22Cg/0.jpg)](https://youtu.be/B-EZPtX22Cg)

---  
---  
# 프로젝트 개요 
## IOS app store 등록완료 


#### 키/몸무게 를 입력하면, BMI 수치를 계산.
#### 이 내용을 날짜 별로 저장하여, 추후에 이 기록들을 보며 다이어트 등에 활용.

#### 수치들만을 저장하는 것은 생각보다 의미가 없을 수 있기에

#### 사진을 저장하여, 실제 시각적인 차이를 기록할 수 있도록 함.

#### Flutter 아키텍쳐 및 패키지들 시험 연습을 겸하는 application. 

---
## Ver 1 -> github.com/kkglpp/MyBMIRecord

---

## 1. 코드 개선 위한 필요 작업
- 나중에 봐도 좀 더 읽기쉽고 이해하기 쉽게 주석 깔끔하게 달아둘 것.
- MVVM 역할 구분의 일관성을 갖출 것.
#### View에서 Controller의 함수 실행해서 data 최신화 -> Model Func 의 함수 실행해서 필요 data 가져옴 -> 필요시 dataHandler의 함수 실행해서 db에서 데이터 꺼내옴.
#### Model dataHandler : db에서 데이터 꺼내오기
#### Model Func : Biz Function
##### 1. db에서 데이터 꺼내오기 위해 필요한 매개변수 전달.
##### 2. 성공여부에 다른 return 값 전달
##### 3. db에서 가져올 필요 없는 데이터들의 최신화
#### ViewModel Controller : View에 필요한 data의 관찰 및 갱신. data 변화의 시작과 끝만 담당

- 그래프 구현한 class 들을 패키지화 시켜볼 것. 
- 세부적인 디자인 요소들 가꾸어 볼것. done
- Screen util 패키지 사용해 볼 것.  done
- MVI 패턴으로변경 고려해 볼 것. -> 결국 데이터의 일방향성이 주요 특징인데...음...

## 2. V. 2.0.2 준비 할 것.  4월중 완료 목표
- alert 디자인 개선
- 목록페이지에서 삭제 기능
- 목록 페이지에서 grid card 요소들의 배경없애고, 자체 card들에 그림자 및 테두리로 >
디자인 개선할 것. done
- 안드로이드 play스토어에 등록할것 (4월 첫주 목표)

## 3. V. 3.0.0 준비 할 것. 목표 : 24년 7월 전 목표.
#### - app 이름 바꾸기  ( 현재 고려중: My Training Partner)
#### - 목표 추가기능
 ##### 다양한 방식의 초시계 기능
 ##### 운동별 목표 입력기능
 ##### 운동별 성취 수준 입력기능
 ##### 운동별 성취 및 변화 입력 기능 등등
