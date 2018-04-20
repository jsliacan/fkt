#! /usr/bin/env python

#import numpy as numpy
import matplotlib.pyplot as plt
import datetime
from matplotlib.dates import date2num, DateFormatter



filenames = list()

for i in range(2,18):
    if i<10:
        filenames.append("res200"+str(i)+".txt")
    else:
        filenames.append("res20"+str(i)+".txt")
        
data = list()
for fname in filenames:
    datai = list()
    fin = open(fname, 'r')
    for line in fin.readlines():
        line = line.strip()
        datai.append(datetime.datetime.strptime(line, "%H:%M:%S"))
    data.append(datai)


# plot
p = plt.plot(data[10])
plt.show(p)
