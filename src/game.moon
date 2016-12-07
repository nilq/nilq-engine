export world_conf = {
  w: 5000
  h: 3000
  columns: 50
  rows: 30
}

game = {
  main_cam: gamera.new 0, 0, world_conf.w, world_conf.h
  map_cam:  gamera.new 0, 0, world_conf.w, world_conf.h
}

game.load = ->
  game.main_cam\setWindow(10, 10, 520, 580)

  game.map_cam\setWindow(540, 10, 250, 180)
  game.map_cam\setScale 0

game.update = (dt) ->

game.world_draw = (cl, ct, cw, ch) ->
  w = world_conf.w / world_conf.columns
  h = world_conf.h / world_conf.rows

  with math
    minX = .max(.floor(cl/w), 0)
    maxX = .min(.floor((cl+cw)/w), world_conf.columns-1)
    minY = .max(.floor(ct/h), 0)
    maxY = .min(.floor((ct+ch)/h), world_conf.rows-1)

    love.graphics.setColor 100, 100, 100

    for y=minY, maxY
      for x=minX, maxX
        if (x + y) % 2 == 0
          love.graphics.setColor(155,155,155)
        else
          love.graphics.setColor(200,200,200)
        love.graphics.rectangle("fill", x*w, y*h, w, h)

game.draw = ->
  game.main_cam\draw (l, t, w, h) ->
    game.world_draw l, t, w, h

  game.map_cam\draw (l, t, w, h) ->
    game.world_draw l, t, w, h

  love.graphics.setColor(255,255,255)
  love.graphics.rectangle('line', game.main_cam\getWindow())
  love.graphics.rectangle('line', game.map_cam\getWindow())

  msg = "gamera demo
    * mouse: move player
    * arrow keys: camera angle / scale
  "

  love.graphics.print(msg, 540, 300)

game
