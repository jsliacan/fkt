#import numpy as numpy
import matplotlib
import datetime
import csv
import numpy.linalg
from matplotlib.dates import date2num, DateFormatter
from sage.plot.colors import ColorsDict
from sage.plot.line import Line

def dumb_regression(xvals, yvals):
    """
    Return slope and offset. Simple LS for a bunch of points.

    INPUT: Make sure lists are same length. I'm not checking.
    
    """
    
    return numpy.linalg.lstsq(numpy.array([[xvals[j], 1] for j in range(len(xvals))]), numpy.array(yvals))[0]


# get the data from files (into a list of lists)
ep = datetime.datetime(1900,1,1,0,0,0) # beginning of time on my machine

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
    datai.sort()
    data.append(datai)

data_in_seconds = list()
for datai in data:
    datai_s = list()
    for tm in datai:
        datai_s.append((tm-ep).total_seconds())
    data_in_seconds.append(datai_s)
    
# write data to CSV file
with open("results.csv", "wb") as f:
    writer = csv.writer(f)
    writer.writerows(data_in_seconds)


# ====================== OVERALL PLOT ======================


fkt = min(flatten(data))
fktint = int(fkt.time().strftime("%s"))

# plot
plots = list()
clrs = ['black', 'red', 'yellowgreen', 'blue', 'orange', 'grey', 'magenta', 'coral', 'gold', 'darkred', 'darkgreen', 'cyan', 'darkblue', 'olive', 'steelblue', 'saddlebrown']
for i in range(len(data)):
    x = range(len(data[i]))
    
    #y = [int(d.time().strftime("%s"))-fktint for d in data[i]]
    y = [(d-ep).total_seconds() for d in data[i]] # datetime.timedelta(seconds=(d-ep).total_seconds())
    
    yr = str(i+2)
    if len(yr) < 2:
        yr = "0"+yr
    plots.append(list_plot(zip(x,y), color=colors[clrs[i]], plotjoined=True, legend_label="20"+str(yr)))

p = plots[0]
for i in range(1,len(plots)):
    p += plots[i]

p += list_plot(zip(range(250), [(fkt-ep).total_seconds() for x in range(250)]), color='saddlebrown', plotjoined=True, legend_label="FKT", thickness=3)
p.axes_labels(['Finisher [by position]', 'Time [sec]'])
p.legend(show=True)
show(p, title="Plot: Finishing Times", legend_loc="lower right", frame=True)

# ===================== SIZE OF THE FIELD ======================

num_starters_pyear = [len(datai) for datai in data]
fsp = list_plot(zip(range(2002,2002+len(data)), num_starters_pyear), plotjoined=False, size=20, ymin=0) # field size plot
fsp.axes_labels(['Year', 'Number of starters'])
show(fsp, title="Plot: Field size", frame=True)


# ===================== BEST, AVG, MEDIAN, ...  ======================

# prep
winning_time_by_year = [min(datai_insec) for datai_insec in data_in_seconds]
median_time_by_year = [median(datai_insec) for datai_insec in data_in_seconds]
mean_time_by_year = [mean(datai_insec) for datai_insec in data_in_seconds]
stdev_by_year = [std(datai_insec) for datai_insec in data_in_seconds]

# plot
wtp = list_plot(zip(range(2002,2002+len(data)), winning_time_by_year), plotjoined=False, size=20, legend_label="Winner", color="blue") # winning time plot
wtp += list_plot(zip(range(2002,2002+len(data)), median_time_by_year), plotjoined=False, size=20, legend_label="Median", color="orange") # average time plot
wtp += list_plot(zip(range(2002,2002+len(data)), mean_time_by_year), plotjoined=False, size=20, legend_label="Mean", color="red") # average time plot
# manually adding error bars for means
for i in range(len(data)):
    wtp += list_plot([(2002+i, mean_time_by_year[i]-stdev_by_year[i]), (2002+i, mean_time_by_year[i]+stdev_by_year[i])], plotjoined=True, color="red", thickness=0.5)
    wtp += list_plot([(2002+i-0.1, mean_time_by_year[i]-stdev_by_year[i]), (2002+i+0.1, mean_time_by_year[i]-stdev_by_year[i])], plotjoined=True, color="red", thickness=0.5)
    wtp += list_plot([(2002+i-0.1, mean_time_by_year[i]+stdev_by_year[i]), (2002+i+0.1, mean_time_by_year[i]+stdev_by_year[i])], plotjoined=True, color="red", thickness=0.5)
# fit line for the means (simple LS good enough...)
a,b = dumb_regression([2002+i for i in range(len(data))], mean_time_by_year)
var('x')
wtp += plot(a*x+b, (x, 2002, 2002+len(data)), color="red", thickness=1.5)
# fit line for the winning times
a,b = dumb_regression([2002+i for i in range(len(data))], winning_time_by_year)
var('x')
wtp += plot(a*x+b, (x, 2002, 2002+len(data)), color="blue", thickness=1.5)

# final plot
wtp.axes_labels(['Year', 'Time [sec]'])
show(wtp, title="Plot: Winning, mean, and median times", frame=True, legend_loc="center right")


# ===================== AVERAGE TIMES vs. FASTEST TIMES (each year) =======================
"""
# keep it in seconds
data_in_seconds = list()
for datai in data:
    datai_in_seconds = [0 for i in range(len(datai))]
    for ti in range(len(datai)):
        datai_in_seconds[ti] = datai[ti].time().strftime("%s")
    data_in_seconds.append(datai_in_seconds)

"""     
    
