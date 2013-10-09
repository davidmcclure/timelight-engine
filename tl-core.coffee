
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


class Calendar


  ###
  #
  # Store the unit definition array, track ordering.
  #
  # @param {Array} @units
  #
  ###
  constructor: (@units) ->

    # Cache the integer offset of each unit.
    @order = {}
    for unit, i in @units
      @order[unit[0]] = i


  ###
  #
  # Convert between two units.
  #
  # @param {Number} quantity
  # @param {String} unit1
  # @param {String} unit2
  #
  # @return {Number}
  #
  ###
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


  ###
  #
  # Convert a multi-unit position object to  some number a specific unit.
  # Eg: { years: 1, days: 100 } => 465 days
  #
  # @param {Object} position
  # @param {String} unit
  #
  # @return {Number}
  #
  ###
  positionToUnits: (position, unit) ->

    total = 0

    # Convert each position part to the target unit, add to total.
    for u, q of position
      total += @convert q, u, unit

    total


  ###
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
  ###
  render: (center, labelUnit, tickUnit, unitsPerTick, tickRadius) ->

    # First, get the focus in tick units at the left boundary of the segment.
    focusOffset = @positionToUnits center, tickUnit
    startOffset = focusOffset - tickRadius*unitsPerTick

    segment = []
    for i in [0..tickRadius*2]

      # Get the offset in tick and label units at the current tick.
      offset = startOffset + unitsPerTick*i
      labelOffset = @convert offset, tickUnit, labelUnit

      # If the label offset is an integer, push it as a marker.
      segment.push if labelOffset%1 == 0 then labelOffset else "*"


    segment.join("|")


# TODO|dev
calendar = new Calendar [
  ["millisecond"],
  ["second", 1000],
  ["minute", 60],
  ["hour", 60],
  ["day", 24],
  ["year", 365],
  ["decade", 10],
  ["century", 10]
]

console.log calendar.render { year: 2013, day: 10 }, "year", "day", 50, 50
