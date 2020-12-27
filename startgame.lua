-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

local button_backtomenu_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("menu2")
    end
end

local pea_drag = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("test")
    end
end
--------------------------------------------
function scene:create( event )
    local sceneGroup = self.view
    local BackGround = display.newImageRect("gamebackground.jpg",1024,768)
    BackGround.x = display.contentCenterX
    BackGround.y = display.contentCenterY
    sceneGroup:insert(BackGround)
    local Board = display.newImageRect('board.png',700,210)
    Board.x = 1024-350
    sceneGroup:insert(Board)
    local pea = widget.newButton{
        width = 100 , 
        height = 100 ,
        id ="1",
        defaultFile ="pea.png",
        overFile ="pea.png",
        onEvent = pea_drag,
    }
    pea.x = Board.x-290
    pea.y = Board.y+50
    sceneGroup:insert(pea)
    local button_backtomenu = widget.newButton{
        width = 300 , 
        height = 60 ,
        id ="1000",
        defaultFile ="button_back-to-menu.png",
        overFile ="button_back-to-menu.png",
        onEvent = button_backtomenu_pressed,
    }
    button_backtomenu.x = display.contentCenterX
    button_backtomenu.y = display.contentCenterY
    sceneGroup:insert(button_backtomenu)
end
   
function scene:show( event ) 
    local phase = event.phase 
    if "did" == phase then

    end
end

function scene:hide( event ) 
    local phase = event.phase 
    if "will" == phase then 
        composer.removeScene("startgame")
    end 
end

function scene:destroy( event )
    
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

