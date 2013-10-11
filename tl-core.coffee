
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
      total += @convert(q, u, unit)

    total


  ###
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
  ###
  render: (position, displayUnit, nativeUnit, unitsPerTick, tickRadius) ->

    nRadius = unitsPerTick * tickRadius
    nStart  = @positionToUnits(position, nativeUnit) - nRadius
    dLength = @convert(nRadius * 2, nativeUnit, displayUnit)
    dStart  = @convert(nStart, nativeUnit, displayUnit)

    segment = []
    for i in [0..Math.floor(dLength)]
      label = Math.ceil(dStart) + i
      ticks = @convert(label - dStart, displayUnit, nativeUnit) / unitsPerTick
      segment[Math.round(ticks)] = label

    segment





# TODO|dev
calendar = new Calendar [
  ["millisecond"],
  ["second",  1000],
  ["minute",  60],
  ["hour",    60],
  ["day",     24],
  ["year",    365]
]

segment = calendar.render { year: 2013 }, "year", "day", 50, 50

strip = []
for i in [0...segment.length]
  if segment[i]
    strip.push segment[i]
  else
    strip.push "*"

console.log strip.join ""
