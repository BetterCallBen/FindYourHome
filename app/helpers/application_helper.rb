module ApplicationHelper
  def pluralize(count, content)
    if count > 1
      "#{count} #{content}s"
    else
      "#{count} #{content}"
    end
  end

  def translate_type(type)
    hash = {
      flat: 'Appartement',
      house: 'Maison',
      garage: 'Garage',
      ground: 'Terrain'
    }
    return hash[type.to_sym]
  end

  def in_group_of(count, number)
    if count == 4 || count == 5 || count == 6
      number = number.to_s.chars
      last_part = number.pop(3).join
      return "#{number.join} #{last_part}"
    elsif count == 7 || count == 8 || count == 9
      number = number.to_s.chars
      last_part = number.pop(3).join
      middle_part = number.pop(3).join
      return "#{number.join} #{middle_part} #{last_part}"
    end
  end
end
