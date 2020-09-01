-- 사용자(회원) 정보를 저장할 테이블 
CREATE TABLE login(
	id VARCHAR2(100) PRIMARY KEY,
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100),
	profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
	saveFileName VARCHAR2(200), -- 프로필 이미지 실제 이름을 저장할 칼럼
	regdate DATE
);


CREATE TABLE bbs_cafe (
    num NUMBER PRIMARY KEY, -- 글 번호
    title VARCHAR2(100) NOT NULL, -- 글 제목
    writer VARCHAR2(100) NOT NULL,
    content CLOB, --글 내용
    viewCount NUMBER, -- 조회수
    regdate DATE -- 작성일  
);

CREATE SEQUENCE bbs_cafe_seq;  -- bbs 테이블의 num에서 사용할 시퀀스


-- myrecipe 폴더에서 쓸 table --
CREATE TABLE my_recipe(
	num NUMBER PRIMARY KEY, -- 글 번호
	title VARCHAR2(100) NOT NULL, -- 글 제목
	subTitle VARCHAR2(150), -- 해당 요리에 대한 간략한 설명
	content CLOB NOT NULL, -- 글의 전체 내용
	writer VARCHAR2(50), -- 작성자
	regdate DATE, -- 작성일
	imagePath VARCHAR2(200), -- 대표 이미지 경로
	showImage VARCHAR2(150), -- 대표 이미지 실제 이름
	viewCount NUMBER -- 조회수
);

CREATE SEQUENCE my_recipe_seq;  -- my_recipe 테이블의 num에서 사용할 시퀀스


-- myrecipe 폴더에서 쓸 table --
-- 임시 저장될 tmp_my_recipe 테이블 --
CREATE TABLE tmp_my_recipe(
	tmp_num NUMBER PRIMARY KEY, -- 글 번호
	tmp_title VARCHAR2(100) NOT NULL, -- 글 제목
	tmp_subTitle VARCHAR2(150), -- 해당 요리에 대한 간략한 설명
	tmp_content CLOB NOT NULL, -- 글의 전체 내용
	tmp_writer VARCHAR2(50), -- 작성자
	tmp_regdate DATE, -- 작성일
	tmp_imagePath VARCHAR2(200), -- 대표 이미지 경로
	tmp_showImage VARCHAR2(150), -- 대표 이미지 실제 이름
	tmp_viewCount NUMBER -- 조회수
);

CREATE SEQUENCE tmp_my_recipe_seq;  -- my_recipe 테이블의 num에서 사용할 시퀀스

