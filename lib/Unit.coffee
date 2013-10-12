
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;


class Unit


  ###
  #
  # Initialize with a name, child unit, and child unit count.
  #
  # @param {String} @name
  # @param {Unit} @parent
  # @param {Unit} @child
  # @param {Number} @count
  # @param {Number} @order
  #
  ###
  constructor: (@name, @parent=null, @child=null, @count=null, @order=0) ->


  ###
  #
  # Generate a new unit that is X times larger than this unit.
  #
  # @param {Number} count
  # @param {String} name
  #
  ###
  times: (count, name) ->
    @parent = new Unit(name, null, @, count, @order+1)


module.exports = Unit
