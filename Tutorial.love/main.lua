
function love.load()
	player = {}
	player.bullets = {}
	player.x = 400
	player.y = 550
	player.width = 80
	player.height = 20
	player.cooldown = 0
	player.speed = 10
	player.fire = function ()
			if player.cooldown <= 0 then
				bullet = {}
				bullet.width = 10
				bullet.height = 10
				bullet.x = player.x + player.width/2 - bullet.width/2
				bullet.y = player.y 
				player.cooldown = 20
				table.insert(player.bullets, bullet)
			end
		end
end

function love.update(dt)
	if player.cooldown > 0 then
		player.cooldown = player.cooldown - 1
	end
	-- Handling keyboard events
	if love.keyboard.isDown("right") then
		player.x = player.x + player.speed
	elseif love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	end
	--[[ Move Down
	if love.keyboard.isDown("up") then
		player.y = player.y - 1
	elseif love.keyboard.isDown("down") then
		player.y = player.y + 1		
	end
	--]]
	if love.keyboard.isDown("space") then
		player.fire()
	end


	for i,b in pairs(player.bullets) do 
		if b.y < -20 then
			table.remove(player.bullets,i)
		end
		b.y = b.y - 5
	end


end


function love.draw()
	-- Creating rectangle
	love.graphics.setColor(46,20,150)
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

	love.graphics.setColor(255,255,255)
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill",b.x,b.y,10,10)
	end
end