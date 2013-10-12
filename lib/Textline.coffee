
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


_ = require "underscore"
require "colors"


class Textline


  ###
  #
  # Set calendar and segment radius.
  #
  # @param {Calendar} @calendar
  # @param {Number} @radius
  # @param {String} @delimiter
  #
  ###
  constructor: (@calendar, @radius, @delimiter=" ") ->


  ###
  #
  # Console log a calendar segment.
  #
  # @param {Object} position
  # @param {String} displayUnit
  # @param {String} nativeUnit
  # @param {Number} unitsPerTick
  #
  # @return {Array}
  #
  ###
  render: (position, displayUnit, nativeUnit, unitsPerTick) ->

    # Query for the calendar segment.
    segment = @calendar.render(
      position, displayUnit, nativeUnit, unitsPerTick, @radius
    )

    timeline = []
    for i in [0...segment.length]
      tick = if _.isNumber(segment[i]) then segment[i] else @delimiter
      timeline.push(tick)

    console.log(timeline.join("").cyan)


module.exports = Textline
