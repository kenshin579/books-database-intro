-- 조인 (JOIN)
use databasesample;

-- 교차 조인 (CROSS JOIN)

# 명시적 표현법 (explicit notation)
SELECT *
FROM authors
  CROSS JOIN posts;

# 암묵적 표현법 (implicit notation)
SELECT *
FROM authors, posts;

-- 내부 조인 (INNER JOIN)

# 명시적 표현법 (explicit notation)
SELECT *
FROM authors
  INNER JOIN posts
    ON authors.id = posts.author_id;

# 암묵적 표현법 (implicit notation)
SELECT *
FROM authors, posts
WHERE authors.id = posts.author_id;

-- 자연 조인 (NATURAL JOIN)
SELECT *
FROM authors NATURAL JOIN posts;

