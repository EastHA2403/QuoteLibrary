-- 기존 데이터베이스가 있다면 삭제하고 새로 생성 (초기화용)
DROP DATABASE IF EXISTS QuoteLibDB;
CREATE DATABASE QuoteLibDB;
USE QuoteLibDB;

-- 1. 회원 테이블 생성 (Member)
DROP TABLE IF EXISTS member;
CREATE TABLE member (
    id VARCHAR(20) NOT NULL PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(30) NOT NULL,
    role VARCHAR(10) DEFAULT 'USER', -- 'USER' or 'ADMIN'
    regist_day VARCHAR(50)
);

-- 2. 명언 테이블 생성 (Quote) - [수정됨] 영어 컬럼 추가
DROP TABLE IF EXISTS quote;
CREATE TABLE quote (
    num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,           -- 한글 명언 (기본)
    content_en TEXT,                 -- [추가] 영어 명언 (번역)
    author VARCHAR(50) NOT NULL,     -- 한글 저자명 (기본)
    author_en VARCHAR(50),           -- [추가] 영어 저자명 (번역)
    category VARCHAR(20) NOT NULL,
    img_file VARCHAR(100),
    regist_day VARCHAR(30),
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING' or 'APPROVED'
    nickname VARCHAR(30)
);

-- 3. 스크랩 테이블 생성 (Scrap)
DROP TABLE IF EXISTS scrap;
CREATE TABLE scrap (
    num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_id VARCHAR(20) NOT NULL,
    quote_num INT NOT NULL,
    regist_day VARCHAR(30),
    -- 외래키 연결
    FOREIGN KEY (member_id) REFERENCES member(id) ON DELETE CASCADE,
    FOREIGN KEY (quote_num) REFERENCES quote(num) ON DELETE CASCADE
);

-- 4. 관리자 계정 생성 (초기 데이터)
INSERT INTO member VALUES('admin', '1234', '관리자', 'ADMIN', '2025-01-01');