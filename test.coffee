
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


Unit      = require("./lib/Unit")
Calendar  = require("./lib/Calendar")
Textline  = require("./lib/Textline")


yoctosecond   = new Unit("yoctosecond")
zeptosecond   = new Unit("zeotpsecond",   yoctosecond,    1000)
attosecond    = new Unit("attosecond",    zeptosecond,    1000)
femtosecond   = new Unit("femtosecond",   attosecond,     1000)
picosecond    = new Unit("picosecond",    femtosecond,    1000)
nanosecond    = new Unit("nanosecond",    picosecond,     1000)
microsecond   = new Unit("microsecond",   nanosecond,     1000)
millisecond   = new Unit("millisecond",   microsecond,    1000)
second        = new Unit("second",        millisecond,    1000)
minute        = new Unit("minute",        second,         60)
hour          = new Unit("hour",          minute,         60)
day           = new Unit("day",           hour,           24)
year          = new Unit("year",          day,            365)
decade        = new Unit("decade",        year,           10)
century       = new Unit("century",       decade,         10)
millennium    = new Unit("millennium",    century,        10)


calendar = new Calendar([
  ["yoctosecond"],
  ["zeptosecond", 1000],
  ["attosecond",  1000],
  ["femtosecond", 1000],
  ["picosecond",  1000],
  ["nanosecond",  1000],
  ["microsecond", 1000],
  ["millisecond", 1000],
  ["second",      1000],
  ["minute",      60],
  ["hour",        60],
  ["day",         24],
  ["year",        365],
  ["decade",      10],
  ["century",     10],
  ["millennium",  10]
])

textline = new Textline(calendar, 100)
textline.render({ year: 2000 }, "day", "day", 0.1)
