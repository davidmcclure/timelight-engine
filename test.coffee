
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


Unit      = require "./lib/Unit"
Calendar  = require "./lib/Calendar"
Textline  = require "./lib/Textline"


yoctosecond   = new Unit "yoctosecond"
zeptosecond   = yoctosecond.times   1000,   "zeotpsecond"
attosecond    = zeptosecond.times   1000,   "attosecond"
femtosecond   = attosecond.times    1000,   "femtosecond"
picosecond    = femtosecond.times   1000,   "picosecond"
nanosecond    = picosecond.times    1000,   "nanosecond"
microsecond   = nanosecond.times    1000,   "microsecond"
millisecond   = microsecond.times   1000,   "millisecond"
second        = millisecond.times   1000,   "second"
minute        = second.times        60,     "minute"
hour          = minute.times        60,     "hour"
day           = hour.times          24,     "day"
year          = day.times           365,    "year"
decade        = year.times          10,     "decade"
century       = decade.times        10,     "century"
millennium    = century.times       10,     "millennium"


calendar = new Calendar([
  yoctosecond,
  zeptosecond,
  attosecond,
  femtosecond,
  picosecond,
  nanosecond,
  microsecond,
  millisecond,
  second,
  minute,
  hour,
  day,
  year,
  decade,
  century,
  millennium
])

textline = new Textline(calendar, 100)
textline.render({ year: 2000 }, "day", "day", 0.1)
