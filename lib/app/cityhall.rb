

class Scrapper

    # Récupère l'adresse email , prend en parametre le liens de la page de la mairie 
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

    # récupére la liste de tout les liens redirigeant vers les pages de chaque mairie
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    page.xpath('//a[contains(@href, "95")]/@href').each do |el|
      arr_url.push(el.value)
    end

    # Boucle pour récupéré le nom de chaque ville
    name = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    name.xpath('//a[contains(@href, "95")]').each do |el|
      arr_names.push(el.text)
    end
    # boucle pour formaté l'url @ récupéré chaque email @ cette url
    arr_url.each do |el|
      el = el[1..-1]
      tmp_str = "https://www.annuaire-des-mairies.com" + el
      arr_email.push(get_townhall_email(tmp_str))
    end
    # Création du hash final
    my_hash = arr_names.zip(arr_email).to_h

    # Le print pour vérifié que c'est bon est la <3
    return my_hash
  end

end

#get_townhall_urls
