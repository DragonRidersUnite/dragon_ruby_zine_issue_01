IMG_PREFIX = "sprites/DragonRuby Zine Issue 1 - v1.1-"
TOTAL_PAGES = 48

def sprite_for_page(number)
  number = if number < 10
             "0#{number}"
           else
             number
           end
  "#{IMG_PREFIX}#{number}.png"
end

def tick args
  args.state.current_page ||= 1

  if args.state.current_page == 1 || args.state.current_page == TOTAL_PAGES
    args.outputs.sprites << {
      x: (args.grid.w / 2) - (207),
      y: args.grid.h - 656,
      w: 414,
      h: 640,
      path: sprite_for_page(args.state.current_page),
    }
  else
    if args.state.current_page % 2 == 0
      left_page = args.state.current_page
      right_page = args.state.current_page + 1
    else
      left_page = args.state.current_page - 1
      right_page = args.state.current_page
    end

    args.outputs.sprites << {
      x: 226.from_left,
      y: args.grid.h - 656,
      w: 414,
      h: 640,
      path: sprite_for_page(left_page),
    }
    args.outputs.sprites << {
      x: 642,
      y: args.grid.h - 656,
      w: 414,
      h: 640,
      path: sprite_for_page(right_page),
    }
  end

  args.outputs.labels  << {
    x: args.grid.w / 2,
    y: 42.from_bottom,
    text: 'Preview the zine! | Navigate with arrow keys/WASD',
    size_enum: 4,
    alignment_enum: 1
  }

  args.state.key_delay ||= 0
  if args.inputs.right || args.inputs.left
    if args.state.key_delay <= 0
      if args.inputs.right
        args.state.current_page += 2
      else
        args.state.current_page -= 2
      end
      args.state.key_delay = 10

      if args.state.current_page > TOTAL_PAGES
        args.state.current_page = TOTAL_PAGES
      end

      if args.state.current_page < 1
        args.state.current_page = 1
      end
    else
      args.state.key_key -= 1
    end
  else
    args.state.key_delay = 0
  end
end
