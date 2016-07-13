enemies_controller = {}
enemies_controller.enemies = {}
enemy = {}
score = 0

function love.load()

  local music = love.audio.newSource('music.mp3')
  music:setLooping(true)
  love.audio.play(music)

  love.graphics.setDefaultFilter('nearest','nearest')
  background_image = love.graphics.newImage('background.png')

  player = {}
  player.bullets = {}
  player.image = love.graphics.newImage('ship.png')
  player.x = 400
  player.y = 550
  player.width = 254/4
  player.height = 182/4
  player.cooldown = 0
  player.speed = 10
  player.fire_sound = love.audio.newSource('Laser_Shoot2.wav')

  player.fire = function ()
    if player.cooldown <= 0 then
      bullet = {}
      bullet.width = 10
      bullet.height = 10
      bullet.x = player.x + player.width/2 - bullet.width/2
      bullet.y = player.y - bullet.height/2
      player.cooldown = 20
      table.insert(player.bullets, bullet)
      love.audio.play(player.fire_sound)

    end
  end

  enemies_controller.image = love.graphics.newImage('enemy.png')
  enemies_controller.enemy_spawn_cooldown = 100
  enemies_controller.last_spawn = enemies_controller.enemy_spawn_cooldown
  enemies_controller.height = 320*0.2
  enemies_controller.width = 320*0.2

end

function randomGenerateEnemies(quantity)
  local i = 0
  while (i < quantity) do
    xPos = love.math.random(150*5) --width of gamescreen
    enemies_controller:spawnEnemy(xPos,-10)
    i = i+1
  end
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

  checkCollisions(enemies_controller.enemies,player.bullets)

  if enemies_controller.last_spawn >= enemies_controller.enemy_spawn_cooldown then
    randomGenerateEnemies(1)
    enemies_controller.last_spawn= 0
  end
  enemies_controller.last_spawn = enemies_controller.last_spawn + 1

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

  for i,e in pairs(enemies_controller.enemies) do 
    if e.y > player.y then
      table.remove(enemies_controller.enemies,i)
    end
    e.y = e.y + 1
  end


end

function checkCollisions(enemies,bullets)
  for ie,e in pairs (enemies) do
    for ib,b in pairs (bullets) do
      if b.y <= e.y + enemies_controller.height-14 and b.x > e.x and b.x < e.x + enemies_controller.width then
        table.remove(enemies,ie)
        table.remove(bullets,ib)
        score = score + 1
      end
    end
  end
end


function love.draw()

  love.graphics.draw(background_image,0,0,0,5)
  love.graphics.print('Score: ' .. score, 0, 0, 0,3,3)
  -- Player
  love.graphics.setColor(255,255,255)
  love.graphics.draw(player.image, player.x, player.y,0,0.25,0.25)

  -- Bullets
  --love.graphics.setColor(255,255,255)
  for _,b in pairs(player.bullets) do
    love.graphics.rectangle("fill",b.x,b.y,10,10)
  end

  -- Enemies 
  --love.graphics.setColor(255,255,255)
  for _,e in pairs(enemies_controller.enemies) do
    love.graphics.draw(enemies_controller.image,e.x,e.y,0,0.2,0.2)
  end



end
