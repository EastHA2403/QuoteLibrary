📚 QuoteLibrary (명언 도서관)
- QuoteLibrary는 사용자들이 명언을 공유하고 스크랩할 수 있는 JSP 기반의 웹 애플리케이션입니다. 다국어 처리(i18n), 관리자 승인 시스템, 파일 업로드 기능을 포함하고 있습니다.
<br>
🛠 개발 환경 (Tech Stack)
- Language: Java 11 (or 17), JSP, Servlet

- Server: Apache Tomcat 10.1 (Jakarta EE 지원 버전)

- Database: MySQL 8.0

- Frontend: HTML5, CSS3, Bootstrap 5.3

- Library: JSTL 2.0, COS.jar (File Upload), MySQL Connector J
<br>

⚙️ 실행 방법 (Installation & Run)
- 1. 데이터베이스 설정 (MySQL)
MySQL에 접속하여 QuoteLibDB 데이터베이스를 생성하고, 테이블을 생성한 뒤 초기 데이터 값들을 입력합니다. (src/main/webapp/resources) 폴더의 CreateTabel.sql을 실행한 뒤 InsertQuote.sql 파일을 실행하면 됩니다.

- 2. DB 연결 설정 변경
admin_approval_process, admin_approval.jsp, login_process.jsp, quote_add_process.jsp, quote_list.jsp, quote_random.jsp, scrap_delete.jsp, scrap_list, scrap_process.jsp, signup_process.jsp 파일들 내부의 DB 연결 정보를 본인의 환경에 맞게 수정해야 합니다. 
  <img width="1083" height="88" alt="image" src="https://github.com/user-attachments/assets/28982487-dc59-443e-ae01-29f67c0144b8" />
