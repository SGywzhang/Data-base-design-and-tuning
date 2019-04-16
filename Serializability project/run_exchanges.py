import argparse
from sqlalchemy.orm import sessionmaker
import time
from db_connect import get_conn
from sqlalchemy import *
import random


## Argument parser to take the parameters from the command line
parser = argparse.ArgumentParser()
parser.add_argument('E', type = int, help = 'number of exchanges')
parser.add_argument('I', help = 'isolation level')
args = parser.parse_args()


def balance_swap(sess):
    random1 = 0
    random2 = 0    

    while random1 == random2:
	    random1 = random.randint(1,100000)
	    random2 = random.randint(1,100000)

    balance1 = sess.execute("SELECT balance FROM account where id =:param1",{"param1":random1}).scalar()
    balance2 = sess.execute("SELECT balance FROM account where id =:param2",{"param2":random2}).scalar()
    
    sess.execute("UPDATE account SET balance =:param3 WHERE id = :param4",{"param3":balance2,"param4":random1})
    sess.execute("UPDATE account SET balance =:param5 WHERE id = :param6",{"param5":balance1,"param6":random2})

    return


def E_swaps(sess, E):
    start = time.time()
    for i in xrange(0, E):
	    try:
		balance_swap(sess)
		time.sleep(0.0001)
	    except Exception as e:
		continue
    stop = time.time()

    return stop-start

## Create the engine and run the sums
engine = get_conn()
Session = sessionmaker(bind=engine.execution_options(isolation_level=args.I, autocommit=True))
sess = Session()
swaps = E_swaps(sess, args.E)
print swaps

