import csv
from math import *

r = 6371000 # earth's radius in meters

with open('cellular.csv', 'rb') as f:
    reader = csv.reader(f)
    cellular = list(reader)

with open('wifi.csv', 'rb') as f:
    reader = csv.reader(f)
    wifi = list(reader)

with open('GPS.csv', 'rb') as f:
    reader = csv.reader(f)
    GPS = list(reader)

def hsin(a,b):
	return pow(sin((a - b)/2.0),2)

cellular_dist = 0
for i in xrange(len(cellular) - 1):
	lat1, lon1 = float(cellular[i][1]) * pi / 180.0, float(cellular[i][2]) * pi / 180.0
	lat2, lon2 = float(cellular[i+1][1]) * pi / 180.0, float(cellular[i+1][2]) * pi / 180.0

	cellular_dist += 2*r*asin(sqrt( hsin(lat2, lat1) + cos(lat1) * cos(lat2) * hsin(lon2, lon1) ))

print cellular_dist

wifi_dist = 0
for i in xrange(len(wifi) - 1):
	lat1, lon1 = float(wifi[i][1]) * pi / 180.0, float(wifi[i][2]) * pi / 180.0
	lat2, lon2 = float(wifi[i+1][1]) * pi / 180.0, float(wifi[i+1][2]) * pi / 180.0

	wifi_dist += 2*r*asin(sqrt( hsin(lat2, lat1) + cos(lat1) * cos(lat2) * hsin(lon2, lon1) ))

print wifi_dist

GPS_dist = 0
for i in xrange(len(GPS) - 1):
	lat1, lon1 = float(GPS[i][1]) * pi / 180.0, float(GPS[i][2]) * pi / 180.0
	lat2, lon2 = float(GPS[i+1][1]) * pi / 180.0, float(GPS[i+1][2]) * pi / 180.0

	GPS_dist += 2*r*asin(sqrt( hsin(lat2, lat1) + cos(lat1) * cos(lat2) * hsin(lon2, lon1) ))

print GPS_dist
