# layout.coffee

class Layout
  constructor: (@containerSelector, @itemSelector) ->

  doLayout: ->
    self = this

    $container = $(@containerSelector).first()
    $items = $(@itemSelector)

    fullWidth = $container.width()
    fullHeight = $container.height()

    itemsPerRow = Math.ceil(fullWidth / Math.sqrt(fullWidth * fullHeight / $items.length) * 0.8)
    numRows = Math.ceil($items.length / itemsPerRow)

    $items.each (key, item) ->
      $item = $(item)
      self.setDimensions $item, Math.floor(fullWidth / itemsPerRow), Math.floor(fullHeight / numRows)
      $item.css "font-size", (0.5 + fullWidth / 2700) + "em"

  getExtraDimensions: ($item) ->
    width: $item.outerWidth(true) - $item.width(),
    height: $item.outerHeight(true) - $item.height()

  setDimensions: ($item, width, height) ->
    extraDim = this.getExtraDimensions $item
    $item.width width - extraDim.width
    $item.height height - extraDim.height

$ ->
  layout = new Layout '.status_indicators', '.status_indicators a .job'
  layout.doLayout()

  $(window).resize ->
    layout.doLayout()
