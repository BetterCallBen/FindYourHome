desc = "Venez decouvir notre salle de sport et ouvrez votre session"

def strong(desc)
  desc.split(" ").map do |word|
    ["session", "salle", "conf", "speaker"].include?(word) ? "<strong>#{word}</strong>" : word
  end.join(" ")
end

p strong(desc)
