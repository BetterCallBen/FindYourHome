module TranslationHelper
  def translate_type(type)
    hash = {
      apartment: "Appartement",
      house: "Maison"
    }
    return hash[type.downcase.to_sym]
  end

  def translate_sort_by(sort_by)
    hash = {
      relevance: 'Pertinence',
      price: 'Prix',
      surface: 'Surface',
      rooms: 'Pièces',
      bedrooms: 'Chambres',
      created_at: 'Date'
    }
    return hash[sort_by.to_sym]
  end

  def translate_status(status)
    hash = {
      furnished: 'meublé',
      unfurnished: 'non meublé'
    }
    return hash[status.to_sym]
  end

  def translate_research(research)
    hash = {
      flat: 'Appartements',
      house: 'Maisons',
      rent: 'Location',
      buy: 'Achat'
    }
    return hash[research.to_sym]
  end

  def translate_rooms(rooms)
    rooms = rooms.chars.sort
    case rooms.count
    when 1
      "#{rooms.first} pièce"
    when 2
      "#{rooms.first} ou #{rooms.last} pièces"
    else
      "#{rooms[0..-2].join(', ')} ou #{rooms.last} pièces"
    end
  end
end
