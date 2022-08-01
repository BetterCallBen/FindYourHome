class ResearchCity < ApplicationRecord
  belongs_to :city
  belongs_to :research
end
