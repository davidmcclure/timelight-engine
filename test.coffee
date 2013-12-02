
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80;

units = [

  [
    "millisecond", {
      definition: null # Smallest unit, defined in terms of nothing.
    }
  ],

  [
    "second", {
      definition: ["millisecond", 1000]
    }
  ],

  [
    "minute", {

      definition: ["second", 60]

      #
      # Construct the [HOUR]:[MINUTE] [AM/PM] label for a minute. Eg:
      #
      # 1:15 AM
      # 12:30 PM
      # 3:45 PM
      #
      # @param {Unit} unit
      # @return {String}
      #
      label: (unit) ->

        hour = unit.getPartLabel("hour")
        minute = unit.getPartLabel("minute")
        ampm = "AM"

        if hour > 12
          hour -= 12
          ampm = "PM"

        "#{hour}:#{minute} #{ampm}"

    }
  ],

  [
    "5_minutes", {
      definition: ["minute", 5],
      label: "@minute"
    }
  ],

  [
    "10_minutes", {
      definition: ["minute", 10],
      label: "@minute"
    }
  ],

  [
    "15_minutes", {
      definition: ["minute", 15],
      label: "@minute"
    }
  ],

  [
    "30_minutes", {
      definition: ["minute", 30],
      label: "@minute"
    }
  ],

  [
    "hour", {
      definition: ["minute", 60],
      label: "@minute"
    }
  ],

  [
    "day", {
      definition: ["hour", 24]
    }
  ],

  [
    "year", {
      definition: ["month", [

        [
          "january", {
            definition: ["day", 31],
            label: "January"
          }
        ]

      ]]
    }
  ],

]
