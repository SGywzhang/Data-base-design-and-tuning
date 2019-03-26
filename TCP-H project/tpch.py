##### 
## This section imports the necessary classes and methods from the SQLAlchemy library
####
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

######## IMPORTANT! Change this to your metric number for grading
student_no = 'A0123456Z' 
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
		PARTSUPP,
		CUSTOMER
	where 
		PART.P_PARTKEY = PARTSUPP.PS_PARTKEY and 
		SUPPLIER.S_SUPPKEY = PARTSUPP.PS_SUPPKEY and 
		PARTSUPP.PS_PARTKEY =LINEITEM.L_PARTKEY and
		PARTSUPP.PS_SUPPKEY = LINEITEM.L_SUPPKEY and
		ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY and
		CUSTOMER.C_NAME = 'Customer#000000001';"""

s.execute(query1)

query2 = """select sum (L_EXTENDEDPRICE) as sum_of_extended_price
		from LINEITEM,PART,NATION,REGION,CUSTOMER,ORDERS,PARTSUPP
		where 
			REGION.R_REGIONKEY = NATION.N_REGIONKEY AND 
			NATION.N_REGIONKEY = CUSTOMER.C_NATIONKEY AND 
			CUSTOMER.C_CUSTKEY = ORDERS.O_CUSTKEY AND 
			ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY AND 
			PARTSUPP.PS_PARTKEY= PART.P_PARTKEY AND
			PART.P_PARTKEY = LINEITEM.L_PARTKEY AND 
			LINEITEM.L_SUPPKEY = PARTSUPP.PS_SUPPKEY AND 
			PART.P_BRAND = 'Brand#13'
		group by cube (REGION.R_NAME,NATION.N_NAME,CUSTOMER.C_MKTSEGMENT);"""

s.execute(query2)

query3 = """SELECT *
            FROM FACT_LINEORDER
	    LIMIT 1;"""

s.execute(query3)


query4 = """SELECT *
            FROM FACT_LINEORDER
	    LIMIT 1;"""

s.execute(query4)


s.commit()





