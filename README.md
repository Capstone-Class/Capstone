# 동학개미

동학개미란 동학농민운동와 주식용어 개미에서 파생된 이름으로 과거의 종가를 바탕으로 주식 변동을 예측하는 R로 만든 코드입니다.    

주식시장을 예측함으로써 주식의 관심을 가지고 주식시장에 뛰어들고 있는 사람들에게 정보를 제공하여 합리적인 투자를 권장하는 것을 목표로 하고 있습니다. 
    
 
---
## 설치 및 사용방법(Window 기준)

1. [R](https://cran.r-project.org)에 들어가서 Download for R Windows -> base -> Download R 버전정보 for Windows 을 클릭하여 설치합니다.  

2. [RStudio](https://www.rstudio.com/products/rstudio/download/)에 들어가서 

3. Capstone 저장소에서 자신의 원격 저장소로 fork합니다.

4. git Bash를 실행 한 뒤 원격 저장소에서 로컬 저장소(Capstone 디렉토리)로 가져옵니다.<br>(git clone https://github.com/깃헙사용자아이디/Capstone.git)

5. 


   

   

---
## OPEN API
### 카카오 맵 API

```c
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 APP KEY를 넣으시면 됩니다."></script>
```
발급받은 JavaScript 키를 지도 API의 appkey로 사용하였습니다. 

웹페이지 내 지도 기능이 활성화하여 문화 속 장소를 보여줌으로 이용자가 장소에 대한 흥미를 생기도록 합니다.  


### 신화, 전설, 민담 API

제주 문화 원형에 분류되어 있는 신화, 전설, 민담에 대한 이야기를 PDF 형식으로 볼 수 있습니다. 

제주어와 표준어 두 가지 언어로 쓰인 이야기들로 인해 비교하면서 접하게 되면서 자연스럽게 제주어에 대한 흥미를 이끌어 냅니다. 

---
## OPEN SOURCE
### [PDF.js](https://github.com/mozilla/pdf.js)

PDF.js는 PDF 구문 분석 및 렌더링을위한 범용 웹 표준 기반 플랫폼을 만드는 목표를 하는 HTML5로 빌드 된 PDF뷰어 오픈소스입니다. 

오픈소스를 통해 브라우저 내장 PDF 뷰어가 없는 환경에서 사용할 수 있도록 지원하며 이를 통해 신화, 전설, 민담에 대한 PDF 파일을 볼 수 있게 했습니다. 

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
### Apache License 2.0

Copyright [calixteman](https://github.com/calixteman) under the [Apache License 2.0](http://www.apache.org/licenses/).
