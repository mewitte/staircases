# frozen_string_literal: true

SMOOTH_SCROLLING = true
SPEED_REDUCTION_ON_STAIRS = 0.85

$DisableScrollCoutner = 0

# This class clears stair data when changing maps
class Scene_Map
  def transfer_player(cancelVehicles = true)
    transfer_player(cancelVehicles)
    $game_player.clear_stair_data
  end
end

# This class adds functionality to the Game_Event class to handle vertical stair movement
class Game_Event
  def check_event_trigger_touch(dir)
    return if on_stair?

    check_event_trigger_touch
  end

  def check_event_trigger_auto
    if $game_map&.events
      $game_map.events.each_value do |event|
        if stair_event? || @id == event.id || $game_player.x == event.x && $game_player.y == event.y
          next
        end
        unless !on_stair? && (@real_x / Game_Map::REAL_RES_X).round == event.x && (real_y / GameMap::REAL_RES_Y).round == event.y && event.stair_event?
          next
        end

        slope(*event.get_stair_data)
        break
      end
    end
    return if on_stair? || $game_player.on_stair?

    check_event_trigger_auto
  end

  def stair_start
    if stair_event?
      $game_player.slope(*get_stair_data)
    else
      stair_start
    end
  end

  def stair_event?
    name == 'Vertical Slope'
  end

  def stair_data
    return unless stair_event?
    return unless @list

    xincline = nil
    yincline = nil
    ypos = 0
    yheight = 1
    offset = 16

    @list.each do |cmd|
      next if cmd.code == 108

      case cmd.parameters[0]
      when /Slope: (-?\d+)x(-?\d+)/
        xincline = Regexp.last_match(1).to_i
        yincline = Regexp.last_match(2).to_i
      when %r{Width: (\d+)/(\d+)}
        ypos = Regexp.last_match(1).to_i
        yheight = Regexp.last_match(2).to_i
      when /Offset: (\d+)px/
        offset = Regexp.last_match(1).to_i
      end
    end

    [xincline, yincline, ypos, yheight, offset]
  end
end

# This class adds functionality to the Game_Player class to handle vertical stair movement
class Game_Player
  def check_event_trigger_touch(dir)
    return if on_stair?

    check_event_trigger_touch(dir)
  end

  def check_event_trigger_here(triggers)
    return if on_stair?

    check_event_trigger_here(triggers)
  end

  def check_event_trigger_there(triggers)
    return if on_stair?

    check_event_trigger_there(triggers)
  end

  def move_generic(dir, turn_enabled = true)
    turn_generic(dir, true) if turn_enabled
    unless $game_temp.encounter_triggered
      if can_move_in_direction?(dir)
        # TODO
      elsif !check_event_trigger_touch(dir)
        bump_into_object
      end
    end
    $game_temp.encounter_triggered = false
  end

  def move_down(turn_enabled = true)
    move_generic(2, turn_enabled) { moving_vertically(1) }
  end

  def move_up(turn_enabled = true)
    move_generic(8, turn_enabled) { moving_vertically(-1) }
  end
end

# This class adds functionality to the Game_Map class to handle scrolling during vertical stair movement
class Game_Map
  def scroll_down(distance)
    stair_scroll_down(distance) unless $DisableScrollCounter == 1
  end

  def scroll_left(distance)
    stair_scroll_left(distance) unless $DisableScrollCounter == 1
  end

  def scroll_right(distance)
    stair_scroll_right(distance) unless $DisableScrollCounter == 1
  end

  def scroll_up(distance)
    stair_scroll_up(distance) unless $DisableScrollCounter == 1
  end
end

# This class adds functionality to the Game_Character class to handle vertical stair movement
class Game_Character
  attr_accessor :stair_start_x, :stair_start_y, :stair_end_x, :stair_end_y, :stair_y_position, :stair_y_height, :stair_begin_offset

  def passable?(x, y, d, strict = false)
    # TODO
  end

  def move_generic(dir, turn_enabled = true)
    turn_generic(dir) if turn_enabled or can_move_in_direction?
    if can_move_in_direction?(dir)
      case dir
      when 2
        @y += 1
      when 4
        @x -= 1
      when 6
        @x += 1
      when 8
        @y -= 1
      end
      increase_steps
      yield if block_given?
    else
      check_event_trigger_touch(dir)
    end
  end

  def move_down(turn_enabled = true)
    move_generic(2, turn_enabled) { moving_vertically(1) }
  end

  def move_up(turn_enabled = true)
    move_generic(8, turn_enabled) { moving_vertically(-1) }
  end

  def on_stair?
    # TODO
  end

  def on_middle_of_stair?
    # TODO
  end

  def slope(x, y, ypos = 0, yheight = 1, begin_offset = 0)
    # TODO
  end

  def clear_stair_data
    # TODO
  end

  def moving_vertically(value)
    # TODO
  end

  def update
    # TODO
  end

  def update_pattern
    # TODO
  end

  def moving?
    # TODO
  end

  def screen_y_ground
    # TODO
  end
end
