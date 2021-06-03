# 동학개미

동학개미란 동학농민운동와 주식용어 개미에서 파생된 이름으로 과거의 종가를 바탕으로 주식 변동을 예측하는 R로 만든 코드입니다.    

주식시장을 예측함으로써 주식의 관심을 가지고 주식시장에 뛰어들고 있는 사람들에게 정보를 제공하여 합리적인 투자를 권장하는 것을 목표로 하고 있습니다. 
    
 
---
## 설치 및 사용방법(Window 기준)

1. [R](https://cran.r-project.org)에 들어가서 Download for R Windows -> base -> Download R 버전정보 for Windows 을 클릭하여 설치합니다.  

2. [RStudio](https://www.rstudio.com/products/rstudio/download/)에 들어가서 RStudio Desktop(Free) Download를 클릭합니다.

3. Capstone 저장소에서 자신의 원격 저장소로 fork합니다.

4. git Bash를 실행 한 뒤 원격 저장소에서 로컬 저장소(Capstone 디렉토리)로 가져옵니다.<br>(git clone https://github.com/깃헙사용자아이디/Capstone.git)

5. RStudio를 실행 뒤 R.R 파일을 연 뒤 아래의 사진처럼 필요한 패키지들을 설치합니다. <br> 
   (lubridate, httr, rvest, xts, data.table, dplyr, prophet) <br>
   ![screensh](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FLL2RW%2Fbtqz5auCGn1%2FOkjDryrdEzOJ1xRjtOheE1%2Fimg.png)
   ![screensh](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FZ6zvw%2Fbtqz5yPBMuy%2FDhpZtrXQrtIwEF4WJMzrS1%2Fimg.png)




6. 아래의 키 값 부분에 원하는 주식의 종목 값을 넣은 후 코드를 전체 지정 후 Run을 클릭해 코드를 실행합니다.  


```c
key = "005930"
count="1000" #카운트 생성 (filter 제거용)#
url = paste0("https://fchart.stock.naver.com/sise.nhn?symbol=", key, "&timeframe=day&count=",count,"&requestType=0")
data = GET(url) %>% read_html %>% html_nodes("item") %>% html_attr("data") %>% strsplit("\\|")
```

## 프로젝트 간 주식 선정기준 
 
### 코스피 200 

- 한국거래소가 시가총액이 크고 거래량이 많아 코스피를 대표할 수 있는 종목 200개를 선정함  

#### 시가총액이 가장 높은 6개 종목 

1. 삼성전자 

2. sk하이닉스

3. LG화학

4. NAVER 

5. 삼성바이오로직스 

6. 카카오 


---

## 관련 이론

### 시계열데이터 


- 시계열 데이터란 시간의 흐름에 따라 관찰된 데이터를 의미합니다. 
- 주식도 시간에 따라 변동하기 때문에 시계열 데이터라고 볼 수 있습니다. 
- 시계열 데이터 분석의 목적은 미래를 예측하는 것입니다.  


### 정상성 시계열과 비정상성 시계열 

- 정상성 시계열은 어떤 시계열자료의 변화 패턴이 평균값을 중심으로 일정한 변동폭을 갖는 시계열로 시간의 추이와 관계없이 평균과 분산이 일정합니다. 

- 비정상성 시계열은 시간의 추이에 따라서 점진적으로 증가하는 추세를 보이거나 분산이 일정하기 않은 특징을 가진 시계열로 대부분의 시계열자료입니다.<br>
 시점에 의존하지 않는 비정상성 시계열의 평균과 분산의 특징으로 인해 일정하지 않기 때문에 각각 차분(difference)과 변환(transformation)을 통해 정상화합니다. 



### 시계열 분석 특징

- y변수 존재: 사건 t를 설명변수(x)로 시계열(Yt)을 반응변수(y)로 사용합니다. (설명변수는 독립변수이고 반응변수는 종속변수) 
              
- 미래 추정: 과거와 현재의 현상을 파악하고 이를 통해서 미래를 추정할 수 있습니다.  
 
- 계절성 자료: 시간 축을 기준으로 계절성이 있는 자료를 데이터 셋으로 이용합니다. 

- 모수 검정: 선형성, 정규성, 등분산성 가정을 만족합니다.

- 추론기능: 유의수준 판단 기준이 존재하는 추론통계 방식 <br>
            추론통계분석은 가설설정-> 유의수준 임계값 정의 -> 측정도구 결정 -> 데이터 수집 -> 데이터분석 -> 최종결과와 같은 절차를 따르며  <br>
            추론 통계의 접근 방식이 모집단을 대표하는 샘플 데이터를 통해 전체를 추정할 수 있습니다.  

### 시계열 분석 모델 Prophet

-  비선형적 회귀 분석을 의미하는 Additive 모델(가법적 모델)이라는 모델링 방법에 기반하여 개량한 분석 모델로 <br>
   선형적이지 않은 시계열 데이터의 트렌드성을(연간/월간/일간) 단위로 쉽게 찾아내도록 해주는 것에 초점이 맞추어져 있습니다. 
   
##### 특징

   Prophet 모델은 트렌드(growth), 계절성(seasonality), 휴일(holidays) 3가지의 주요 구성요소로 이루어져있습니다. 

   ![screensh](https://blog.kakaocdn.net/dn/ckx2T5/btqE0O1Y3KX/BWkezapdPL0QwtQH8TroIk/img.png)
     
- g(t)는 비주기적 변화를 반영하는 추세 함수
- s(t)는 주기적인 변화(주간/연간)
- h(t)는 휴일(불규칙 이벤트)의 영향력
- 오차항 epsilon_t은 모델이 설명하지 못하는 나머지 부분 

##### 이점 

- 다른 시계열 모델과 달리 시간에 종속적인 구조를 가지지 않고 curve-fitting으로 예측 문제를 해결할 수 있습니다. 

- 유연성이 있어 계절적 요소와 트렌드에 대한 가정을 쉽게 반영할 수 있습니다.

- ARIMA 모델과 달리 모델의 측정 간격을 regularly spaced 할 필요가 없고 결측이 있어도 상관이 없습니다.

- 빠른 fitting 속도로 인해 다양한 시도가 가능합니다.

- 직관적인 파라미터 조정을 통한 모델 확장이 쉽습니다.   
  


##### 참고자료
 
  https://facebook.github.io/prophet/

  https://facebook.github.io/prophet/docs/quick_start.html#r-api

  https://m-insideout.tistory.com/m/13

  https://kerpect.tistory.com/161


---

## TO-DO list 

추후 개발이 더 필요한 리스트 목록입니다. 

### UX/ 뷰 디테일 
- [ ] 메인페이지와 상세페이지 템플릿 만들기 
- [ ] 상단 메뉴 적용 
- [ ] 템플릿 이미지 추가하기  
- [ ] 레이아웃 추가하기


### 기능
- [ ] 신화, 전설, 민담 속 장소와 카카오맵 연결하기 
- [ ] PDF 파일 속 내용을 다른 탭으로 넘어가지 않고 볼 수 있게 적용하기 



### 콘텐츠 
- [ ] 신화, 전설, 민담 속 현재 장소 찾기
- [ ] 역사적 인물 추가하기  



---

## License and Copyright
### MIT License

Copyright (c) Facebook, Inc. and its affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Copyright <YEAR> <COPYRIGHT HOLDER>




Copyright [Prophet](https://github.com/facebook/prophet) under the [MIT License](https://opensource.org/licenses/MIT).
