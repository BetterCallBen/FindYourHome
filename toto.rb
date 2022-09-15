desc = "Venez decouvir notre salle de sport et ouvrez votre session"
LIST = ["session", "salle", "conf", "speaker"]
def strong(desc)
  desc.split.map do |word|
    LIST.include?(word) ? "<strong>#{word}</strong>" : word
  end.join(" ")
end

p strong(desc)
