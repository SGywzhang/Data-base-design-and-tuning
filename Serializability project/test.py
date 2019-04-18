#! /usr/bin/python
 
fname1 = 'time.txt'
with open(fname1, 'r+', encoding='utf-8') as f1:  
    lines = f1.readlines() 
    first_line = list(lines[0].split(','))  
    first_line.append(4)
    i=','.join([str(x) for x in first_line])
    f1.seek(0, 0)
    f1.write(i)

f1.close()
    

fname2 = 'correct.txt'
with open(fname2, 'r+', encoding='utf-8') as f2:  
    lines = f2.readlines() 
    first_line = list(lines[0].split(','))  
    first_line.append(4)
    i=','.join([str(x) for x in first_line])
    f2.seek(0, 0)
    f2.write(i)

f2.close()
        
    
