#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2015.txt", 'w')

splits = list()
for line in fin:
    line = line.strip()
    if len(line) > 8 and line[2] == ':' and line[5] == ':' and line[8] == ':':
        splittime_parts = line.split(':')[:3]
        splittime_final = ':'.join(splittime_parts)
        splits.append(splittime_final)

fin.close()
splits.sort()
for splt in splits:
    fout.write("%s\n" % splt)
fout.close()
