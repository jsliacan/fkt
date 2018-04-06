#! /usr/bin/env python2

fin = open("rawinput.txt", 'r')
fout = open("res2007.txt", 'a')

h = 6 # hours that the fastest spent out, will be h:mm:ss, but only have mm:ss from results :(
prevmin = 0

for line in fin:
    split_no_hour = line.strip().split(' ')[-1] # extract time from the line
    split_mins = int(split_no_hour.split(':')[0]) # extract mins from time mm:ss,0
    if prevmin > split_mins: # figure out what the hh was in the time
        h += 1
    prevmin = split_mins
    split_complete = str(h)+":"+split_no_hour # prepend hh (or just h) to the time
    split_complete = split_complete[:-2] # remove ,0 from the end
    fout.write("%s\n" % split_complete)

fin.close()
fout.close()
