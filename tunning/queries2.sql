
CREATE  TEMPORARY TABLE stock1 AS
SELECT * FROM stock s;

CREATE  TEMPORARY TABLE warehouse1 AS
SELECT * FROM warehouse w;

SELECT w.w_name
FROM  warehouse1 w NATURAL JOIN stock1 s
WHERE w.w_city='Singapore' AND s.i_id=33;

EXPLAIN ANALYZE SELECT w.w_name
FROM  warehouse1 w NATURAL JOIN stock1 s
WHERE w.w_city='Singapore' AND s.i_id=33;

INSERT INTO warehouse1 SELECT * FROM warehouse;
INSERT INTO warehouse1 SELECT * FROM warehouse;


EXPLAIN ANALYZE SELECT w.w_name
FROM  warehouse1 w NATURAL JOIN stock1 s
WHERE w.w_city='Singapore' AND s.i_id=33;


SELECT s.i_id, s.s_qty
FROM warehouse w JOIN stock s ON w.w_id=s.w_id
WHERE w.w_name='Agimba';

EXPLAIN ANALYZE SELECT s.i_id, s.s_qty
FROM warehouse w JOIN stock s ON w.w_id=s.w_id
WHERE w.w_name='Agimba';

SELECT w.w_name, s.i_id, s.s_qty
FROM warehouse w, stock s
WHERE w.w_id=s.w_id;

EXPLAIN ANALYZE SELECT w.w_name, s.i_id, s.s_qty
FROM warehouse w, stock s
WHERE w.w_id=s.w_id;

CREATE  TEMPORARY TABLE warehouse2 AS
SELECT * FROM warehouse;

VACUUM;

EXPLAIN ANALYZE SELECT w1.w_name
FROM warehouse2 w1, warehouse2 w2 
WHERE w1.w_name=w2.w_name;

SELECT w.w_name, i.i_name, s.s_qty
FROM warehouse w, stock s, item i
WHERE w.w_id=s.w_id AND s.i_id=i.i_id;

SELECT w.w_name, i.i_name, s.s_qty
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i;

SELECT w.w_name, i.i_name, s.s_qty
FROM item i NATURAL JOIN stock s NATURAL JOIN warehouse w;

SELECT * FROM word r1, 
word r2, 
word r3,  
word r4, 
word r5,
word c1, 
word c2, 
word c3,  
word c4, 
word c5
WHERE r1.a1=c1.a1 AND r1.a2=c2.a1 AND r1.a3=c3.a1 AND r1.a4=c4.a1 AND r1.a5=c5.a1
AND r2.a1=c1.a2 AND r2.a2=c2.a2 AND r2.a3=c3.a2 AND r2.a4=c4.a2 AND r2.a5=c5.a2
AND r3.a1=c1.a3 AND r3.a2=c2.a3 AND r3.a3=c3.a3 AND r3.a4=c4.a2 AND r3.a5=c5.a3
AND r4.a1=c1.a4 AND r4.a2=c2.a4 AND r4.a3=c3.a4 AND r4.a4=c4.a4 AND r4.a5=c5.a4
AND r5.a1=c1.a5 AND r5.a2=c2.a5 AND r5.a3=c3.a5 AND r5.a4=c4.a5 AND r5.a5=c5.a5;

EXPLAIN ANALYZE SELECT * FROM word r1, 
word r2, 
word r3,  
word r4, 
word r5,
word c1, 
word c2, 
word c3,  
word c4, 
word c5
WHERE r1.a1=c1.a1 AND r1.a2=c2.a1 AND r1.a3=c3.a1 AND r1.a4=c4.a1 AND r1.a5=c5.a1
AND r2.a1=c1.a2 AND r2.a2=c2.a2 AND r2.a3=c3.a2 AND r2.a4=c4.a2 AND r2.a5=c5.a2
AND r3.a1=c1.a3 AND r3.a2=c2.a3 AND r3.a3=c3.a3 AND r3.a4=c4.a2 AND r3.a5=c5.a3
AND r4.a1=c1.a4 AND r4.a2=c2.a4 AND r4.a3=c3.a4 AND r4.a4=c4.a4 AND r4.a5=c5.a4
AND r5.a1=c1.a5 AND r5.a2=c2.a5 AND r5.a3=c3.a5 AND r5.a4=c4.a5 AND r5.a5=c5.a5;


PREPARE q1 AS
SELECT * FROM word r1, 
word r2, 
word r3,  
word r4, 
word r5,
word c1, 
word c2, 
word c3,  
word c4, 
word c5
WHERE r1.a1=c1.a1 AND r1.a2=c2.a1 AND r1.a3=c3.a1 AND r1.a4=c4.a1 AND r1.a5=c5.a1
AND r2.a1=c1.a2 AND r2.a2=c2.a2 AND r2.a3=c3.a2 AND r2.a4=c4.a2 AND r2.a5=c5.a2
AND r3.a1=c1.a3 AND r3.a2=c2.a3 AND r3.a3=c3.a3 AND r3.a4=c4.a2 AND r3.a5=c5.a3
AND r4.a1=c1.a4 AND r4.a2=c2.a4 AND r4.a3=c3.a4 AND r4.a4=c4.a4 AND r4.a5=c5.a4
AND r5.a1=c1.a5 AND r5.a2=c2.a5 AND r5.a3=c3.a5 AND r5.a4=c4.a5 AND r5.a5=c5.a5;

EXPLAIN ANALYZE EXECUTE q1;

DEALLOCATE q1;

EXPLAIN ANALYZE SELECT * FROM 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a1 FROM word w2)
	AND w1.a2 IN (SELECT a1 FROM word w2)
	AND w1.a3 IN (SELECT a1 FROM word w2)
	AND w1.a4 IN (SELECT a1 FROM word w2)
	AND w1.a5 IN (SELECT a1 FROM word w2)) r1, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a2 FROM word w2)
	AND w1.a2 IN (SELECT a2 FROM word w2)
	AND w1.a3 IN (SELECT a2 FROM word w2)
	AND w1.a4 IN (SELECT a2 FROM word w2)
	AND w1.a5 IN (SELECT a2 FROM word w2)) r2, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a3 FROM word w2)
	AND w1.a2 IN (SELECT a3 FROM word w2)
	AND w1.a3 IN (SELECT a3 FROM word w2)
	AND w1.a4 IN (SELECT a3 FROM word w2)
	AND w1.a5 IN (SELECT a3 FROM word w2)) r3,  
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a4 FROM word w2)
	AND w1.a2 IN (SELECT a4 FROM word w2)
	AND w1.a3 IN (SELECT a4 FROM word w2)
	AND w1.a4 IN (SELECT a4 FROM word w2)
	AND w1.a5 IN (SELECT a4 FROM word w2)) r4, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a1 FROM word w2)
	AND w1.a2 IN (SELECT a5 FROM word w2)
	AND w1.a3 IN (SELECT a5 FROM word w2)
	AND w1.a4 IN (SELECT a5 FROM word w2)
	AND w1.a5 IN (SELECT a5 FROM word w2)) r5,
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a1 FROM word w2)
	AND w1.a2 IN (SELECT a1 FROM word w2)
	AND w1.a3 IN (SELECT a1 FROM word w2)
	AND w1.a4 IN (SELECT a1 FROM word w2)
	AND w1.a5 IN (SELECT a1 FROM word w2)) c1, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a2 FROM word w2)
	AND w1.a2 IN (SELECT a2 FROM word w2)
	AND w1.a3 IN (SELECT a2 FROM word w2)
	AND w1.a4 IN (SELECT a2 FROM word w2)
	AND w1.a5 IN (SELECT a2 FROM word w2)) c2, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a3 FROM word w2)
	AND w1.a2 IN (SELECT a3 FROM word w2)
	AND w1.a3 IN (SELECT a3 FROM word w2)
	AND w1.a4 IN (SELECT a3 FROM word w2)
	AND w1.a5 IN (SELECT a3 FROM word w2)) c3,  
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a4 FROM word w2)
	AND w1.a2 IN (SELECT a4 FROM word w2)
	AND w1.a3 IN (SELECT a4 FROM word w2)
	AND w1.a4 IN (SELECT a4 FROM word w2)
	AND w1.a5 IN (SELECT a4 FROM word w2)) c4, 
(SELECT a1, a2, a3, a4, a5 FROM word w1 
	WHERE w1.a1 IN (SELECT a5 FROM word w2)
	AND w1.a2 IN (SELECT a5 FROM word w2)
	AND w1.a3 IN (SELECT a5 FROM word w2)
	AND w1.a4 IN (SELECT a5 FROM word w2)
	AND w1.a5 IN (SELECT a5 FROM word w2)) c5
WHERE r1.a1=c1.a1 AND r1.a2=c2.a1 AND r1.a3=c3.a1 AND r1.a4=c4.a1 AND r1.a5=c5.a1
AND r2.a1=c1.a2 AND r2.a2=c2.a2 AND r2.a3=c3.a2 AND r2.a4=c4.a2 AND r2.a5=c5.a2
AND r3.a1=c1.a3 AND r3.a2=c2.a3 AND r3.a3=c3.a3 AND r3.a4=c4.a2 AND r3.a5=c5.a3
AND r4.a1=c1.a4 AND r4.a2=c2.a4 AND r4.a3=c3.a4 AND r4.a4=c4.a4 AND r4.a5=c5.a4
AND r5.a1=c1.a5 AND r5.a2=c2.a5 AND r5.a3=c3.a5 AND r5.a4=c4.a5 AND r5.a5=c5.a5;



 CREATE INDEX i1 ON word USING HASH (a1);
 CREATE INDEX i2 ON word USING HASH (a2);
 CREATE INDEX i3 ON word USING HASH (a3);
 CREATE INDEX i4 ON word USING HASH (a4);
 CREATE INDEX i5 ON word USING HASH (a5);

EXPLAIN ANALYZE SELECT * FROM word r1, 
word r2, 
word r3,  
word r4, 
word r5,
word c1, 
word c2, 
word c3,  
word c4, 
word c5
WHERE r1.a1=c1.a1 AND r1.a2=c2.a1 AND r1.a3=c3.a1 AND r1.a4=c4.a1 AND r1.a5=c5.a1
AND r2.a1=c1.a2 AND r2.a2=c2.a2 AND r2.a3=c3.a2 AND r2.a4=c4.a2 AND r2.a5=c5.a2
AND r3.a1=c1.a3 AND r3.a2=c2.a3 AND r3.a3=c3.a3 AND r3.a4=c4.a2 AND r3.a5=c5.a3
AND r4.a1=c1.a4 AND r4.a2=c2.a4 AND r4.a3=c3.a4 AND r4.a4=c4.a4 AND r4.a5=c5.a4
AND r5.a1=c1.a5 AND r5.a2=c2.a5 AND r5.a3=c3.a5 AND r5.a4=c4.a5 AND r5.a5=c5.a5;




EXPLAIN ANALYZE SELECT w.w_name, i.i_name, s.s_qty
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i;


EXPLAIN ANALYZE SELECT w.w_name, i.i_name, s.s_qty
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i
WHERE w.w_name='Agimba';

CREATE TABLE tall AS SELECT *
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i;

EXPLAIN ANALYZE SELECT t.w_name, t.i_name, t.s_qty
FROM tall t;

EXPLAIN ANALYZE SELECT t.w_name, t.i_name, t.s_qty
FROM tall t
WHERE t.w_name='Agimba';

CREATE VIEW vall AS SELECT *
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i;

EXPLAIN ANALYZE SELECT v.w_name, v.i_name, v.s_qty
FROM vall v;

EXPLAIN ANALYZE SELECT v.w_name, v.i_name, v.s_qty
FROM vall v
WHERE v.w_name='Agimba';

CREATE MATERIALIZED VIEW mvall AS SELECT *
FROM warehouse w NATURAL JOIN stock s NATURAL JOIN item i;

EXPLAIN ANALYZE SELECT v.w_name, v.i_name, v.s_qty
FROM mvall v;


SELECT * FROM stock s WHERE s.w_id=2 AND s.i_id=1;

INSERT INTO stock VALUES (2,1,1);

SELECT * FROM stock s WHERE s.w_id=2 AND s.i_id=1;
SELECT * FROM mvall v WHERE v.w_id=2 AND v.i_id=1;

REFRESH MATERIALIZED VIEW mvall;

SELECT * FROM mvall v WHERE v.w_id=2 AND v.i_id=1;

EXPLAIN ANALYZE SELECT * FROM mvall v WHERE v.w_id=2 AND v.i_id=1;

CREATE UNIQUE INDEX i_pkey ON mvall(w_id, i_id);

EXPLAIN ANALYZE SELECT * FROM mvall v WHERE v.w_id=2 AND v.i_id=1;










































