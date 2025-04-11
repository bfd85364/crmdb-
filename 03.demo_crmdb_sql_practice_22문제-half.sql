describe customer;
describe orders;
describe product;

# 1. 고객 고객아이디, 고객이름, 등급을 조회하시오.
 select cust_id, cust_name, grade from customer;
# 2. 제조업체 이름을 중복없이 조회하시오.
SELECT DISTINCT manufacturer FROM product;
# 3. 제품의 단가와 제품의 단가(unit price)에 500원을 더한 가격을 별도의 컬럼('adjusted_price')으로 조회하시오.
SELECT unit_price, unit_price+500 AS 'adjusted_price' FROM product;
# 4. 제조업체가 '한빛제과'인 제품명, 재고량, 단가를 조회하시오.
SELECT * FROM product WHERE manufacturer LIKE '한빛제과';

# 5. 주문고객이 'apple' 이고  제품수량이 15개 이상인 주문제품, 수량, 주문일자을 조회하시오.
select * from orders where cust_id like 'apple' and quantity >=15;
# 6. 제품단가가 2000원 이상 3000원 이하인 제품명, 단가, 제조업체를 조회하시오.
select * from product where unit_price between 2000 and 3000;

# 7. 고객이름이 '김'으로 시작하는 고객의 고객이름, 나이, 등급, 멤버쉽포인트를 조회하시오.
select * from  customer where cust_name LIKE '%김%';
select * from customer where cust_name Like '%김';

# 8. 고객 나이가 null인 고객이름을 조회하시오.
select cust_name , age from customer where age is null;

# 9. 고객 나이 기준 내림차순으로 고객이름, 등급, 나이를 조회하시오.
select cust_name, grade, age from customer order by age desc;

# 10. 제품 수량이 10개 이상인 주문건에 대하여 주문제품 기준으로 오름차순 정렬하고, 주문제품이 같다면 수량기준 내림차순 정렬하여 주문고객, 주문제품, 수량, 주문일자를 조회하시오.
SELECT * FROM orders WHERE quantity >= 10 ORDER BY product_id asc, quantity desc;

# 11. 제품 단가의 평균값을 구하시오. 

SELECT AVG(unit_price) FROM product;

# 12. 제조업체 '한빛제과'인 제품들의 재고량 합계를 구하시오

SELECT sum(inventory) FROM product where manufacturer LIKE '한빛제과';  

# 13. 총 고객 수를 *를 이용하여 구하시오.
-- 총 고객 수를 age 컬럼을 이용하여 구하시오.
-- 위 두 쿼리의 결과가 동일한가? 아니면 그 이유는 무엇인가?

select count(*) from customer; # 튜플의 갯수를 카운트 하는 목적 

select count(age) from customer; 

# 14.  제품의 제조업체의 수를 구하시오.
SELECT count(distinct manufacturer) from product; 

# 15. 주문제품별로 총주문수량을 구하시오.
select product_id, sum(quantity) from orders group by product_id;

# 16. 제조업체별로 제품수와 최고단가를 구하시오.
select manufacturer, count(*), max(unit_price) from product group by manufacturer; 

# 17.  제조업체별로 제품수, 최고단가를 구하시오 (단 제품수가 3개 이상인 제조업체에 한해서).
select manufacturer, count(*), max(unit_price) from product group by manufacturer 
Having count(*)>=3;

# 18.  고객등급별 고객수와 평균 멤버쉽포인트 구하시오 (단 평균 멤버쉽 포인트가 1000점 이상인 고객등급에 대해서).
select count(*), AVG(membership_points) as avg from customer group by grade having avg(membership_points) >=1000;

# 19.  주문제품 및 주문고객별 총주문수량을 구하시오.
select product_id, count(*), sum(quantity) from orders group by product_id, quantity ORDER BY product_id, quantity; 

#아마 두번째게 맞는듯 

SELECT product_id, cust_id, count(*)order_id FROM orders GROUP BY product_id, cust_id;  

-- 응용문제
# 20.  주문년도별 총주문수량을 구하시오. 

SELECT EXTRACT(Year FROM order_date) AS ORDER_YEAR, sum(quantity) FROM orders GROUP BY ORDER_YEAR;

# 21. 주문년월별, 제품별 총주문 수량을 구하시오.

SELECT EXTRACT(YEAR_MONTH FROM order_date) as ORDER_YM, sum(quantity) FROM orders GROUP BY ORDER_YM, product_id;

#22. 배송주소지의 가장큰행정구역(예 서울시 마포구 -> 서울시)별 총 주문 건수와 총 주문수량을 주문수량이 많은 순서대로 조회하시오.

SELECT SUBSTRING_INDEX(delivery_addr, ' ', 1) as addr2,
count(*) as cnt, sum(quantity) as sum from orders group by addr2 order by sum desc;
