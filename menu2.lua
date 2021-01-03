local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

backgroundMusic = audio.loadStream( "backgroundmusic.mp3" )
audio.play( backgroundMusic, {channel=1, loops=-1})
local BackGround,dispObj_1,yeeda
-- Function to handle button events
local function yeeda_move_right()
    yeeda.xScale = 1.0
    transition.to(yeeda,{x=150,y=200,time=12000,onComplete=yeeda_move_left})
end

local function yeeda_move_left()
    yeeda.xScale = -1.0
    transition.to(yeeda,{x=display.contentCenterX+370,y=200,time=12000,onComplete=yeeda_move_right})
end

local button_start_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("startgame")--,{effect ="zoomOutIn",time = 800})
        audio.stop(1)
        composer.removeScene("menu")
    end
end
local button_setting_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("setting2")
    end
end
local button_exit_pressed = function(event)
    if ("began" == event.phase) then
        os.exit() 
    end
end
-- Called when the scene's view does not exist:
function scene:create( event )
    local sceneGroup = self.view
    BackGround = display.newImageRect("background.jpg",1240,800)
    BackGround.x = display.contentCenterX
    BackGround.y = display.contentCenterY
    sceneGroup:insert(BackGround)
    dispObj_1 = display.newImageRect( "Plants-Vs-Zombies-PNG-Pic.png", 450, 300 )
    dispObj_1.x = display.contentCenterX
    dispObj_1.y = 150
    sceneGroup:insert(dispObj_1)
    yeeda = display.newImageRect( "Plants-Vs-Zombies-PNG-HD (1).png", 300, 200 )
    yeeda.x = display.contentCenterX+370
    yeeda.y = 200
    sceneGroup:insert(yeeda)
    local button_start = widget.newButton{
        width =200 , 
        height =100 ,
        id ="1",
        defaultFile ="button_start-game (2).png",
        overFile ="button_start-game (2).png",
        onEvent = button_start_pressed,
    }
    button_start.x = display.contentCenterX
    button_start.y = 390
    sceneGroup:insert(button_start)
    local button_setting = widget.newButton{
        width =200 , 
        height =100 ,
        id ="2",
        defaultFile ="button_setting.png",
        overFile ="button_setting.png",
        onEvent = button_setting_pressed,
    }
    button_setting.x = display.contentCenterX
    button_setting.y = 510
    sceneGroup:insert(button_setting)
    local button_exit = widget.newButton{
        width =200 , 
        height =100 ,
        id ="3",
        defaultFile ="button_exit.png",
        overFile ="button_exit.png",
        onEvent = button_exit_pressed,
    }
    button_exit.x = display.contentCenterX
    button_exit.y = 630
    sceneGroup:insert(button_exit)
    transition.to(yeeda,{x=150,y=200,time=12000,onComplete=yeeda_move_left})
end

function scene:show( event ) 
    local phase = event.phase 
    if "did" == phase then

    end
end

function scene:hide( event ) 
    local phase = event.phase 
    if "will" == phase then 
        composer.removeScene("menu2")
    end 
end

function scene:destroy( event )

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene