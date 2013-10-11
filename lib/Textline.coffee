
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


class Textline


  ###
  #
  # Set calendar and segment radius.
  #
  # @param {Calendar} @calendar
  # @param {Number} @radius
  #
  ###
  constructor: (@calendar, @radius) ->


  ###
  #
  # Console log a calendar segment.
  #
  # @param {Object} position
  # @param {String} dUnit
  # @param {String} nUnit
  # @param {Number} unitsPerTick
  #
  # @return {Array}
  #
  ###
  render: (position, dUnit, nUnit, unitsPerTick) ->

    # Query for the calendar segment.
    segment = @calendar.render(position, dUnit, nUnit, unitsPerTick, @radius)

    timeline = []
    for i in [0...segment.length]
      tick = if segment[i] then segment[i] else "*"
      timeline.push(tick)

    console.log(timeline.join(""))


module.exports = Textline
