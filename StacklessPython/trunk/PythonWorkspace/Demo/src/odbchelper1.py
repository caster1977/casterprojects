# coding=utf8
import odbchelper
params = {"server":"mpilgrim", "database":"master", "uid":"sa", "pwd":"secret"}
print (odbchelper.buildConnectionString(params))
print (odbchelper.buildConnectionString.__doc__)
print (odbchelper.__name__)
d = {"server":"mpilgrim", "database":"master"}
print (d)
print (d["server"])
print (d["database"])
d["uid"] = "sa"
print (d)
d[42] = "douglas"
d["retrycount"] = 3
print (d)
del d[42]
print (d)
d.clear()
print (d)
'''
li = ["a", "b", "mpilgrim", "z", "example"] 
print li
print li[0]                                       
print li[4]                                       
print li[-1]
print li[-3]
print li[:3]
print li[3:]
print li[:]
li.append("new")
li.insert(2, "new")
li.extend(["two", "elements"])
print li
print li.index("example")
print li.index("new")
print "c" in li
li.remove("z")
li.remove("new")
print li.pop()
print li
li = li + ['example', 'new']
print li
li += ['two']
print li
li = [1, 2] * 3 
print li

t = ("a", "b", "mpilgrim", "z", "example")
print t[0]
print t[-1]
print t[1:3]
print "z" in t
print list(t)
print tuple(li)

print range(7)
(MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY) = range(7)
print MONDAY
print TUESDAY
print SUNDAY

print range.__doc__

k = "uid"
v = "sa"
print "%s=%s" % (k, v)

uid = "sa"
pwd = "secret"
print pwd + " is not a good password for " + uid
print "%s is not a good password for %s" % (pwd, uid)
userCount = 6
print "Users connected: %d" % (userCount, )

li = [1, 9, 8, 4]
print [elem*2 for elem in li]
print li
li = [elem*2 for elem in li]
print li

print ["%s=%s" % (k, v) for k, v in params.items()]
print params.keys()
print params.values()
print params.items()

print [k for k, v in params.items()]
print [v for k, v in params.items()]
print ["%s=%s" % (k, v) for k, v in params.items()]

li = ['server=mpilgrim', 'uid=sa', 'database=master', 'pwd=secret']
s = ";".join(li)
print s
print s.split(";")
print s.split(";", 1)
'''