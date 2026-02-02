local get_connected_players = minetest.get_connected_players
local lastdir = {}
local basepos = vector.new(0, 6.35, 0)

minetest.register_globalstep(function()
	for _, player in pairs(get_connected_players()) do
		local pname = player:get_player_name()
		local ldeg = -player:get_look_vertical()

		if (lastdir[pname] or 0) ~= ldeg then
			lastdir[pname] = ldeg
      if (player:get_bone_override("Body").rotation.vec.y) == 0 then
        player:set_bone_override("Head", {
          position = {
            vec = basepos,
            absolute = true
          },
          rotation = {
            vec = {x = ldeg, y = 0, z = 0},
            interpolation = 0.09,
          }
        })
      else
        player:set_bone_override("Head", {
          position = {
            vec = basepos,
            absolute = true
          },
          rotation = {
            vec = {x = ldeg, y = -player:get_bone_override("Body").rotation.vec.y, z = 0},
            interpolation = 0.09,
          }
        })
      end
    end

    if (player:get_player_control().right) then
      player:set_bone_override("Body", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = 0, y = 1, z = 0},
          interpolation = 0.09,
        }
      })
      player:set_bone_override("Head", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = ldeg, y = -1, z = 0},
          interpolation = 0.09,
        }
      })
    elseif (player:get_player_control().left) then
      player:set_bone_override("Body", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = 0, y = -1, z = 0},
          interpolation = 0.09,
        }
      })
      player:set_bone_override("Head", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = ldeg, y = 1, z = 0},
          interpolation = 0.09,
        }
      })
    elseif (player:get_player_control().up or player:get_player_control().down) then
      player:set_bone_override("Body", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = 0, y = 0, z = 0},
          interpolation = 0.09,
        }
      })
      player:set_bone_override("Head", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = ldeg, y = 0, z = 0},
          interpolation = 0.09,
        }
      })
    end

    if (player:get_player_control().dig) then
      player:set_bone_override("Body", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = 0, y = 0, z = 0},
          interpolation = 0.09,
        }
      })
      player:set_bone_override("Head", {
        position = {
          vec = basepos,
          absolute = true
        },
        rotation = {
          vec = {x = ldeg, y = 0, z = 0},
          interpolation = 0.09,
        }
      })
    end
	end
end)

minetest.register_on_leaveplayer(function(player)
	lastdir[player:get_player_name()] = nil
end)
