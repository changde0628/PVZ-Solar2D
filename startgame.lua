-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local Prototype = require( "CoronaPrototype" )
local physics = require("physics")
local scene = composer.newScene()
physics.start()
physics.setGravity(0,0)
-- include Corona's "widget" library
local widget = require "widget"

local backgroundMusic = audio.loadStream( "background.mp3" )
audio.play( backgroundMusic, {channel=2, loops=-1})

local button_backtomenu_pressed = function(event)
    if ("began" == event.phase) then
        composer.gotoScene("menu2")
    end
end

local cost={sun=5,small=10,jacky=5,teacher=15,frozen=30,double=40}
local total = 10
local sunnum = 0
local zombie_num = 0

local function deadline_onCollision(event)
    if event.phase == "began" then
        print('collision')
        gameoverback.isVisible = true
        gameover.isVisible = true
    end
end

local function frozen_shit_onCollision(event)
    if event.phase == "began" then
        event.other:setLinearVelocity( 0, 0)
        event.target:removeSelf()
        event.other.hp = event.other.hp-1
        print(event.other.hp)
        local function testin2( b )
            b:setLinearVelocity( -30, 0)
        end 
        local text2 = function() return testin2(event.other) end
        timer.performWithDelay(1000,text2)
    end
end

local function shit_onCollision(event)
    if event.phase == "began" then
        event.target:removeSelf()
        event.other.hp = event.other.hp-1
        if event.other.hp < 1 then
            event.other:removeSelf()
            zombie_num = zombie_num + 1
            if zombie_num == 23 then
                local gamewin = display.newImageRect('gamewin.png',1000,500)
                gamewin.x = display.contentCenterX
                gamewin.y = display.contentCenterY
            end
        end
    end
end

local function jacky_onCollision(event)
    if event.phase == "began" then
        event.other:setLinearVelocity( 0, 0)
        local function testin( a )
            a:removeSelf()
        end
        local function testin2( b )
            b:setLinearVelocity( -30, 0)
        end 
        local text = function() return testin(event.target) end
        local text2 = function() return testin2(event.other) end
        timer.performWithDelay(1500,text)
        timer.performWithDelay(1600,text2)
    end
end

local function teacher_onCollision(event)
    if event.phase == "began" then
        local bomb = audio.loadStream( "bomb.mp3" )
        audio.play( bomb, {channel=3})
        event.target:removeSelf()
        event.other:removeSelf()
    end
end

local function sun_action( event )
    if event.phase == "ended" then
        event.target:setEnabled(false)
        sunnum = sunnum+1
        print(sunnum)
    end
end

local function small_action( event )
    if event.phase == "ended" then
        event.target:setEnabled(false)
        --[[local tmp = widget.newButton{
            width = 80 , 
            height = 80 ,
            id ='shit',
            defaultFile ="shit.png",
            overFile ="shit.png",
        } ]]
        local tmp = display.newImageRect("shit.png",50,50)
        physics.addBody(tmp,"kinematic")
        tmp:addEventListener("collision",shit_onCollision)
        tmp.x = event.target.x+50
        tmp.y = event.target.y
        local shoot = audio.loadStream( "shoot.mp3" )
        audio.play( shoot, {channel=4})
        tmp:setLinearVelocity( 150, 0)
        local function testin( a )
            a:setEnabled(true)
        end
        local text = function() return testin(event.target) end
        timer.performWithDelay(2000,text)
    end
end

local function zombie_onCollision(event)
    if event.target.hp <= 0 then
        event.target:removeSelf()
    end
end

local function jacky_action( event )
    print('jacky_action')
end

local function teacher_action( event )
    print('teacher_action')
end

local function object_collision( event )
    if event.phase == "began" then
        event.target:removeSelf()
        local function testin2( b )
            b:setLinearVelocity( -30, 0)
        end 
        local text2 = function() return testin2(event.other) end
        timer.performWithDelay(100,text2)
    end
end
--here
local function frozen_action( event )
    if event.phase == "ended" then
        event.target:setEnabled(false)
        local tmp = display.newImageRect("frozenshit.png",50,50)
        physics.addBody(tmp,"kinematic")
        tmp:addEventListener("collision",frozen_shit_onCollision)
        tmp.x = event.target.x+50
        tmp.y = event.target.y
        tmp:setLinearVelocity( 150, 0)
        local function testin( a )
            a:setEnabled(true)
        end
        local text = function() return testin(event.target) end
        timer.performWithDelay(2000,text)
    end
end

local function double_action( event )
    if event.phase == "ended" then
        event.target:setEnabled(false)
        local tmp = display.newImageRect("shit.png",50,50)
        physics.addBody(tmp,"kinematic")
        tmp:addEventListener("collision",shit_onCollision)
        tmp.x = event.target.x+50
        tmp.y = event.target.y
        tmp:setLinearVelocity( 150, 0)
        local tmp2 = display.newImageRect("shit.png",50,50)
        physics.addBody(tmp2,"kinematic")
        tmp2:addEventListener("collision",shit_onCollision)
        tmp2.x = event.target.x
        tmp2.y = event.target.y
        tmp2:setLinearVelocity( 150, 0)
        local function testin( a )
            a:setEnabled(true)
        end
        local text = function() return testin(event.target) end
        timer.performWithDelay(2000,text)
    end
end

local function increase_event( event )
    total = total + (sunnum+1)
    energy.text = tostring(total)
    timer.performWithDelay( 2000,increase_event )
end

local action = {sun = sun_action,small = small_action,jacky = jacky_action ,teacher = teacher_action,frozen = frozen_action,double = double_action}
local collision = {sun = object_collision,small = object_collision,jacky = jacky_onCollision,teacher = teacher_onCollision,frozen = object_collision,double = object_collision}
--[[local function dragmove( event )
    local touchOb = event.target
    if event.phase == "began" then
        touchOb.previousX = touchOb.x
        touchOb.previousY = touchOb.y
    elseif event.phase == "moved" then
        touchOb.x = (event.x - event.xStart) + touchOb.previousX
        touchOb.y = (event.y - event.yStart) + touchOb.previousY
    elseif event.phase == "ended" then
        action[touchOb.id]()
    end
end]]

local function dorecttouch( event )
    local touchOb = event.target
    if total < cost[touchOb.id] then
        return 0
    end
        if event.phase == "began" then
            touchOb.previousX = touchOb.x
            touchOb.previousY = touchOb.y
            ox = touchOb.previousX
            oy = touchOb.previousY
        elseif event.phase == "moved" then
            touchOb.x = (event.x - event.xStart) + touchOb.previousX
            touchOb.y = (event.y - event.yStart) + touchOb.previousY
        elseif event.phase == "ended" then
            local tmp = widget.newButton{
                width = 100 , 
                height = 95 ,
                id =touchOb.id,
                defaultFile =touchOb.id..".png",
                overFile =touchOb.id..".png",
                onRelease = action[touchOb.id]
            }
            physics.addBody(tmp,"static")
            tmp:addEventListener("collision",collision[touchOb.id])
            tmp.x = touchOb.x
            tmp.y = touchOb.y
            touchOb.x = ox
            touchOb.y = oy
            total = total - cost[touchOb.id]
            energy.text = tostring(total)
        end
end
--------------------------------------------
function scene:create( event )
    local sceneGroup = self.view
    energy = display.newText(total,900,50,native.systemFont,48)
    local BackGround = display.newImageRect("gamebackground.jpg",1240,800)
    BackGround.x = display.contentCenterX
    BackGround.y = display.contentCenterY
    local Board = display.newImageRect('boardacter .png',630,115)
    Board.x = 430
    Board.y = 50

    local deadline = display.newImageRect('deadline.png',20,657)
    deadline.x = 130
    deadline.y = 418
    physics.addBody(deadline,"kinematic")
    deadline:addEventListener("collision",deadline_onCollision)

    gameoverback = display.newImageRect('gray.png',5000,2000)
    gameoverback.x = display.contentCenterX
    gameoverback.y = display.contentCenterY
    gameoverback.isVisible = false

    gameover = display.newImageRect('gameover.png',500,200)
    gameover.x = display.contentCenterX
    gameover.y = display.contentCenterY
    gameover.isVisible = false

    -- this template
    local zombie12 = display.newImageRect('zombiemix.png',80,115)
    zombie12.x = 1800
    zombie12.y = 160
    zombie12.hp = 5
    physics.addBody(zombie12,"dynamic",{isSensor = true})
    zombie12:setLinearVelocity( -30, 0)
    zombie12:addEventListener("collision",zombie_onCollision)

    local zombie13 = display.newImageRect('zombiemix.png',80,115)
    zombie13.x = 2400
    zombie13.y = 160
    zombie13.hp = 5
    physics.addBody(zombie13,"dynamic",{isSensor = true})
    zombie13:setLinearVelocity( -30, 0)
    zombie13:addEventListener("collision",zombie_onCollision)

    local zombie15 = display.newImageRect('zombiemix.png',80,115)
    zombie15.x = 3100
    zombie15.y = 160
    zombie15.hp = 5
    physics.addBody(zombie15,"dynamic",{isSensor = true})
    zombie15:setLinearVelocity( -30, 0)
    zombie15:addEventListener("collision",zombie_onCollision)

    local zombie17 = display.newImageRect('zombiemix.png',80,115)
    zombie17.x = 3700
    zombie17.y = 160
    zombie17.hp = 5
    physics.addBody(zombie17,"dynamic",{isSensor = true})
    zombie17:setLinearVelocity( -30, 0)
    zombie17:addEventListener("collision",zombie_onCollision)

    local zombie22 = display.newImageRect('zombiemix.png',80,115)
    zombie22.x = 2000
    zombie22.y = 290
    zombie22.hp = 5
    physics.addBody(zombie22,"dynamic",{isSensor = true})
    zombie22:setLinearVelocity( -30, 0)
    zombie22:addEventListener("collision",zombie_onCollision)

    local zombie24 = display.newImageRect('zombiemix.png',80,115)
    zombie24.x = 2950
    zombie24.y = 290
    zombie24.hp = 5
    physics.addBody(zombie24,"dynamic",{isSensor = true})
    zombie24:setLinearVelocity( -30, 0)
    zombie24:addEventListener("collision",zombie_onCollision)  
    
    local zombie27 = display.newImageRect('zombiemix.png',80,115)
    zombie27.x = 3600
    zombie27.y = 290
    zombie27.hp = 5
    physics.addBody(zombie27,"dynamic",{isSensor = true})
    zombie27:setLinearVelocity( -30, 0)
    zombie27:addEventListener("collision",zombie_onCollision)

    local zombie28 = display.newImageRect('zombiemix.png',80,115)
    zombie28.x = 4200
    zombie28.y = 290
    zombie28.hp = 5
    physics.addBody(zombie28,"dynamic",{isSensor = true})
    zombie28:setLinearVelocity( -30, 0)
    zombie28:addEventListener("collision",zombie_onCollision)

    local zombie29 = display.newImageRect('zombiemix.png',80,115)
    zombie29.x = 3900
    zombie29.y = 290
    zombie29.hp = 5
    physics.addBody(zombie29,"dynamic",{isSensor = true})
    zombie29:setLinearVelocity( -30, 0)
    zombie29:addEventListener("collision",zombie_onCollision)

    local zombie31 = display.newImageRect('zombiemix.png',80,115)
    zombie31.x = 1300
    zombie31.y = 425
    zombie31.hp = 5
    physics.addBody(zombie31,"dynamic",{isSensor = true})
    zombie31:setLinearVelocity( -30, 0)
    zombie31:addEventListener("collision",zombie_onCollision)
   

    local zombie33 = display.newImageRect('zombiemix.png',80,115)
    zombie33.x = 2400
    zombie33.y = 425
    zombie33.hp = 5
    physics.addBody(zombie33,"dynamic",{isSensor = true})
    zombie33:setLinearVelocity( -30, 0)
    zombie33:addEventListener("collision",zombie_onCollision)

    local zombie34 = display.newImageRect('zombiemix.png',80,115)
    zombie34.x = 2725
    zombie34.y = 425
    zombie34.hp = 5
    physics.addBody(zombie34,"dynamic",{isSensor = true})
    zombie34:setLinearVelocity( -30, 0)
    zombie34:addEventListener("collision",zombie_onCollision)

    local zombie36 = display.newImageRect('zombiemix.png',80,115)
    zombie36.x = 3525
    zombie36.y = 425
    zombie36.hp = 5
    physics.addBody(zombie36,"dynamic",{isSensor = true})
    zombie36:setLinearVelocity( -30, 0)
    zombie36:addEventListener("collision",zombie_onCollision)

    local zombie39 = display.newImageRect('zombiemix.png',80,115)
    zombie39.x = 4200
    zombie39.y = 425 
    zombie39.hp = 5
    physics.addBody(zombie39,"dynamic",{isSensor = true})
    zombie39:setLinearVelocity( -30, 0)
    zombie39:addEventListener("collision",zombie_onCollision)

    local zombie42 = display.newImageRect('zombiemix.png',80,115)
    zombie42.x = 2100
    zombie42.y = 555
    zombie42.hp = 5
    physics.addBody(zombie42,"dynamic",{isSensor = true})
    zombie42:setLinearVelocity( -30, 0)
    zombie42:addEventListener("collision",zombie_onCollision)

    local zombie44 = display.newImageRect('zombiemix.png',80,115)
    zombie44.x = 3000
    zombie44.y = 555
    zombie44.hp = 5
    physics.addBody(zombie44,"dynamic",{isSensor = true})
    zombie44:setLinearVelocity( -30, 0)
    zombie44:addEventListener("collision",zombie_onCollision)

    local zombie47 = display.newImageRect('zombiemix.png',80,115)
    zombie47.x = 3500
    zombie47.y = 555
    zombie47.hp = 5
    physics.addBody(zombie47,"dynamic",{isSensor = true})
    zombie47:setLinearVelocity( -30, 0)
    zombie47:addEventListener("collision",zombie_onCollision)

    local zombie49 = display.newImageRect('zombiemix.png',80,115)
    zombie49.x = 4100
    zombie49.y = 555
    zombie49.hp = 5
    physics.addBody(zombie49,"dynamic",{isSensor = true})
    zombie49:setLinearVelocity( -30, 0)
    zombie49:addEventListener("collision",zombie_onCollision)

    local zombiefinal = display.newImageRect('zombiemix.png',80,115)
    zombiefinal.x = 4500
    zombiefinal.y = 555
    zombiefinal.hp = 5
    physics.addBody(zombiefinal,"dynamic",{isSensor = true})
    zombiefinal:setLinearVelocity( -30, 0)
    zombiefinal:addEventListener("collision",zombie_onCollision)

    local zombie53 = display.newImageRect('zombiemix.png',80,115)
    zombie53.x = 2500
    zombie53.y = 685
    zombie53.hp = 5
    physics.addBody(zombie53,"dynamic",{isSensor = true})
    zombie53:setLinearVelocity( -30, 0)
    zombie53:addEventListener("collision",zombie_onCollision)

    local zombie54 = display.newImageRect('zombiemix.png',80,115)
    zombie54.x = 2800
    zombie54.y = 685
    zombie54.hp = 5
    physics.addBody(zombie54,"dynamic",{isSensor = true})
    zombie54:setLinearVelocity( -30, 0)
    zombie54:addEventListener("collision",zombie_onCollision)

    local zombie57 = display.newImageRect('zombiemix.png',80,115)
    zombie57.x = 3400
    zombie57.y = 685
    zombie57.hp = 5
    physics.addBody(zombie57,"dynamic",{isSensor = true})
    zombie57:setLinearVelocity( -30, 0)
    zombie57:addEventListener("collision",zombie_onCollision)

    local zombie58 = display.newImageRect('zombiemix.png',80,115)
    zombie58.x = 3575
    zombie58.y = 685
    zombie58.hp = 5
    physics.addBody(zombie58,"dynamic",{isSensor = true})
    zombie58:setLinearVelocity( -30, 0)
    zombie58:addEventListener("collision",zombie_onCollision)
    --

    local sun = widget.newButton{
        width = 105 , 
        height = 100 ,
        id ="sun",
        defaultFile ="sun.png",
        overFile ="sun.png",
    }
    local barcheckpoint = 160
    sun.x = barcheckpoint 
    sun.y = 45
    local small = widget.newButton{
        width = 105 , 
        height = 100 ,
        id ="small",
        defaultFile ="small.png",
        overFile ="small.png",
    }
    small.x = barcheckpoint+100
    small.y = 45
    local jacky = widget.newButton{
        width = 105 , 
        height = 100 ,
        id ="jacky",
        defaultFile ="jacky.png",
        overFile ="jacky.png",
    }
    jacky.x = 466
    jacky.y = 42
    local teacher = widget.newButton{
        width = 105 , 
        height = 100 ,
        id ="teacher",
        defaultFile ="teacher.png",
        overFile ="teacher.png",
    }
    teacher.x = barcheckpoint+2*100
    teacher.y = 45
    local frozen = widget.newButton{
        width = 105 ,
        height = 100 ,
        id = 'frozen',
        defaultFile = 'frozen.png' ,
        overFile = 'frozen.png' ,
    }
    frozen.x = 665
    frozen.y = 40
    local double = widget.newButton{
        width = 100,
        height = 95,
        id = 'double',
        defaultFile = 'double.png',
        overFile = 'double.png',
    }
    double.x = 565
    double.y = 40

    sun:addEventListener("touch",dorecttouch)
    small:addEventListener("touch",dorecttouch)
    jacky:addEventListener("touch",dorecttouch)
    teacher:addEventListener("touch",dorecttouch)
    frozen:addEventListener("touch",dorecttouch)
    double:addEventListener("touch",dorecttouch)

    sceneGroup:insert(BackGround)
    sceneGroup:insert(Board)
    sceneGroup:insert(sun)
    sceneGroup:insert(small)
    sceneGroup:insert(jacky)
    sceneGroup:insert(teacher)
    sceneGroup:insert(frozen)
    sceneGroup:insert(double)
    sceneGroup:insert(deadline)
    local counter = increase_event()
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

