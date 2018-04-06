#! /usr/bin/env python2

filename = raw_input("Filename: ")
f = open(filename, 'r')

times = list()

for line in f:
    l = line.strip()
    newl = l[1:]
    times.append(newl)

f.close()

fout = open(filename, 'w')

for t in times:
    fout.write("%s\n" % t)
fout.close()
