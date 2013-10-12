
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

    # Map unit names to class instances.
    @names = {}
    for unit in @units
      @names[unit.name] = unit

    # Cache the integer offset of each unit.
    @order = {}
    for unit, i in @units
      @order[unit.name] = i


  ###
  #
  # Convert between two units.
  #
  # @param {Number} quantity
  # @param {Unit} unit1
  # @param {Unit} unit2
  #
  # @return {Number}
  #
  ###
  convert: (quantity, unit1, unit2) ->

    # If no unit change, just return the value.
    if unit1.order == unit2.order
      quantity

    else

      # Are we converting to a smaller or larger unit?
      i1 = @order[unit1]
      i2 = @order[unit2]
      dir = if i1 < i2 then 1 else 0

      # If we're converting "up" to a larger unit.
      if dir
        @convert
        for i in [i1+1..i2]
          quantity /= @units[i].count

      # If we're converting "down" to a smaller unit.
      else
        for i in [i1...i2]
          quantity *= @units[i].count

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
      total += @convert(q, @names[u], unit)

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

    # Get unit instances.
    displayUnit = @names[displayUnit]
    nativeUnit = @names[nativeUnit]

    # The radius (native units).
    nativeRadius = unitsPerTick * tickRadius

    # The left boudary (native units).
    nativeStart = @positionToUnits(position, nativeUnit) - nativeRadius

    # The total length (display units).
    displayLength = @convert(nativeRadius * 2, nativeUnit, displayUnit)

    # The left boundary (display units).
    displayStart = @convert(nativeStart, nativeUnit, displayUnit)

    # The first label visible in the segment.
    firstLabel = Math.ceil(displayStart)

    # The number of labels needed to fill the segment.
    numberOfLabels = Math.floor(displayLength)

    # The number of display units it the parent unit.
    divisor = if displayUnit.parent then displayUnit.parent.count else false

    segment = []

    for i in [0..numberOfLabels]

      # Get the new label and measure the distance in native units from the
      # start of the segment.

      label = firstLabel + i
      nativeDelta = @convert(label - displayStart, displayUnit, nativeUnit)

      # Convert the offset from the left boundary to rendering ticks, push the
      # label onto the segment array.

      ticks = Math.round(nativeDelta / unitsPerTick)
      segment[ticks] = if divisor then label % divisor else label

    segment


module.exports = Calendar
