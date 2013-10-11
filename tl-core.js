(function() {
  var Calendar, calendar, i, segment, strip, _i, _ref;

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
    # @param {Object} position
    # @param {String} displayUnit
    # @param {String} nativeUnit
    # @param {Number} unitsPerTick
    # @param {Number} tickRadius
    #
    # @return {Array}
    #
    */


    Calendar.prototype.render = function(position, displayUnit, nativeUnit, unitsPerTick, tickRadius) {
      var displayLength, displayStart, firstLabel, i, label, nativeDelta, nativeRadius, nativeStart, numberOfLabels, segment, ticks, _i;
      nativeRadius = unitsPerTick * tickRadius;
      nativeStart = this.positionToUnits(position, nativeUnit) - nativeRadius;
      displayLength = this.convert(nativeRadius * 2, nativeUnit, displayUnit);
      displayStart = this.convert(nativeStart, nativeUnit, displayUnit);
      firstLabel = Math.ceil(displayStart);
      numberOfLabels = Math.floor(displayLength);
      segment = [];
      for (i = _i = 0; 0 <= numberOfLabels ? _i <= numberOfLabels : _i >= numberOfLabels; i = 0 <= numberOfLabels ? ++_i : --_i) {
        label = firstLabel + i;
        nativeDelta = this.convert(label - displayStart, displayUnit, nativeUnit);
        ticks = Math.round(nativeDelta / unitsPerTick);
        segment[ticks] = label;
      }
      return segment;
    };

    return Calendar;

  })();

  calendar = new Calendar([["millisecond"], ["second", 1000], ["minute", 60], ["hour", 60], ["day", 24], ["year", 365]]);

  segment = calendar.render({
    year: 2013
  }, "year", "day", 50, 50);

  strip = [];

  for (i = _i = 0, _ref = segment.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
    if (segment[i]) {
      strip.push(segment[i]);
    } else {
      strip.push("*");
    }
  }

  console.log(strip.join(""));

}).call(this);
