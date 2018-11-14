use databaseintro;
/* 4.2 뷰의 생성 */
CREATE VIEW 우수고객(고객아이디, 고객이름, 나이)
  AS
    SELECT
      고객아이디,
      고객이름,
      나이
    FROM 고객
    WHERE 등급 = 'vip'
WITH CHECK OPTION;

# 같음
CREATE VIEW 우수고객
  AS
    SELECT
      고객아이디,
      고객이름,
      나이
    FROM 고객
    WHERE 등급 = 'vip'
WITH CHECK OPTION;

# 제조업체별 제품수로 구성된 뷰를 업체별제품수라는 이름으로 생성해보자.
CREATE VIEW 업체별제품수(제조업체, 제품수)
  AS SELECT
      제조업체,
      COUNT(*)
    FROM 제품
    GROUP BY 제조업체;

/* 4.3 뷰의 활용 */
CREATE VIEW 제품1
  AS SELECT 제품번호, 재고량, 제조업체
  FROM 제품
  WITH CHECK OPTION;

SELECT * FROM 제품1;

CREATE VIEW 제품2
  AS SELECT 제품명, 재고량, 제조업체
  FROM 제품
  WITH CHECK OPTION;

SELECT * FROM 제품2;

# 제품 테이블에 실제로 삽입됨
INSERT INTO 제품1 VALUES ('p08', 1000, '신선식품');

# 아래는 실행이 안됨 - 뷰에 기본키가 없어서
INSERT INTO 제품2 VALUES ('시원냉면', 1000, '신선식품');

/* 4.4 뷰의 삭제 */
# 우수고객 뷰를 이용하는 다른 뷰가 존재하면 삭제가 수행되지 않도록 한다
DROP VIEW 우수고객 RESTRICT;