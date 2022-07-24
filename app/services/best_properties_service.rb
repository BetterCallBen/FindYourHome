class BestPropertiesService
  def initialize(properties)
    @properties_data = properties.map do |property|
      {
        property: property,
        score: 0
      }
    end
  end

  def call
    calcul_surface_rating
    calcul_price_rating
    add_bonus_to_properties
    @properties_data.sort! { |a, b| b[:score] <=> a[:score] }.map { |property_data| property_data[:property] }
  end

  private

  def calcul_surface_rating
    @properties_data.sort! { |a, b| b[:property].surface <=> a[:property].surface }
    @properties_data.each_with_index do |property_data, index|
      property_data[:score] += @properties_data.count - index
    end
  end

  def calcul_price_rating
    @properties_data.sort! { |a, b| a[:property].price <=> b[:property].price }
    @properties_data.each_with_index do |property_data, index|
      property_data[:score] += @properties_data.count - index
    end
  end

  def calcul_room_rating
    @properties_data.sort! { |a, b| b[:property].rooms <=> a[:property].rooms }
    @properties_data.each_with_index do |property_data, index|
      property_data[:score] += @properties_data.count - index
    end
  end

  def add_bonus_to_properties
    @properties_data.each do |property_data|
      if property_data[:property].instance_of?(Apartment)
        add_bonus_to_apartments(property_data)
      elsif property_data[:property].instance_of?(House)
        add_bonus_to_houses(property_data)
      end
    end
  end

  def add_bonus_to_apartments(property_data)
    [:balcony, :elevator, :chimney, :cellar, :garage, :terrace].each do |criteria|
      property_data[:score] += @properties_data.count / 5 if property_data[:property].send(criteria)
    end

  end

  def add_bonus_to_houses(property_data)
    [:balcony, :garden, :pool, :chimney, :cellar, :garage, :terrace].each do |criteria|
      property_data[:score] += @properties_data.count / 5 if property_data[:property].send(criteria)
    end
  end
end
