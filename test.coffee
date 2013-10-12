
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


Unit      = require("./lib/Unit")
Calendar  = require("./lib/Calendar")
Textline  = require("./lib/Textline")


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
