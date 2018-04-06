#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2013.txt", 'w')

splits = list()

for line in fin:
    splittime = line.strip().split(' ')[-2] # extract time from the line
    splittime_parts = splittime.split(':')[:-1]
    splittime_trimmed = ':'.join(splittime_parts)
    splits.append(splittime_trimmed)

fin.close()
splits.sort()
for splt in splits:
    fout.write("%s\n" % splt)
fout.close()
