# PublicWifiService
스프링 프레임워크로 넘어가기전 기존 자바와 웹 그리고 데이터베이스를 사용한 프로젝트
---
# 개발 환경
- Language : Java
- Build : Maven
- Database : SQLITE
- Server : Tomcat 8.5
- JDK : JDK 1.8
- Web : CSS, HTML5, JSP
---
# 사용 라이브러리
- httpClient 처리를 위한 okhttp3
- json 처리를 위한 gson
- getter/setter 처리를 위한 lombok
- sqlite 연결을 위한 sqlite-jdbc
---
# ERD
![ServletJSP](https://github.com/newideaa/PublicWifiService/assets/33719601/d097a2df-dc0c-4264-a487-85c60c9b7bac)
---
# 주요 기능
- OPEN API를 활용해 서울시의 공공 와이파이 정보를 제공
- 사용자의 위치를 기반으로 주변에 있는 공공 와이파이 정보 제공(20개)
- 특정 공공 와이파이의 상세 정보 제공
- 북마크 그룹을 생성하여, 특정 와이파이를 북마크에 추가할 수 있음
- 사용자가 사용한 History 조회 가능
