CREATE VIEW indexinfo AS SELECT 
  t.relname AS table_name,
  ix.relname AS index_name,
  i.indisunique AS is_unique,
  i.indisprimary AS is_primary,
  regexp_replace(pg_get_indexdef(i.indexrelid), '.*\((.*)\)', '\1') column_names
FROM pg_index i, pg_class t,  pg_class ix 
WHERE t.oid = i.indrelid AND ix.oid = i.indexrelid;

SELECT * FROM indexinfo i WHERE i.table_name='warehouse';

SELECT * FROM indexinfo i WHERE i.table_name='item';

SELECT * FROM indexinfo i WHERE i.table_name='stock';

CREATE INDEX i_i_price ON item(i_price);

SELECT * FROM indexinfo i WHERE i.table_name='item';

SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

EXPLAIN SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

EXPLAIN SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore'
ORDER BY w.w_name;

EXPLAIN ANALYZE SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

SELECT w.w_name
FROM warehouse w
WHERE w.w_id='123';

EXPLAIN ANALYZE SELECT w.w_name
FROM warehouse w
WHERE w.w_id='123';

EXPLAIN ANALYZE SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

CREATE INDEX i_w_city ON warehouse(w_city);

SELECT * FROM indexinfo i WHERE i.table_name='warehouse';


EXPLAIN ANALYZE SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';


SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

CLUSTER warehouse USING i_w_city;

SELECT w.w_name
FROM warehouse w
WHERE w.w_city = 'Singapore';

SELECT * 
FROM stock s 
WHERE s.s_qty < 100;

EXPLAIN ANALYZE SELECT * 
FROM stock s 
WHERE s.s_qty < 100;

CREATE INDEX i_s_qty ON stock(s_qty);


EXPLAIN ANALYZE SELECT * 
FROM stock s 
WHERE s.s_qty < 100;

EXPLAIN ANALYZE SELECT * 
FROM stock s 
WHERE s.s_qty >= 100;

EXPLAIN ANALYZE SELECT * 
FROM stock s 
WHERE s.s_qty >= 1000;

CREATE OR REPLACE FUNCTION test(NUMERIC) 
RETURNS SETOF TEXT AS $$
BEGIN
RETURN QUERY EXECUTE 
'EXPLAIN SELECT * 
FROM stock s
WHERE s.s_qty >= ' ||$1 ;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION stat(NUMERIC) 
RETURNS SETOF NUMERIC AS $$
BEGIN
RETURN QUERY EXECUTE 
'SELECT ROUND((COUNT(*)::NUMERIC /(SELECT COUNT(*) 
                                         FROM stock))
                                        *100)
FROM stock s
WHERE s.s_qty >= ' ||$1 ;
END
$$ LANGUAGE plpgsql;

SELECT q.qty, stat(q.qty), 
regexp_replace((SELECT * 
FROM test(q.qty) LIMIT 1),'(\.*)\(.*','\1')
FROM (SELECT DISTINCT ROUND(s_qty::NUMERIC/100)*100 
AS qty FROM stock) AS q
ORDER BY q.qty;