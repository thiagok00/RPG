enemies_controller = {}
enemies_controller.enemies = {}
enemy = {}
enemies_controller.image = love.graphics.newImage("enemy.png")

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
  enemies_controller:spawnEnemy(50,0)
  enemies_controller:spawnEnemy(230,0)

end

function enemies_controller:spawnEnemy(x,y)
  enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.bullets = {}
  enemy.cooldown = 0
  enemy.speed = 5
  table.insert(self.enemies,enemy)
end

function enemy:fire()
			if self.cooldown <= 0 then
				self = {}
				self.width = 10
				self.height = 10
				self.x = self.x + self.width/2 - self.width/2
				self.y = self.y 
				self.cooldown = 20
				self.insert(self.bullets, bullet)
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
  
  for _,e in pairs(enemies_controller.enemies) do 
    e.y = e.y + 1
  end


end


function love.draw()
	-- Player
	love.graphics.setColor(46,20,150)
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

  -- Bullets
	love.graphics.setColor(255,255,255)
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill",b.x,b.y,10,10)
	end
  
  -- Enemies 
  love.graphics.setColor(255,0,0)
  for _,e in pairs(enemies_controller.enemies) do
    		love.graphics.draw(enemies_controller.image,e.x,e.y,40,40)
  end
  
  
  
end