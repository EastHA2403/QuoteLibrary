-- DB 생성
CREATE DATABASE QuoteLibDB;
USE QuoteLibDB;

-- 회원 테이블 생성 (Member)
CREATE TABLE member (
    id VARCHAR(20) NOT NULL PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name VARCHAR(30) NOT NULL,
    role VARCHAR(10) DEFAULT 'USER', -- 'USER' or 'ADMIN'
    regist_day VARCHAR(50)
);

-- 명언 테이블 생성 (Quote)
CREATE TABLE quote (
    num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    author VARCHAR(50) NOT NULL,
    category VARCHAR(20) NOT NULL,
    img_file VARCHAR(100),
    regist_day VARCHAR(30),
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING' or 'APPROVED'
    nickname VARCHAR(30)
);

-- 스크랩 테이블 생성 (Scrap)
CREATE TABLE scrap (
    num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_id VARCHAR(20) NOT NULL,
    quote_num INT NOT NULL,
    regist_day VARCHAR(30),
    FOREIGN KEY (member_id) REFERENCES member(id) ON DELETE CASCADE,
    FOREIGN KEY (quote_num) REFERENCES quote(num) ON DELETE CASCADE
);

-- 관리자 계정 생성
INSERT INTO member VALUES('admin', '1234', '관리자', 'ADMIN', '2025-01-01');