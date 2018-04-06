#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2015.txt", 'w')

splits = list()

for line in fin:
    splittime = line.strip().split(' ')[-2] # extract time from the line
    splits.append(splittime)

fin.close()
splits.sort()
for splt in splits:
    fout.write("%s\n" % splt)
fout.close()
