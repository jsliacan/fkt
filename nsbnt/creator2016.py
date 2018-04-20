#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2016.txt", 'w')

splits = list()
for line in fin:
    line = line.strip().split(' ')
    splittime = line[-1]
    if len(splittime) < 8:
        splits.append('0'+splittime)
    else:
        splits.append(splittime)

fin.close()
splits.sort()
for splt in splits:
    fout.write("%s\n" % splt)
fout.close()
