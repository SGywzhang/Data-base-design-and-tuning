##### 
## This section imports the necessary classes and methods from the SQLAlchemy library
####
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

######## IMPORTANT! Change this to your metric number for grading
student_no = 'A0194928L' 
#########################

#####
## This section creates an engine for the PostgreSQL
## and creates a database session s.
#####
username = 'postgres'
password = 'postgres'
dbname = 'cs4221'
engine = create_engine('postgres://%s:%s@localhost:5432/%s' % (username, password, dbname))

Session = sessionmaker(bind=engine)
s = Session()

#####
## Query 
#####
query1 =     """select 
		P_NAME,
		S_NAME,
		L_EXTENDEDPRICE,
		O_ORDERKEY,
		O_ORDERDATE
	from 
		PART,
		SUPPLIER,
		LINEITEM,
		ORDERS,
		CUSTOMER
	where 
		PART.P_PARTKEY = LINEITEM.L_PARTKEY and 
		SUPPLIER.S_SUPPKEY = LINEITEM.L_SUPPKEY and 
		ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY and
		ORDERS.O_CUSTKEY = CUSTOMER.C_CUSTKEY and
		CUSTOMER.C_NAME = 'Customer#000000001';"""

s.execute(query1)

query2 = """select sum (L_EXTENDEDPRICE) as sum_of_extended_price
		from LINEITEM,PART,NATION,REGION,CUSTOMER,ORDERS
		where 
			REGION.R_REGIONKEY = NATION.N_REGIONKEY AND 
			NATION.N_NATIONKEY = CUSTOMER.C_NATIONKEY AND 
			CUSTOMER.C_CUSTKEY = ORDERS.O_CUSTKEY AND
			ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY AND
			PART.P_PARTKEY = LINEITEM.L_PARTKEY AND 
			PART.P_BRAND = 'Brand#13'
		group by cube (REGION.R_NAME,NATION.N_NAME,CUSTOMER.C_MKTSEGMENT)
		order by sum_of_extended_price;"""

s.execute(query2)

query3 = """select
	count (*) as total_number_line_orders,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice*(1-l_discount)) as sum_disc_price,
	sum(l_extendedprice*(1-l_discount)*(1+l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty, 
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc
	from lineitem,orders where orders.o_orderkey = lineitem.l_orderkey
	group by rollup (extract(year from orders.o_orderdate),extract(month from orders.o_orderdate))
	order by extract(year from orders.o_orderdate),extract(month from orders.o_orderdate);"""

s.execute(query3)


query4 = """select o_orderpriority, count(*) as order_count 
		from orders where exists 
		(select *from lineitem where l_orderkey = o_orderkey and l_commitdate < l_receiptdate)
		group by o_orderpriority order by o_orderpriority;"""

s.execute(query4)


s.commit()





