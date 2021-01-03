-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

local BackGround = display.newImageRect("gamebackground.jpg",1240,800)
BackGround.x = display.contentCenterX
BackGround.y = display.contentCenterY
local Board = display.newImageRect('boardeverybody.jpg',630,115)
Board.x = 400
Board.y = 50

return scene


--[[
local Snail = display.newImageRect("snail.png",230,140)
Snail.x = 780
Snail.y = 50
local paper = display.newImageRect("paper.png",155,125)
paper.x = 790
paper.y = 40
]]
