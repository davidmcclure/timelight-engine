
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


class Unit


  ###
  #
  # Initialize with a name, subunit, and subunit count.
  #
  # @param {String} @name
  # @param {Unit} @subunit
  # @param {Number} @count
  #
  ###
  constructor: (@name, @subunit = null, @count = null) ->


module.exports = Unit
