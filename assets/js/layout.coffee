# layout.coffee

class Layout
  constructor: (@containerSelector, @itemSelector) ->

  doLayout: ->
    self = this

    $container = $(@containerSelector).first()
    $items = $(@itemSelector)

    fullWidth = $container.width()
    fullHeight = $container.height()

#    itemsPerRow = Math.ceil((fullWidth * fullHeight) / ($items.length * fullHeight))
    itemsPerRow = Math.ceil(fullWidth / Math.sqrt(fullWidth * fullHeight / $items.length) * 0.8)
    numRows = Math.ceil($items.length / itemsPerRow)
    console.log $items.length, itemsPerRow, numRows

    $items.each (key, item) ->
      $item = $(item)
      itemWidth = Math.floor(fullWidth / itemsPerRow)
      itemHeight = Math.floor(fullHeight / numRows)
      console.log itemWidth, itemHeight
      self.setDimensions $item, itemWidth, itemHeight

  getExtraDimensions: ($item) ->
    width: $item.outerWidth(true) - $item.width(),
    height: $item.outerHeight(true) - $item.height()

  setDimensions: ($item, width, height) ->
    extraDim = this.getExtraDimensions $item
    console.log extraDim
    $item.width width - extraDim.width
    $item.height height - extraDim.height

$ ->
  layout = new Layout '.status_indicators', '.status_indicators a .job'
  layout.doLayout()

