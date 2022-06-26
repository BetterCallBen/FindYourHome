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
end
