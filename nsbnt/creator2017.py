#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2017.txt", 'w')

splits = list()
for line in fin:
    line = line.strip().split(' ')
    splittime = line[-2]
    if len(splittime) == 7:
        splits.append('0'+splittime)
    elif len(splittime) == 8:
        splits.append(splittime)
    else:
        raise ValueError
    
fin.close()
splits.sort()
for splt in splits:
    fout.write("%s\n" % splt)
fout.close()
