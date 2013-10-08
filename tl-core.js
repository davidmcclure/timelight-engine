(function() {
  var Calendar, calendar;

  Calendar = (function() {
    function Calendar(units) {
      var i, unit, _i, _len, _ref;
      this.units = units;
      this.order = {};
      _ref = this.units;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        unit = _ref[i];
        this.order[unit[0]] = i;
      }
    }

    Calendar.prototype.convert = function(quantity, unit1, unit2) {
      var dir, i, i1, i2, _i, _j, _ref;
      if (unit1 === unit2) {
        quantity;
      } else {
        i1 = this.order[unit1];
        i2 = this.order[unit2];
        dir = i1 < i2 ? 1 : 0;
        if (dir) {
          for (i = _i = _ref = i1 + 1; _ref <= i2 ? _i <= i2 : _i >= i2; i = _ref <= i2 ? ++_i : --_i) {
            quantity /= this.units[i][1];
          }
        } else {
          for (i = _j = i1; i1 <= i2 ? _j < i2 : _j > i2; i = i1 <= i2 ? ++_j : --_j) {
            quantity *= this.units[i][1];
          }
        }
      }
      return quantity;
    };

    return Calendar;

  })();

  calendar = new Calendar([["millisecond"], ["second", 1000], ["minute", 60], ["hour", 60], ["day", 24], ["year", 356], ["decade", 10], ["century", 10]]);

  console.log(calendar.convert(1, "year", "hour"));

}).call(this);
