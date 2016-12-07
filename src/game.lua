world_conf = {
  w = 5000,
  h = 3000,
  columns = 50,
  rows = 30
}
local game = {
  main_cam = gamera.new(0, 0, world_conf.w, world_conf.h),
  map_cam = gamera.new(0, 0, world_conf.w, world_conf.h)
}
game.load = function()
  game.main_cam:setWindow(10, 10, 520, 580)
  game.map_cam:setWindow(540, 10, 250, 180)
  return game.map_cam:setScale(0)
end
game.update = function(dt) end
game.world_draw = function(cl, ct, cw, ch)
  local w = world_conf.w / world_conf.columns
  local h = world_conf.h / world_conf.rows
  do
    local _with_0 = math
    local minX = _with_0.max(_with_0.floor(cl / w), 0)
    local maxX = _with_0.min(_with_0.floor((cl + cw) / w), world_conf.columns - 1)
    local minY = _with_0.max(_with_0.floor(ct / h), 0)
    local maxY = _with_0.min(_with_0.floor((ct + ch) / h), world_conf.rows - 1)
    love.graphics.setColor(100, 100, 100)
    for y = minY, maxY do
      for x = minX, maxX do
        if (x + y) % 2 == 0 then
          love.graphics.setColor(155, 155, 155)
        else
          love.graphics.setColor(200, 200, 200)
        end
        love.graphics.rectangle("fill", x * w, y * h, w, h)
      end
    end
    return _with_0
  end
end
game.draw = function()
  game.main_cam:draw(function(l, t, w, h)
    return game.world_draw(l, t, w, h)
  end)
  game.map_cam:draw(function(l, t, w, h)
    return game.world_draw(l, t, w, h)
  end)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('line', game.main_cam:getWindow())
  love.graphics.rectangle('line', game.map_cam:getWindow())
  local msg = "gamera demo\n    * mouse: move player\n    * arrow keys: camera angle / scale\n  "
  return love.graphics.print(msg, 540, 300)
end
return game
