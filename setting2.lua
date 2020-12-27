-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"


local button_setting_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("setting2")
    end
end
--------------------------------------------
-- Init some parameters.
local stepper
local step = 5
local count = (step / 10) * 100
local isRunning = true
local progress = 0.5
local progressView
-- Function
local button_backtomenu_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("menu2")
    end
end

local function onStepperPress(event)
    if isRunning then
      if event.phase == "increment" then
        step = step + 1
        count = (step / 10) * 100
        stepper:setValue(step)
        progress = step / 10
        progressView:setProgress(progress)
        audio.setVolume( progress, { channel=1 } )
      elseif event.phase == "decrement" then
        step = step - 1
        count = (step / 10) * 100
        stepper:setValue(step)
        progress = step / 10
        progressView:setProgress(progress)
        audio.setVolume( progress, { channel=1 } )
      elseif event.phase == "minLimit" then
      -- Pass.
      elseif event.phase == "maxLimit" then
      -- Pass.
      end
    end
  end


function scene:create( event )
    local sceneGroup = self.view

    local BackGround = display.newImageRect("background.jpg",1240,800)
    BackGround.x = display.contentCenterX
    BackGround.y = display.contentCenterY
    sceneGroup:insert(BackGround)

    local text_soundscontrol = display.newImageRect("soundscontrol.png",800,200)
    text_soundscontrol.x = display.contentCenterX
    text_soundscontrol.y = display.contentCenterY*2/3 -50
    sceneGroup:insert(text_soundscontrol)

    local button_backtomenu = widget.newButton{
        width = 300 , 
        height = 60 ,
        id ="1",
        defaultFile ="button_back-to-menu.png",
        overFile ="button_back-to-menu.png",
        onEvent = button_backtomenu_pressed,
    }
    sceneGroup:insert(button_backtomenu)

    button_backtomenu.x = display.contentCenterX
    button_backtomenu.y = display.contentCenterY
    -- Init the ProgressView object.
    progressView =
    widget.newProgressView(
        {
        x = display.contentCenterX,
        y = display.contentCenterY*2/3,
        width = display.contentWidth * 0.5,
        isAnimated = false
        }
    )
    -- Set the initial progress for the ProgressView object.
    progressView:setProgress(progress)
    sceneGroup:insert(progressView)
    stepper =
    widget.newStepper(
    {
        x = display.contentCenterX,
        y = display.contentCenterY*2/3+50,
        initialValue = step,
        minimumValue = 0,
        maximumValue = 10,
        onPress = onStepperPress
    }
    )
    sceneGroup:insert(stepper)
end

function scene:show( event ) 
    local phase = event.phase 
    if "did" == phase then 
        
    end 
end
   
function scene:hide( event ) 
    local phase = event.phase 
    if "will" == phase then 
        composer.removeScene( "setting2" )
    end 
end
   
function scene:destroy( event )
    
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene