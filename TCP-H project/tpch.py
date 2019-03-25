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
query1 = """SELECT *
            FROM FACT_LINEORDER
	    LIMIT 1;"""

s.execute(query1)

query2 = """SELECT *
            FROM FACT_LINEORDER
	    LIMIT 1;"""

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





