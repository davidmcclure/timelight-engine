
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


Calendar = require('./lib/Calendar')
Textline = require('./lib/Textline')

calendar = new Calendar([
  ["millisecond"],
  ["second",  1000],
  ["minute",  60],
  ["hour",    60],
  ["day",     24],
  ["year",    365]
])

textline = new Textline(calendar, 50)
textline.render({ year: 2013 }, "year", "day", 50)
