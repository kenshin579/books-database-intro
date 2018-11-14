use databaseintro;
/* 3.2.1 기본 검색 */
SELECT
  고객아이디,
  고객이름,
  등급
FROM 고객;

SELECT
  고객아이디,
  고객이름,
  나이,
  등급,
  직업,
  적립금
FROM 고객;

SELECT *
FROM 고객;

SELECT 제조업체
FROM 제품;

SELECT ALL 제조업체
FROM 제품;

SELECT DISTINCT 제조업체
FROM 제품;

SELECT
  제품명,
  단가 AS 가격
FROM 제품;

/* 3.2.2 산술식을 이용한 검색 */
SELECT
  제품명,
  단가 + 500 AS 조정단가
FROM 제품;


/* 3.2.3 조건 검색 */
SELECT
  제품명,
  제고량,
  단가
FROM 제품
WHERE 제조업체 = '한빛제과';

SELECT
  주문제품,
  수량,
  주문일자
FROM 주문
WHERE 주문고객 = 'apple' AND 수량 >= 15;

SELECT
  제품명,
  단가,
  제조업체
FROM 제품
WHERE 단가 >= 2000 AND 단가 <= 3000;

/* 3.2.4 LIKE를 이용한 검색 */
SELECT
  고객이름,
  나이,
  등급,
  적립금
FROM 고객
WHERE 고객이름 LIKE '김%';

SELECT
  고객아이디,
  고객이름,
  등급
FROM 고객
WHERE 고객아이디 LIKE '_____';

/* 3.2.5 NULL을 이용한 검색 */
SELECT 고객이름
FROM 고객
WHERE 나이 IS NULL;

SELECT 고객이름
FROM 고객
WHERE 나이 IS NOT NULL;

/* 3.2.6 정렬 검색 */
SELECT
  고객이름,
  등급,
  나이
FROM 고객
ORDER BY 나이 DESC;

SELECT
  주문고객,
  주문제품,
  수량,
  주문일자
FROM 주문
WHERE 수량 >= 10
ORDER BY 주문제품 ASC, 수량 DESC;

/* 3.2.7 집계 함수를 이용함 검색  */
SELECT AVG(단가)
FROM 제품;

SELECT SUM(재고량) AS '재고량 합계'
FROM 제품
WHERE 제조업체 = '한빛제과';

SELECT COUNT(고객아이디) AS 고객수
FROM 고객;

SELECT COUNT(나이) AS 고객수
FROM 고객;

SELECT COUNT(*) AS 고객수
FROM 고객;

SELECT COUNT(DISTINCT 제조업체) AS '제조업체 수'
FROM 제품;

/* 3.2.8 그룹별 검색 */
SELECT
  주문제품,
  SUM(수량) AS 충주문수량
FROM 주문
GROUP BY 주문제품;

SELECT SUM(수량) AS 총주문수량
FROM 주문
GROUP BY 주문제품;

SELECT
  제조업체,
  COUNT(*) AS 제품수,
  MAX(단가)  AS 최고가
FROM 제품
GROUP BY 제조업체;

SELECT
  제조업체,
  COUNT(*) AS 제품수,
  MAX(단가)  AS 최고가
FROM 제품
GROUP BY 제조업체
HAVING COUNT(*) >= 3;

SELECT
  등급,
  COUNT(*) AS 고객수,
  AVG(적립금) AS 평균적립금
FROM 고객
GROUP BY 등급
HAVING AVG(적립금) >= 1000;

/* 잘못 사용한 예 - */
SELECT
  주문제품,
  주문고객,
  SUM(수량) AS 총주문수량
FROM 주문
GROUP BY 주문제품;

/* 잘 사용한 예 - */
SELECT
  주문제품,
  주문고객,
  SUM(수량) AS 총주문수량
FROM 주문
GROUP BY 주문제품, 주문고객;

/* 3.2.9 여러 테이블에 대한 조인 검색 */
# banana 고객이 주문한 제품의 이름을 검색
SELECT
  주문고객,
  제품명
FROM 주문, 제품
WHERE 주문.주문고객 = 'banana' AND 제품.제품번호 = 주문.주문제품;

# 나이가 30세 이상의 고객이 주문한 제품의 주문제품과 주문일자를 검색함
SELECT
  주문.주문제품,
  주문.주문일자
FROM 고객, 주문
WHERE 고객.나이 >= 30 AND 고객.고객아이디 = 주문.주문고객;

SELECT
  주문제품,
  주문일자
FROM 고객 AS c, 주문 AS o
WHERE c.나이 >= 30 AND c.고객아이디 = o.주문고객;

# 고명석 고객이 주문한 제품의 제품명을 검색해보자
SELECT 제품.제품명
FROM 고객, 제품, 주문
WHERE 고객.고객이름 = '고명석' AND 고객.고객아이디 = 주문.주문고객
      AND 제품.제품번호 = 주문.주문제품;

/* 3.2.10 부속 질의문을 이용한 검색 */
# 달콤비슷켓과 같은 제조업체에서 제조한 제품의 제품명과 단가를 검색해보자
SELECT
  제품명,
  단가
FROM 제품
WHERE 제조업체 = (SELECT 제조업체
              FROM 제품
              WHERE 제품명 = '달콤비스켓');

# 적립금이 가장 많은 고객의 고객이름과 적립금을 검색해보자
SELECT
  고객이름,
  적립금
FROM 고객
WHERE 적립금 = (SELECT MAX(적립금)
             FROM 고객);

# banana 고객이 주문한 제품의 제품명과 제조업체를 검색해보자
SELECT
  제품명,
  제조업체
FROM 제품
WHERE 제품번호 IN (SELECT 주문제품
               FROM 주문
               WHERE 주문고객 = 'banana');

# 결과 같음
SELECT
  제품.제품명,
  제품.제조업체
FROM 제품, 주문
WHERE 제품.제품번호 = 주문.주문제품 AND 주문.주문고객 = 'banana';
# 결과 같음
SELECT
  제품명,
  제조업체
FROM 제품
WHERE EXISTS(SELECT *
             FROM 주문
             WHERE 제품.제품번호 = 주문.주문제품
                   AND 주문.주문고객 = 'banana');

# banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 검색해보자
SELECT
  제품명,
  제조업체
FROM 제품
WHERE 제품번호 NOT IN (SELECT 주문제품
                   FROM 주문
                   WHERE 주문고객 = 'banana');

# 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색해보자
SELECT
  제품명,
  단가,
  제조업체
FROM 제품
WHERE 단가 > ALL (SELECT 단가
                FROM 제품
                WHERE 제조업체 = '대한식품');

# 2013년 3월 15일에 제품을 주문한 고객의 고객이름을 검색해보자
SELECT 고객이름
FROM 고객
WHERE 고객아이디 = (SELECT 주문고객
               FROM 주문
               WHERE 주문일자 = '2013-03-15');

# todo: 이거 잘 아해 안됨
SELECT 고객이름
FROM 고객
WHERE EXISTS(SELECT *
             FROM 주문
             WHERE 주문일자 = '2013-03-15'
                   AND 주문.주문고객 = 고객.고객아이디);

# 2013년 3월 15일에 제품을 주문하지 않은 곡개의 고객이름을 검색해보자
SELECT 고객이름
FROM 고객
WHERE NOT EXISTS(SELECT *
                 FROM 주문
                 WHERE 주문일자 = '2013-03-15'
                       AND 주문.주문고객 = 고객.고객아이디);