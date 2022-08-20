module RoomsHelper

  def room_filter(room, type)
    @type = type.to_sym
    room = room.to_s
    link_name = type == "rooms" ? room_name(room) : bedroom_name(room)

    link_to link_name,
      if params[@type].present? && params[@type].include?(room)
        params[@type].chars.count == 1 ?  request.params.except(@type) : request.params.merge(page: 1, @type => params[@type].delete(room))
      else
        request.params.merge(page: 1, @type => params[@type].present? ? params[@type] + room : room)
      end,
      class: "bed-tag #{studio?(room) if type == "rooms"} #{tag_active?(room)}"
  end

  def room_filling(room, type)
    "<div class='filling #{filling_active?(room)} #{studio?(room) if type == "rooms"}'></div>".html_safe
  end

  private

  def tag_active?(room)
    "active" if params[@type.to_sym].present? && params[@type.to_sym].include?(room)
  end

  def filling_active?(room)
    'active' if params[@type].present? && params[@type].include?(room.to_s) && params[@type].include?((room + 1).to_s)
  end

  def room_name(room)
    case room
    when "1"
      "Studio"
    when "5"
      "5+"
    else
      room
    end
  end

  def bedroom_name(room)
    room == "5" ? "5+" : room
  end

  def studio?(room)
    "studio" if room.to_s == "1"
  end

end
