DROP TABLE TB_MEMBER CASCADE CONSTRAINTS;
DROP TABLE TB_EXERCISE CASCADE CONSTRAINTS;
DROP TABLE TB_EXERCISE_RECORD CASCADE CONSTRAINTS;
DROP TABLE TB_ROUTINE CASCADE CONSTRAINTS;
DROP TABLE TB_PT CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT CASCADE CONSTRAINTS;
DROP TABLE TB_ROUTINE_EXERCISE CASCADE CONSTRAINTS;
DROP TABLE TB_TRAINER CASCADE CONSTRAINTS;
DROP TABLE TB_BLACKLIST CASCADE CONSTRAINTS;
DROP TABLE TB_REVIEW CASCADE CONSTRAINTS;
DROP TABLE TB_PAYMENT CASCADE CONSTRAINTS;
DROP TABLE TB_LETTER CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_BACKUP CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_REPORT CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT_REPORT CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT_BACKUP CASCADE CONSTRAINTS;
DROP TABLE TB_PT_FILE CASCADE CONSTRAINTS;
DROP TABLE TB_REPORT_BACKUP CASCADE CONSTRAINTS;
DROP TABLE TB_PT_CALENDAR CASCADE CONSTRAINTS;
DROP TABLE TB_VISIT CASCADE CONSTRAINTS;
DROP TABLE TB_EMAIL_CERTIFICATION CASCADE CONSTRAINTS;
DROP TABLE TB_PT_FAVORITE CASCADE CONSTRAINTS;
DROP TABLE TB_MEMBER_BACKUP CASCADE CONSTRAINTS;
DROP TABLE TB_INQUIRY CASCADE CONSTRAINTS;
DROP TABLE TB_ROUTINE_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_NOTICE CASCADE CONSTRAINTS;
DROP TABLE TB_ROUTINE_BOARD_BACKUP CASCADE CONSTRAINTS;
DROP TABLE TB_BOARD_CATEGORY CASCADE CONSTRAINTS;

CREATE TABLE TB_MEMBER (
	MEMBER_NO	NUMBER		NOT NULL,
	MEMBER_ID	VARCHAR2(20)		NOT NULL,
	MEMBER_PASSWORD	VARCHAR2(20)		NOT NULL,
	MEMBER_NICKNAME	VARCHAR2(20)		NOT NULL,
	MEMBER_EMAIL	VARCHAR2(100)		NOT NULL,
	MEMBER_NAME	VARCHAR2(20)		NOT NULL,
	MEMBER_PHONE	VARCHAR2(13)		NOT NULL,
	MEMBER_GENDER	CHAR(1)		NOT NULL,
	MEMBER_AGE	NUMBER		NOT NULL,
	MEMBER_HEIGHT	NUMBER		NOT NULL,
	MEMBER_WEIGHT	NUMBER		NOT NULL,
	MEMBER_PURPOSE	NUMBER		NOT NULL,
	MEMBER_CONCERN	NUMBER		NOT NULL,
	MEMBER_PHOTO	VARCHAR2(100)		NULL,
	MEMBER_TRAINER	VARCHAR2(1)	DEFAULT 'F'	NOT NULL,
	MEMBER_ABSENCE	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	MEMBER_JOIN_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	MEMBER_LEAVE_DATE	DATE		NULL
);

ALTER TABLE TB_MEMBER ADD CONSTRAINT UK_MEMBER_ID UNIQUE(MEMBER_ID);
ALTER TABLE TB_MEMBER ADD CONSTRAINT UK_MEMBER_NICKNAME UNIQUE(MEMBER_NICKNAME);
ALTER TABLE TB_MEMBER ADD CONSTRAINT UK_MEMBER_EMAIL UNIQUE(MEMBER_EMAIL);

COMMENT ON COLUMN TB_MEMBER.MEMBER_GENDER IS 'M: 남자, F: 여자, N: 선택 안 함';

COMMENT ON COLUMN TB_MEMBER.MEMBER_HEIGHT IS '단위: cm';

COMMENT ON COLUMN TB_MEMBER.MEMBER_WEIGHT IS '단위: kg';

COMMENT ON COLUMN TB_MEMBER.MEMBER_PURPOSE IS '선택안함, 감량, 증량, 체력관리, 바디프로필, 기타';

COMMENT ON COLUMN TB_MEMBER.MEMBER_CONCERN IS '선택안함, 웨이트트레이닝, 필라테스, 요가, 기타';

COMMENT ON COLUMN TB_MEMBER.MEMBER_TRAINER IS 'T: 트레이너 F: 일반회원 R: from 트레이너 to 일반 회원 전환중';

COMMENT ON COLUMN TB_MEMBER.MEMBER_ABSENCE IS 'N: 탈퇴 안 함, Y:탈퇴함';

CREATE TABLE TB_BOARD_CATEGORY (
    BOARD_CATEGORY_NO NUMBER(1) NOT NULL
);

CREATE TABLE TB_EXERCISE (
	EXERCISE_NO	NUMBER		NOT NULL,
	EXERCISE_NAME	VARCHAR2(100)		NOT NULL,
	EXERCISE_PART	CHAR(1)		NOT NULL
);

COMMENT ON COLUMN TB_EXERCISE.EXERCISE_PART IS 'B:등,C:가슴,L:하체,S:어깨,A:복근,E:팔,H:엉덩이,T:유산소,F:전신';


CREATE TABLE TB_EXERCISE_RECORD (
	RECORD_NO	NUMBER		NOT NULL,
	RECORD_START	DATE	DEFAULT SYSDATE	NOT NULL,
	RECORD_STOP	DATE	DEFAULT SYSDATE	NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	ROUTINE_EXERCISE_NO	NUMBER		NOT NULL
);


CREATE TABLE TB_ROUTINE (
	ROUTINE_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	ROUTINE_NAME	VARCHAR2(200)		NOT NULL,
	ROUTINE_DISABLE	CHAR(1)	DEFAULT 'F'	NOT NULL,
	ROUTINE_TARGET	CHAR(1)	DEFAULT 'N'	NOT NULL,
	ROUTINE_CONTENT	VARCHAR2(1000)		NOT NULL,
	ROUTINE_EXPLANATION	VARCHAR2(1000)		NULL
);

COMMENT ON COLUMN TB_ROUTINE.ROUTINE_NAME IS '루틴이름';

COMMENT ON COLUMN TB_ROUTINE.ROUTINE_DISABLE IS 'T: 사용불가 리스트에 표시안됨
F: 사용가능 리스트에 표시됨';

COMMENT ON COLUMN TB_ROUTINE.ROUTINE_TARGET IS 'N:전체,M:근비대,D:다이어트,S:스트랭스,B:맨몸운동';


CREATE TABLE TB_PT (
	PT_NO	NUMBER		NOT NULL,
	TRAINER_NO	NUMBER		NOT NULL,
	PT_NAME	VARCHAR2(100)		NOT NULL,
	PT_CATEGORY	NUMBER		NOT NULL,
	PT_PRICE	NUMBER		NOT NULL,
	PT_INTRODUCE	VARCHAR2(3000)		NOT NULL,
	PT_INFORMATION	VARCHAR2(3000)		NOT NULL,
	PT_TARGET_STUDENT	VARCHAR2(600)		NOT NULL,
	PT_NOTICE	VARCHAR2(600)		NOT NULL,
    PT_TRAINER_INFO	VARCHAR2(600)		NOT NULL,
    PT_TIME_INFO    VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN TB_PT.PT_CATEGORY IS '1웨이트, 2:채중감량,3:재활';

COMMENT ON COLUMN TB_PT.PT_PRICE IS '단위 원';


CREATE TABLE TB_BOARD (
	BOARD_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	BOARD_TITLE	VARCHAR2(200)		NOT NULL,
	BOARD_CONTENT	VARCHAR2(1000)		NOT NULL,
	BOARD_COUNT	NUMBER	DEFAULT 0	NOT NULL,
	BOARD_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
    BOARD_CATEGORY_NO NUMBER(1) DEFAULT 1 NOT NULL
);


CREATE TABLE TB_COMMENT (
	COMMENT_NO	NUMBER		NOT NULL,
	BOARD_NO	NUMBER		NULL,
	ROUTINE_BOARD_NO	NUMBER		NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	COMMENT_CONTENT	VARCHAR2(300)		NOT NULL,
	COMMENT_DATE	DATE	DEFAULT sysdate	NOT NULL,
	COMMENT_EDIT_DATE	DATE		NULL
);


CREATE TABLE TB_ROUTINE_EXERCISE (
	ROUTINE_EXERCISE_NO	NUMBER		NOT NULL,
	EXERCISE_NO	NUMBER		NOT NULL,
	ROUTINE_NO	NUMBER		NOT NULL,
	ROUTINE_EXERCISE_DAY	NUMBER		NULL,
	ROUTINE_WEEK	NUMBER		NULL,
	ROUTINE_DAY	NUMBER		NULL,
	ROUTINE_EXERCISE_SET	NUMBER		NULL,
	ROUTINE_EXERCISE_REPEAT	NUMBER		NULL,
	ROUTINE_EXERCISE_WEIGHT	NUMBER		NULL,
	ROUTINE_EXERCISE_TIME	NUMBER		NULL,
	ROUTINE_EXERCISE_DISTANCE	NUMBER		NULL,
	ROUTINE_EXERCISE_PERFORM_DAY	DATE		NULL,
	ROUTINE_EXERCISE_D_DAY	DATE		NULL,
	ROUTINE_EXERCISE_SEQUENCE	NUMBER		NULL,
	ROUTINE_EXERCISE_COPY	CHAR(1)	DEFAULT 'T'	NOT NULL
);

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_NO IS '기본키랑 겹침?';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_DAY IS '1: 월 2: 화 3: 수 4: 목 5: 금 6: 토 7: 일';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_SET IS '근력운동일때 입력';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_REPEAT IS '근력운동일때 입력';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_WEIGHT IS '근력운동일때 입력
단위:kg';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_TIME IS '유산소 운동중 시간으로 운동량이 결정되는 경우 단위: 분';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_DISTANCE IS '유산소 운동중 거리로 운동량이 결정되는 경우 단위: m';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_PERFORM_DAY IS '운동기록 테이블을 참조하면 알수 있지않나?';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_D_DAY IS '운동기록 테이블을 참조하면 알 수 잇지않나?';

COMMENT ON COLUMN TB_ROUTINE_EXERCISE.ROUTINE_EXERCISE_COPY IS 'T: 복사본 상세페이지 공개 안함F: 상세피이지에 공개함';



CREATE TABLE TB_TRAINER (
	TRAINER_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	TRAINER_FILE	VARCHAR2(100)		NOT NULL,
	TRAINER_CONFIRM	VARCHAR(1)	DEFAULT 'R'	NOT NULL,
	GYM_NAME	VARCHAR2(255)		NOT NULL,
	GYM_LOCATION	VARCHAR2(255)		NOT NULL,
	TRAINER_ETR	DATE		NULL
);

COMMENT ON COLUMN TB_TRAINER.TRAINER_FILE IS 'URL';

COMMENT ON COLUMN TB_TRAINER.TRAINER_CONFIRM IS 'T 인증 완료, F 인증 실패,  R 관리자 확인 중';


CREATE TABLE TB_BLACKLIST (
	BLACK_LIST_NO	NUMBER		NOT NULL,
	TRAINER_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	BLACKLIST_DATE	DATE	DEFAULT SYSDATE	NOT NULL
);


CREATE TABLE TB_REVIEW (
	REVIEW_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	PT_NO	NUMBER		NOT NULL,
	REVIEW_CONTENT	VARCHAR2(300)		NOT NULL
);


CREATE TABLE TB_PAYMENT (
	PAYMENT_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	PAYMENT_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	PAYMENT_PRICE	NUMBER		NOT NULL,
	PT_CALENDAR_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN TB_PAYMENT.PAYMENT_PRICE IS '단위: 원';


CREATE TABLE TB_LETTER (
	LETTER_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	LETTER_TITILE	VARCHAR2(100)		NOT NULL,
	LETTER_CONTENT	VARCHAR2(1000)		NOT NULL,
	LETTER_SEND_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	LETTER_READ	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	LETTER_READ_TIME	TIMESTAMP		NULL
);

COMMENT ON COLUMN TB_LETTER.LETTER_READ IS 'Y: 읽음
N: 안읽음';


CREATE TABLE TB_BOARD_BACKUP (
	BOARD_BACKUP_NO	NUMBER		NOT NULL,
	BOARD_BACKUP_WRITER	NUMBER		NOT NULL,
	BOARD_BACKUP_TITLE	VARCHAR2(200)		NOT NULL,
	BOARD_BACKUP_CONTENT	VARCHAR2(1000)		NOT NULL,
	BOARD_BACKUP_COUNT	NUMBER		NOT NULL,
	BOARD_BACKUP_DATE	DATE		NOT NULL
);

COMMENT ON COLUMN TB_BOARD_BACKUP.BOARD_BACKUP_NO IS 'TB_BOARD BOARD_NO값이 입력됨';


CREATE TABLE TB_BOARD_REPORT (
	BOARD_REPORT_NO	NUMBER		NOT NULL,
	BOARD_REPORT_CONTENT	VARCHAR2(300)		NOT NULL,
	BOARD_REPORT_TIME	TIMESTAMP DEFAULT SYSTIMESTAMP	NOT NULL,
    MEMBER_NO	NUMBER		NOT NULL,
	BOARD_NO	NUMBER		NULL,
    ROUTINE_BOARD_NO NUMBER NULL
);


CREATE TABLE TB_COMMENT_REPORT (
	COMMENT_REPORT_NO	NUMBER		NOT NULL,
	COMMENT_REPORT_CONTENT	VARCHAR2(300)		NOT NULL,
	COMMENT_REPORT_TIME	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	COMMENT_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL
);


CREATE TABLE TB_COMMENT_BACKUP (
	COMMNET_BACKUP_NO	NUMBER		NOT NULL,
	BOARD_NO	NUMBER		NOT NULL,
	COMMENT_BACKUP_WRITIER	NUMBER		NOT NULL,
	COMMNET_BACKUP_CONTENT	VARCHAR2(300)		NOT NULL,
	COMMENT_BACKUP_DATE	DATE		NULL,
	COMMENT_BACKUP_EDIT_DATE	DATE		NULL
);

COMMENT ON COLUMN TB_COMMENT_BACKUP.COMMNET_BACKUP_NO IS 'TB_RECOMMNET RECOMMNET_NO값이 입력됨';


CREATE TABLE TB_PT_FILE (
	PT_FILE_NO	NUMBER		NOT NULL,
	PT_NO	NUMBER		NOT NULL,
	PT_FILE	VARCHAR2(100)		NOT NULL
);


CREATE TABLE TB_REPORT_BACKUP (
	REPORT_BACKUP_NO	NUMBER		NOT NULL,
	REPORT_BACKUP_REPORTER	NUMBER		NOT NULL,
	REPORT_BACKUP_CONTENT	VARCHAR2(300)		NOT NULL,
	REPORT_BACKUP_TIME	TIMESTAMP		NOT NULL,
	BOARD_BACKUP_NO	NUMBER		NOT NULL,
	COMMNET_BACKUP_NO	NUMBER		NOT NULL,
	ROUTINE_BOARD_BACKUP_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN TB_REPORT_BACKUP.BOARD_BACKUP_NO IS 'TB_BOARD BOARD_NO값이 입력됨';

COMMENT ON COLUMN TB_REPORT_BACKUP.COMMNET_BACKUP_NO IS 'TB_COMMNET RECOMMNET_NO값이 입력됨';

COMMENT ON COLUMN TB_REPORT_BACKUP.ROUTINE_BOARD_BACKUP_NO IS 'TB_BOARD BOARD_NO값이 입력됨';



CREATE TABLE TB_PT_CALENDAR (
	PT_CALENDAR_NO	NUMBER		NOT NULL,
	PT_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	PT_CALENDAR_START_TIME	TIMESTAMP		NOT NULL,
	PT_CALENDAR_RESERVATION_STATE	CHAR(1)	DEFAULT 'F'	NOT NULL
);

COMMENT ON COLUMN TB_PT_CALENDAR.PT_CALENDAR_RESERVATION_STATE IS 'T: 예약됨 F: 예약안됨';


CREATE TABLE TB_VISIT (
	VISIT_NO	NUMBER		NOT NULL,
	VISIT_IP	VARCHAR2(15)		NOT NULL,
	VISIT_TIME	TIMESTAMP		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL
);

COMMENT ON COLUMN TB_VISIT.VISIT_IP IS 'FORMAT: 000.000.000.000';


CREATE TABLE TB_EMAIL_CERTIFICATION (
	EMAIL_CERTIFICATION_NO	NUMBER		NOT NULL,
	EMAIL_CERTIFICATION_EMAIL	VARCHAR2(100)		NOT NULL,
	EMAIL_CERTIFICATION_CODE	VARCHAR2(6)		NOT NULL
);


CREATE TABLE TB_PT_FAVORITE (
	FAVORITE_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	PT_NO	NUMBER		NOT NULL
);


CREATE TABLE TB_MEMBER_BACKUP (
	MEMBER_NO	NUMBER		NOT NULL,
	MEMBER_ID	VARCHAR2(20)		NOT NULL,
	MEMBER_PASSWORD	VARCHAR2(20)		NOT NULL,
	MEMBER_NICKNAME	VARCHAR2(20)		NOT NULL,
	MEMBER_EMAIL	VARCHAR2(100)		NOT NULL,
	MEMBER_NAME	VARCHAR2(20)		NOT NULL,
	MEMBER_PHONE	VARCHAR2(13)		NOT NULL,
	MEMBER_GENDER	CHAR(1)		NULL,
	MEMBER_AGE	NUMBER		NOT NULL,
	MEMBER_HEIGHT	NUMBER		NULL,
	MEMBER_WEIGHT	NUMBER		NULL,
	MEMBER_PURPOSE	NUMBER		NOT NULL,
	MEMBER_CONCERN	NUMBER		NOT NULL,
	MEMBER_PHOTO	VARCHAR2(100)		NULL,
	MEMBER_TRAINER	VARCHAR2(1)	DEFAULT 'F'	NOT NULL,
	MEMBER_ABSENCE	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	MEMBER_JOIN_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	MEMBER_LEAVE_DATE	DATE		NULL
);

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_GENDER IS 'M: 남자
F: 여자';

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_HEIGHT IS '단위: cm';

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_WEIGHT IS '단위: kg';

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_PURPOSE IS '선택안함, 감량, 증량, 체력관리, 바디프로필, 기타';

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_CONCERN IS '선택안함, 웨이트트레이닝, 필라테스, 요가, 기타';

COMMENT ON COLUMN TB_MEMBER_BACKUP.MEMBER_TRAINER IS 'T: 트레이너 F: 일반회원 R: from 트레이너 to 일반 회원 전환중';


CREATE TABLE TB_INQUIRY (
	INQUIRY_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	INQUIRY_TITLE	VARCHAR2(200)		NOT NULL,
	INQUIRY_CONTENT	VARCHAR2(1000)		NOT NULL,
	INQUIRY_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	INQUIRY_CHECK	CHAR(1)	DEFAULT 'F'	NOT NULL, 
    INQUIRY_ANSER VARCHAR2(1000) NULL
);

COMMENT ON COLUMN TB_INQUIRY.INQUIRY_DATE IS 'DEFAULT: SYSDATE';

COMMENT ON COLUMN TB_INQUIRY.INQUIRY_CHECK IS 'DEFAULT: F
T: 확인함
F: 확인안함';


CREATE TABLE TB_ROUTINE_BOARD (
	ROUTINE_BOARD_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	ROUTINE_NO	NUMBER		NOT NULL,
	ROUTINE_BOARD_TITLE	VARCHAR2(200)		NOT NULL,
	ROUTINE_BOARD_CONTENT	VARCHAR2(1000)		NOT NULL,
	ROUTINE_BOARD_COUNT	NUMBER	DEFAULT 0	NOT NULL,
	ROUTINE_BOARD_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	ROUTINE_BOARD_SHARE	NUMBER	DEFAULT 0	NOT NULL,
    BOARD_CATEGORY_NO NUMBER(1) DEFAULT 2 NOT NULL
);


CREATE TABLE TB_NOTICE (
	NOTICE_NO	NUMBER		NOT NULL,
	MEMBER_NO	NUMBER		NOT NULL,
	NOTICE_TITLE	VARCHAR2(200)		NOT NULL,
	NOTICE_CONTENT	VARCHAR2(1000)		NOT NULL,
	NOTICE_COUNT	NUMBER	DEFAULT 0	NOT NULL,
	NOTICE_DATE	DATE	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN TB_NOTICE.MEMBER_NO IS '관리자만 작성가능';


CREATE TABLE TB_ROUTINE_BOARD_BACKUP (
	ROUTINE_BOARD_BACKUP_NO	NUMBER		NOT NULL,
	ROUTINE_BOARD_BACKUP_WRITER	NUMBER		NOT NULL,
	ROUTINE_BOARD_BACKUP_TITLE	VARCHAR2(200)		NOT NULL,
	ROUTINE_BOARD_BACKUP_CONTENT	VARCHAR2(1000)		NOT NULL,
	ROUTINE_BOARD_BACKUP_COUNT	NUMBER		NOT NULL,
	ROUTINE_BOARD_BACKUP_DATE	DATE		NOT NULL,
	ROUTINE_NO	NUMBER		NULL
);

COMMENT ON COLUMN TB_ROUTINE_BOARD_BACKUP.ROUTINE_BOARD_BACKUP_NO IS 'TB_BOARD BOARD_NO값이 입력됨';

ALTER TABLE TB_MEMBER ADD CONSTRAINT PK_TB_MEMBER PRIMARY KEY (
	MEMBER_NO
);

ALTER TABLE TB_EXERCISE ADD CONSTRAINT PK_TB_EXERCISE PRIMARY KEY (
	EXERCISE_NO
);

ALTER TABLE TB_BOARD_CATEGORY ADD CONSTRAINT PK_TB_BAORD_CATEGORY PRIMARY KEY (
    BOARD_CATEGORY_NO
);

ALTER TABLE TB_EXERCISE_RECORD ADD CONSTRAINT PK_TB_EXERCISE_RECORD PRIMARY KEY (
	RECORD_NO
);

ALTER TABLE TB_ROUTINE ADD CONSTRAINT PK_TB_ROUTINE PRIMARY KEY (
	ROUTINE_NO
);

ALTER TABLE TB_PT ADD CONSTRAINT PK_TB_PT PRIMARY KEY (
	PT_NO
);

ALTER TABLE TB_BOARD ADD CONSTRAINT PK_TB_BOARD PRIMARY KEY (
	BOARD_NO
);

ALTER TABLE TB_COMMENT ADD CONSTRAINT PK_TB_COMMENT PRIMARY KEY (
	COMMENT_NO
);

ALTER TABLE TB_ROUTINE_EXERCISE ADD CONSTRAINT PK_TB_ROUTINE_EXERCISE PRIMARY KEY (
	ROUTINE_EXERCISE_NO
);

ALTER TABLE TB_TRAINER ADD CONSTRAINT PK_TB_TRAINER PRIMARY KEY (
	TRAINER_NO
);

ALTER TABLE TB_BLACKLIST ADD CONSTRAINT PK_TB_BLACKLIST PRIMARY KEY (
	BLACK_LIST_NO
);

ALTER TABLE TB_REVIEW ADD CONSTRAINT PK_TB_REVIEW PRIMARY KEY (
	REVIEW_NO
);

ALTER TABLE TB_PAYMENT ADD CONSTRAINT PK_TB_PAYMENT PRIMARY KEY (
	PAYMENT_NO
);

ALTER TABLE TB_LETTER ADD CONSTRAINT PK_TB_LETTER PRIMARY KEY (
	LETTER_NO
);

ALTER TABLE TB_BOARD_BACKUP ADD CONSTRAINT PK_TB_BOARD_BACKUP PRIMARY KEY (
	BOARD_BACKUP_NO
);

ALTER TABLE TB_BOARD_REPORT ADD CONSTRAINT PK_TB_BOARD_REPORT PRIMARY KEY (
	BOARD_REPORT_NO
);

ALTER TABLE TB_COMMENT_REPORT ADD CONSTRAINT PK_TB_COMMENT_REPORT PRIMARY KEY (
	COMMENT_REPORT_NO
);

ALTER TABLE TB_COMMENT_BACKUP ADD CONSTRAINT PK_TB_COMMENT_BACKUP PRIMARY KEY (
	COMMNET_BACKUP_NO
);

ALTER TABLE TB_PT_FILE ADD CONSTRAINT PK_TB_PT_FILE PRIMARY KEY (
	PT_FILE_NO
);

ALTER TABLE TB_REPORT_BACKUP ADD CONSTRAINT PK_TB_REPORT_BACKUP PRIMARY KEY (
	REPORT_BACKUP_NO
);

ALTER TABLE TB_PT_CALENDAR ADD CONSTRAINT PK_TB_PT_CALENDAR PRIMARY KEY (
	PT_CALENDAR_NO
);

ALTER TABLE TB_VISIT ADD CONSTRAINT PK_TB_VISIT PRIMARY KEY (
	VISIT_NO
);

ALTER TABLE TB_EMAIL_CERTIFICATION ADD CONSTRAINT PK_TB_EMAIL_CERTIFICATION PRIMARY KEY (
	EMAIL_CERTIFICATION_NO
);

ALTER TABLE TB_PT_FAVORITE ADD CONSTRAINT PK_TB_PT_FAVORITE PRIMARY KEY (
	FAVORITE_NO
);

ALTER TABLE TB_MEMBER_BACKUP ADD CONSTRAINT PK_TB_MEMBER_BACKUP PRIMARY KEY (
	MEMBER_NO
);

ALTER TABLE TB_INQUIRY ADD CONSTRAINT PK_TB_INQUIRY PRIMARY KEY (
	INQUIRY_NO
);

ALTER TABLE TB_ROUTINE_BOARD ADD CONSTRAINT PK_TB_ROUTINE_BOARD PRIMARY KEY (
	ROUTINE_BOARD_NO
);

ALTER TABLE TB_NOTICE ADD CONSTRAINT PK_TB_NOTICE PRIMARY KEY (
	NOTICE_NO
);

ALTER TABLE TB_ROUTINE_BOARD_BACKUP ADD CONSTRAINT PK_TB_ROUTINE_BOARD_BACKUP PRIMARY KEY (
	ROUTINE_BOARD_BACKUP_NO
);

ALTER TABLE TB_EXERCISE_RECORD ADD CONSTRAINT FK_MEMBER_TO_EXERCISE_RECORD FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_EXERCISE_RECORD ADD CONSTRAINT FK_ROUTINE_EXERCISE_TO_RECORD FOREIGN KEY (
	ROUTINE_EXERCISE_NO
)
REFERENCES TB_ROUTINE_EXERCISE (
	ROUTINE_EXERCISE_NO
);

ALTER TABLE TB_ROUTINE ADD CONSTRAINT FK_TB_MEMBER_TO_TB_ROUTINE_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_PT ADD CONSTRAINT FK_TB_TRAINER_TO_TB_PT_1 FOREIGN KEY (
	TRAINER_NO
)
REFERENCES TB_TRAINER (
	TRAINER_NO
);

ALTER TABLE TB_BOARD ADD CONSTRAINT FK_TB_MEMBER_TO_TB_BOARD_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_BOARD ADD CONSTRAINT FK_TB_CATEGORY_TO_TB_BOARD FOREIGN KEY (
	BOARD_CATEGORY_NO
)
REFERENCES TB_BOARD_CATEGORY (
	BOARD_CATEGORY_NO
);

ALTER TABLE TB_COMMENT ADD CONSTRAINT FK_TB_BOARD_TO_TB_COMMENT_1 FOREIGN KEY (
	BOARD_NO
)
REFERENCES TB_BOARD (
	BOARD_NO
) ON DELETE CASCADE;

ALTER TABLE TB_COMMENT ADD CONSTRAINT FK_ROUTINE_BOARD_TO_COMMENT FOREIGN KEY (
	ROUTINE_BOARD_NO
)
REFERENCES TB_ROUTINE_BOARD (
	ROUTINE_BOARD_NO
);

ALTER TABLE TB_COMMENT ADD CONSTRAINT FK_TB_MEMBER_TO_TB_COMMENT_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_ROUTINE_EXERCISE ADD CONSTRAINT FK_EXERCISE_ROUTINE_EXERCISE FOREIGN KEY (
	EXERCISE_NO
)
REFERENCES TB_EXERCISE (
	EXERCISE_NO
);

ALTER TABLE TB_ROUTINE_EXERCISE ADD CONSTRAINT FK_ROUTINE_TO_ROUTINE_EXERCISE FOREIGN KEY (
	ROUTINE_NO
)
REFERENCES TB_ROUTINE (
	ROUTINE_NO
);

ALTER TABLE TB_TRAINER ADD CONSTRAINT FK_TB_MEMBER_TO_TB_TRAINER_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_BLACKLIST ADD CONSTRAINT FK_TRAINER_TO_BLACKLIST FOREIGN KEY (
	TRAINER_NO
)
REFERENCES TB_TRAINER (
	TRAINER_NO
);

ALTER TABLE TB_BLACKLIST ADD CONSTRAINT FK_TB_MEMBER_TO_TB_BLACKLIST_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_REVIEW ADD CONSTRAINT FK_TB_MEMBER_TO_TB_REVIEW_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_REVIEW ADD CONSTRAINT FK_TB_PT_TO_TB_REVIEW_1 FOREIGN KEY (
	PT_NO
)
REFERENCES TB_PT (
	PT_NO
);

ALTER TABLE TB_PAYMENT ADD CONSTRAINT FK_TB_MEMBER_TO_TB_PAYMENT_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_PAYMENT ADD CONSTRAINT FK_PT_CALENDAR_TO_TRADE FOREIGN KEY (
	PT_CALENDAR_NO
)
REFERENCES TB_PT_CALENDAR (
	PT_CALENDAR_NO
);

ALTER TABLE TB_LETTER ADD CONSTRAINT FK_TB_MEMBER_TO_TB_LETTER_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_BOARD_REPORT ADD CONSTRAINT FK_BOARD_TO_TB_BOARD_REPORT FOREIGN KEY (
	BOARD_NO
)
REFERENCES TB_BOARD (
	BOARD_NO
) ON DELETE CASCADE;

ALTER TABLE TB_BOARD_REPORT ADD CONSTRAINT FK_MEMBER_TO_BOARD_REPORT FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_COMMENT_REPORT ADD CONSTRAINT FK_COMMENT_TO_COMMENT_REPORT FOREIGN KEY (
	COMMENT_NO
)
REFERENCES TB_COMMENT (
	COMMENT_NO
) ON DELETE CASCADE;

ALTER TABLE TB_COMMENT_REPORT ADD CONSTRAINT FK_MEMBER_TO_COMMENT_REPORT FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_PT_FILE ADD CONSTRAINT FK_TB_PT_TO_TB_PT_FILE_1 FOREIGN KEY (
	PT_NO
)
REFERENCES TB_PT (
	PT_NO
);

ALTER TABLE TB_REPORT_BACKUP ADD CONSTRAINT FK_BOARD_TO_REPORT FOREIGN KEY (
	BOARD_BACKUP_NO
)
REFERENCES TB_BOARD_BACKUP (
	BOARD_BACKUP_NO
);

ALTER TABLE TB_REPORT_BACKUP ADD CONSTRAINT FK_COMMENT_TO_REPORT FOREIGN KEY (
	COMMNET_BACKUP_NO
)
REFERENCES TB_COMMENT_BACKUP (
	COMMNET_BACKUP_NO
);

ALTER TABLE TB_REPORT_BACKUP ADD CONSTRAINT FK_ROUTINE_BOARD_TO_REPORT FOREIGN KEY (
	ROUTINE_BOARD_BACKUP_NO
)
REFERENCES TB_ROUTINE_BOARD_BACKUP (
	ROUTINE_BOARD_BACKUP_NO
);

ALTER TABLE TB_PT_CALENDAR ADD CONSTRAINT FK_TB_PT_TO_TB_PT_CALENDAR_1 FOREIGN KEY (
	PT_NO
)
REFERENCES TB_PT (
	PT_NO
);

ALTER TABLE TB_PT_CALENDAR ADD CONSTRAINT FK_MEMBER_TO_CALENDAR FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_VISIT ADD CONSTRAINT FK_TB_MEMBER_TO_TB_VISIT_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_PT_FAVORITE ADD CONSTRAINT FK_MEMBER_TO_FAVORITE FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_PT_FAVORITE ADD CONSTRAINT FK_TB_PT_TO_TB_PT_FAVORITE_1 FOREIGN KEY (
	PT_NO
)
REFERENCES TB_PT (
	PT_NO
);

ALTER TABLE TB_INQUIRY ADD CONSTRAINT FK_TB_MEMBER_TO_TB_INQUIRY_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_ROUTINE_BOARD ADD CONSTRAINT FK_MEMBER_TO_ROUTINE_BOARD FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

ALTER TABLE TB_ROUTINE_BOARD ADD CONSTRAINT FK_CATEGORY_TO_ROUTINE_BOARD FOREIGN KEY (
	BOARD_CATEGORY_NO
)
REFERENCES TB_BOARD_CATEGORY (
	BOARD_CATEGORY_NO
);

ALTER TABLE TB_ROUTINE_BOARD ADD CONSTRAINT FK_ROUTINE_TO_ROUTINE_BOARD FOREIGN KEY (
	ROUTINE_NO
)
REFERENCES TB_ROUTINE (
	ROUTINE_NO
);

ALTER TABLE TB_NOTICE ADD CONSTRAINT FK_TB_MEMBER_TO_TB_NOTICE_1 FOREIGN KEY (
	MEMBER_NO
)
REFERENCES TB_MEMBER (
	MEMBER_NO
);

