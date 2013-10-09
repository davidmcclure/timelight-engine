(function() {
  var Calendar, calendar;

  Calendar = (function() {
    /*
    #
    # Store the unit definition array, track ordering.
    #
    # @param {Array} @units
    #
    */

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

    /*
    #
    # Convert between two units.
    #
    # @param {Number} quantity
    # @param {String} unit1
    # @param {String} unit2
    #
    # @return {Number}
    #
    */


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

    /*
    #
    # Convert a multi-unit position object to  some number a specific unit.
    # Eg: { years: 1, days: 100 } => 465 days
    #
    # @param {Object} position
    # @param {String} unit
    #
    # @return {Number}
    #
    */


    Calendar.prototype.positionToUnits = function(position, unit) {
      var q, total, u;
      total = 0;
      for (u in position) {
        q = position[u];
        total += this.convert(q, u, unit);
      }
      return total;
    };

    /*
    #
    # Render a calendar segment.
    #
    # @param {Object} center
    # @param {String} labelUnit
    # @param {String} tickUnit
    # @param {Number} unitsPerTick
    # @param {Number} tickRadius
    #
    # @return {Array}
    #
    */


    Calendar.prototype.render = function(center, labelUnit, tickUnit, unitsPerTick, tickRadius) {
      var focusOffset, i, labelOffset, offset, segment, startOffset, _i, _ref;
      focusOffset = this.positionToUnits(center, tickUnit);
      startOffset = focusOffset - tickRadius * unitsPerTick;
      segment = [];
      for (i = _i = 0, _ref = tickRadius * 2; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        offset = startOffset + unitsPerTick * i;
        labelOffset = this.convert(offset, tickUnit, labelUnit);
        segment.push(labelOffset % 1 === 0 ? labelOffset : "*");
      }
      return segment.join("|");
    };

    return Calendar;

  })();

  calendar = new Calendar([["millisecond"], ["second", 1000], ["minute", 60], ["hour", 60], ["day", 24], ["year", 365], ["decade", 10], ["century", 10]]);

  console.log(calendar.render({
    year: 2013,
    day: 10
  }, "year", "day", 50, 50));

}).call(this);
