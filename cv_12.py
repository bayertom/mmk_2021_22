from numpy import *
from pyproj import *

def loadPoints(file_text):
    #Load points
    uv = []
    with open(file_text, 'r') as file:
        for line in file:
            ut, vt = line.strip().split()
            u, v = float(ut), float(vt)
            uv.append([u, v])
    return array(uv)

def samplePoints(umin, umax, vmin, vmax, Du, Dv):
    #Sample grid points
    uv = []
    with open("points.txt", "w") as file:
        for u in range(umin,umax,Du):
            for v in range(vmin,vmax,Dv):
                uv.append([v, u])
    return array(uv)

def sampleMeridians(umin, umax, vmin, vmax, Dv, du):
    #Sample meridians
    uv = []
    for v in arange(vmin, vmax, Dv):
        for u in arange(umin, umax, du):
            uv.append([v, u])
    return array(uv)

def sampleParallels(umin, umax, vmin, vmax, Du, dv):
    #Sample parallels
    uv = []
    for u in arange(umin, umax, Du):
        for v in arange(vmin, vmax, dv):
            uv.append([v, u])
    return array(uv)

def writePoints(file_text, u, v, x, y, a = [], b = []):
    #Write points to file
    with open (file_text, "w") as file:
        for i in range(len(u)):
            #Create line
            line = str(u[i]) + '\t' + str(v[i]) + '\t' + str(x[i]) + '\t' + str(y[i]) + '\t'

            #Tissote indicatrix parameters computed
            if len(a) > 0:
                line += str(a[i]) + '\t' + str(b[i])

            #Terminate line
            line += '\n'

            #Write line
            file.write(line)


#Define extent and steps
umin = -80
umax = 81
vmin = -180
vmax = 181
Du = 10
Dv = 10
dv = Dv/10
du = Du/10

#Sample points, meridians and parallels
uv = samplePoints(umin, umax, vmin, vmax, Du, Dv)
uvm = sampleMeridians(umin, umax, vmin, vmax, Dv, du)
uvp = sampleParallels(umin, umax, vmin, vmax, Dv, du)

#Load Europe
uve = loadPoints('continents\eur.txt')

#Define projection
sinu = Proj(proj='sinu', R=6380)

#Compute coordinates
[x,y] = sinu(uv[:, 0], uv[:, 1])
[xm,ym] = sinu(uvm[:, 0], uvm[:, 1])
[xp,yp] = sinu(uvp[:, 0], uvp[:, 1])
[xe,ye] = sinu(uve[:, 1], uve[:, 0])

#Compute distortions [a,b] for grid points
res = sinu.get_factors(uv[:, 0], uv[:, 1])
a,b = res.tissot_semimajor, res.tissot_semiminor

#Write points to files
writePoints("points_sinu.txt", uv[:, 1], uv[:, 0], x, y, a, b)
writePoints("meridians_sinu.txt", uvm[:, 1], uvm[:, 0], xm, ym, [], [])
writePoints("parallels_sinu.txt", uvp[:, 1], uvp[:, 0], xp, yp, [], [])
writePoints("europe_sinu.txt", uve[:, 1], uve[:, 0], xe, ye, [], [])
