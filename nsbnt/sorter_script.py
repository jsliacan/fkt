#! /usr/bin/env python2

filename = raw_input("Filename: ")

try:
    f = open(filename, 'r')
except:
    raise IOError("Tried begging, tickling, and a hammer. Still couldn't open that file.\n")

results = list()
for line in f:
    results.append(line.strip())

results.sort()
f.close()


try:
    f = open(filename, 'w')
except:
    raise IOError("Tried begging, tickling, and a hammer. Still couldn't open that file.\n")

for res in results:
    f.write("%s\n" % res)

