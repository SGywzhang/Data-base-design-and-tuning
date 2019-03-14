############################################################
## Database desing Normalization 
############################################################


from itertools import combinations
from itertools import permutations

## help functions:
def  getListAllCombinations(L):
    result = []
    for i in range(len(L)+1):
      temp = list(combinations(L,i+1))
      result.extend(temp)
    return result

## Determine the closure of set of attribute S given the schema R and functional dependency F
def closure(R,F,S):
    temp = F[:]
    result =  S[:]
    tempResult = S[:]
    while 1:
        for value in temp[:]:
            if set(value[0]).issubset(result):
                temp.remove(value)
                result.extend(value[1])
        result = list(set(result))
        result.sort()
        if tempResult == result:
            break
        tempResult = result[:]
    return result

## Determine the all the attribute closure excluding superkeys that are not candidate keys given the schema R and functional dependency F
def all_closures(R, F):
    result = []
    allElementCombination = getListAllCombinations(R)
    for S in allElementCombination:
        temp1 = [[]]*2
        temp2 = [None]
        singleClosure = closure(R, F, list(S))
        if singleClosure == R:
            Key = False
            subAllElementCombination = getListAllCombinations(list(S))
            for i in subAllElementCombination:
                subSingleClosure = closure(subAllElementCombination, F, list(i))
                if subSingleClosure == R and list(i)!=list(S):
                    Key = True
                    break
            if Key == False:
                temp1[0] = list(S)[:]
                temp1[1] = singleClosure[:]
                temp2[0] = temp1[:]
                result.extend(temp2)
        else:
            temp1[0] = list(S)[:]
            temp1[1] = singleClosure[:]
            temp2[0] = temp1[:]
            result.extend(temp2)

    return result

## Return the candidate keys of a given schema R and functional dependencies F.
def candidate_keys(R, F): 
    result = []
    allElementCombination = getListAllCombinations(R)
    for S in allElementCombination:
        temp = [None]
        singleClosure = closure(R, F, list(S))
        if singleClosure == R:
            Key = False
            subAllElementCombination = getListAllCombinations(list(S))
            for i in subAllElementCombination:
                subSingleClosure = closure(subAllElementCombination, F, list(i))
                if subSingleClosure == R and list(i)!=list(S):
                    Key = True
                    break
            if Key == False:
                temp[0] = list(S)[:]
                result.extend(temp)
    return result

##help functions:
def makeRHSSingleton(FD):
    temp1 = [[]]*2
    temp2 = [None]
    result = []
    for n in FD:
        if len(n[1])>1:
            for i in n[1]:
                temp1[0] = n[0][:] 
                temp1[1] = list(i)[:]
                temp2[0]=temp1[:]
                result.extend(temp2)
        else:
            temp2[0]=n[:]
            result.extend(temp2)
    return result

def makeLHSProcessed (R,FD):
    singleton = makeRHSSingleton(FD)
    for index,value in enumerate(singleton[:]):
        if len(value[0]) > 1:
            for i,v in enumerate(value[0][:]):
                temp = value[0][:]
                temp.remove(v)
                if v != value[1][0] and (value[1][0] in closure(R, FD, temp) or v in closure(R, FD, temp)):
                    value[0].remove(v)
    return  singleton  
 

## Return a minimal cover of the functional dependencies of a given schema R and functional dependencies F.
def min_cover(R, FD): 
    processedFD = makeLHSProcessed(R,FD)    
    for value in processedFD[:]:
        if value[0] == value[1]:
            processedFD.remove(value)

    for index,value in enumerate(processedFD[:]):
        processedFD.remove(value)
        if value[1][0] not in closure(R, processedFD, value[0][:]):
            processedFD.append(value)
    
    processedFD.sort()

    return processedFD

## Return all minimal covers reachable from the functional dependencies of a given schema R and functional dependencies F.
def min_covers(R, FD):
    minCovers = []
    tempCover = [None]
    processedFD = makeLHSProcessed(R,FD)
    for value in processedFD[:]:
        if value[0] == value[1]:
            processedFD.remove(value)
    
    FDSet = [] 
    for v in processedFD: 
        if not v in FDSet: 
            FDSet.append(v) 

    for n in list(permutations(FDSet,len(FDSet))):
        temp = list(n)
        for index,value in enumerate(temp[:]):
            temp.remove(value)
            if value[1][0] not in closure(R, temp, value[0][:]):
                temp.append(value)
        temp.sort()
        tempCover[0] = temp
        if temp not in minCovers:
            minCovers.extend(tempCover)

    return minCovers 

## Return all minimal covers of a given schema R and functional dependencies F.
def all_min_covers(R, FD):
    return min_covers(R,all_closures(R,FD))

### Test case from the project
R = ['A', 'B', 'C', 'D']
FD = [[['A', 'B'], ['C']], [['C'], ['D']]]

print closure(R, FD, ['A'])
print closure(R, FD, ['A', 'B'])
print all_closures(R, FD)
print candidate_keys(R, FD)

R = ['A', 'B', 'C', 'D', 'E', 'F']
FD = [[['A'], ['B', 'C']],[['B'], ['C','D']], [['D'], ['B']],[['A','B','E'], ['F']]]
print min_cover(R, FD)

R = ['A', 'B', 'C']
FD = [[['A', 'B'], ['C']],[['A'], ['B']], [['B'], ['A']]] 
print min_covers(R, FD)
print all_min_covers(R, FD)
R = ['A', 'B', 'C', 'D', 'E']
FD = [[['A', 'B'],['C']], [['D'],['D', 'B']], [['B'],['E']], [['E'],['D']], [['A', 'B', 'D'],['A', 'B', 'C', 'D']]]
print candidate_keys(R, FD)
print min_cover(R, FD)
print min_covers(R, FD)
print all_min_covers(R, FD) 

