class Scrapper

    # Récupère l'adresse email, prend en paramètre les liens de la page de la mairie 
  def get_townhall_email(townhall_url)
    email = ""
    page = Nokogiri::HTML(open(townhall_url))
    page.xpath('//td[contains(text(), "@")]').each do |el|
      email += el.text
    end
    return email
  end

  def get_townhall_urls
    arr_url = []
    arr_names = []
    arr_email = []

    # récupère la liste de tous les liens redirigeant vers les pages de chaque mairie
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    page.xpath('//a[contains(@href, "95")]/@href').each do |el|
      arr_url.push(el.value)
    end

    # Boucle pour récupérer le nom de chaque ville
    name = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    name.xpath('//a[contains(@href, "95")]').each do |el|
      arr_names.push(el.text)
    end

    # boucle pour formater l'url et récupérer chaque email de cette url
    arr_url.each do |el|
      el = el[1..-1]
      tmp_str = "https://www.annuaire-des-mairies.com" + el
      arr_email.push(get_townhall_email(tmp_str))
    end
    # Création du hash final
    my_hash = arr_names.zip(arr_email).to_h

    return my_hash
  end

  def save_as_spreadsheet
    hash = Scrapper.new.get_townhall_urls
    index = 1
    # Crée une session
    session = GoogleDrive::Session.from_config("config.json")

    # Copier le code de l'url d'un Google Sheet à toi à la place
    ws = session.spreadsheet_by_key("1vKFn5-PVW0hvlLQ5HH7FHTWmIxcK4_lkSPu1mvMQjwE").worksheets[0]

    hash.each_key do |key|
     ws[index, 1] = key
     ws[index, 2] = hash[key]
     index += 1
  end
  ws.save
  # Reloads the worksheet to get changes by other clients.
  ws.reload
    
  end

  def save_as_csv
    hash = Scrapper.new.get_townhall_urls
    File.open("./db/email.csv", "w") do |f|
      f << hash.map { |c| c.join(",")}.join("\n")
    end
  end

  def save_as_json
    hash = Scrapper.new.get_townhall_urls
    File.open("./db/emails.JSON","w") do |f|
      f << hash.to_json
    end
  end

  def perform
    save_as_json
    save_as_csv 
    save_as_spreadsheet
 end

end