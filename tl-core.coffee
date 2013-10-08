
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


class Calendar


  # Store the unit definition array, track ordering.
  #
  # @param {Array} @units
  constructor: (@units) ->

    # Track the integer offset of each unit.
    @order = {}
    for unit, i in @units
      @order[unit[0]] = i


  # Convert between two units.
  #
  # @param {Number} quantity
  # @param {String} unit1
  # @param {String} unit2
  # @return {Number}
  convert: (quantity, unit1, unit2) ->

    # If no unit change, just return the value.
    if unit1 == unit2
      quantity

    else

      # Are we converting to a smaller or larger unit?
      i1 = @order[unit1]
      i2 = @order[unit2]
      dir = if i1 < i2 then 1 else 0

      # If we're converting "up" to a larger unit.
      if dir
        for i in [i1+1..i2]
          quantity /= @units[i][1]

      # If we're converting "down" to a smaller unit.
      else
        for i in [i1...i2]
          quantity *= @units[i][1]

    quantity


# TODO|dev
calendar = new Calendar [
  ["millisecond"],
  ["second", 1000],
  ["minute", 60],
  ["hour", 60],
  ["day", 24],
  ["year", 356],
  ["decade", 10],
  ["century", 10]
]

console.log calendar.convert 1, "year", "hour"
