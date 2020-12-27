local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
 
function widget.newNavigationBar( options )
   local customOptions = options or {}
   local opt = {}
   opt.left = customOptions.left or nil
   opt.top = customOptions.top or nil
   opt.width = customOptions.width or display.contentWidth
   opt.height = customOptions.height or 50
   if ( customOptions.includeStatusBar == nil ) then
      opt.includeStatusBar = true  -- assume status bars for business apps
   else
      opt.includeStatusBar = customOptions.includeStatusBar
   end
 
   -- Determine the amount of space to adjust for the presense of a status bar
   local statusBarPad = 0
   if ( opt.includeStatusBar ) then
      statusBarPad = display.topStatusBarContentHeight
   end
 
   opt.x = customOptions.x or display.contentCenterX
   opt.y = customOptions.y or (opt.height + statusBarPad) * 0.5
   opt.id = customOptions.id
   opt.isTransluscent = customOptions.isTransluscent or true
   opt.background = customOptions.background
   opt.backgroundColor = customOptions.backgroundColor
   opt.title = customOptions.title or ""
   opt.titleColor = customOptions.titleColor or { 0, 0, 0 }
   opt.font = customOptions.font or native.systemFontBold
   opt.fontSize = customOptions.fontSize or 18
   opt.leftButton = customOptions.leftButton or nil
   opt.rightButton = customOptions.rightButton or nil
 
   -- If "left" and "top" parameters are passed, calculate the X and Y
   if ( opt.left ) then
      opt.x = opt.left + opt.width * 0.5
   end
   if ( opt.top ) then
      opt.y = opt.top + (opt.height + statusBarPad) * 0.5
   end

      local barContainer = display.newGroup()
      local background = display.newRect( barContainer, opt.x, opt.y, opt.width, opt.height + statusBarPad )
      if ( opt.background ) then
         background.fill = { type="image", filename=opt.background }
      elseif ( opt.backgroundColor ) then
         background.fill = opt.backgroundColor
      else
         background.fill = { 1, 1, 1 } 
      end

      if ( opt.title ) then 
        local title = display.newText( opt.title, background.x, background.y + statusBarPad * 0.5, opt.font, opt.fontSize )
        title:setFillColor( unpack(opt.titleColor) )
        barContainer:insert( title )
     end

     local leftButton
   if ( opt.leftButton ) then
      if ( opt.leftButton.defaultFile ) then  -- construct an image button
         leftButton = widget.newButton({
            id = opt.leftButton.id,
            width = opt.leftButton.width,
            height = opt.leftButton.height,
            baseDir = opt.leftButton.baseDir,
            defaultFile = opt.leftButton.defaultFile,
            overFile = opt.leftButton.overFile
            onEvent = opt.leftButton.onEvent
            })
      else  -- else, construct a text button
         leftButton = widget.newButton({
            id = opt.leftButton.id,
            label = opt.leftButton.label,
            onEvent = opt.leftButton.onEvent,
            font = opt.leftButton.font or opt.font,
            fontSize = opt.fontSize,
            labelColor = opt.leftButton.labelColor or { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            labelAlign = "left",
            })
      end
      leftButton.x = 15 + leftButton.width * 0.5
      leftButton.y = title.y
      barContainer:insert( leftButton )  -- insert button into container group
   end
 
   local rightButton
   if ( opt.rightButton ) then
      if ( opt.rightButton.defaultFile ) then  -- construct an image button
         rightButton = widget.newButton({
            id = opt.rightButton.id,
            width = opt.rightButton.width,
            height = opt.rightButton.height,
            baseDir = opt.rightButton.baseDir,
            defaultFile = opt.rightButton.defaultFile,
            overFile = opt.rightButton.overFile,
            onEvent = opt.rightButton.onEvent
            })
      else  -- else, construct a text button
         rightButton = widget.newButton({
            id = opt.rightButton.id,
            label = opt.rightButton.label or "Default",
            onEvent = opt.rightButton.onEvent,
            font = opt.leftButton.font or opt.font,
            fontSize = opt.fontSize,
            labelColor = opt.rightButton.labelColor or { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            labelAlign = "right",
            })
      end
      rightButton.x = display.contentWidth - ( 15 + rightButton.width * 0.5 )
      rightButton.y = title.y
      barContainer:insert( rightButton )  -- insert button into container group
    end
 
    return barContainer
end

local function handleLeftButton( event )
    if ( event.phase == "ended" ) then
       -- do stuff
    end
    return true
 end
  
 local function handleRightButton( event )
    if ( event.phase == "ended" ) then
       -- do stuff
    end
    return true
 end

 local leftButton = {
    onEvent = handleLeftButton,
    width = 60,
    height = 34,
    defaultFile = "images/backbutton.png",
    overFile = "images/backbutton_over.png"
 }
  
 local rightButton = {
    onEvent = handleRightButton,
    label = "Add",
    labelColor = { default =  {1, 1, 1}, over = { 0.5, 0.5, 0.5} },
    font = "HelveticaNeue-Light",
    isBackButton = false
 }

 local navBar = widget.newNavigationBar({
    title = "SuperDuper App",
    backgroundColor = { 0.96, 0.62, 0.34 },
    --background = "images/topBarBgTest.png",
    titleColor = {1, 1, 1},
    font = "HelveticaNeue",
    leftButton = leftButton,
    rightButton = rightButton,
    includeStatusBar = true
 })

 return scene