setDefaultTab("Main")

schedule(1000, function()

  if player:getTitle() == ('Seiya [Pegasus]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Meteoro De Pegasus'
 storage.combo2 = 'Cometa De Pegasus'
 storage.combo3 = 'Turbilhao de Pegasus'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
 storage.ultimate = 'ataque de pegasus'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne]') then
  storage.elemento = 'Wind'
 storage.combo1 = 'Po de Diamante'
 storage.combo2 = 'Trovao Aurora Ataque'
 storage.combo3 = 'Execucao Aurora'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne'
 storage.ultimate = 'circulo de gelo celestial'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Colera do Dragao'
 storage.combo2 = 'Dragao Voador'
 storage.combo3 = 'Last Dragon'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragon'
 storage.ultimate = 'life strengthening'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Nebulosa de Andromeda'
 storage.combo2 = 'Onda Relampago'
 storage.combo3 = 'Correnteza Nebulosa'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda'
 storage.ultimate = 'corrente circular'
 storage.sspell = nil
 storage.sense = 'chain sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ave Fenix'
 storage.combo2 = 'Golpe de Fenix'
 storage.combo3 = 'Hoyoku Tensho'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix'
 storage.ultimate = 'golpe fantasma de fenix'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mascara da Morte [Cancer]') then
 storage.elemento = 'Water'
 storage.combo1 = 'akubensu'
 storage.combo2 = 'sekishiki meikai'
 storage.combo3 = 'sekishiki kisoen'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cancer'
 storage.ultimate = 'ondas do inferno'
 storage.sspell = 'yomotsu shield'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mu [Aries]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Rede de Cristal'
 storage.combo2 = 'Extincao Estelar'
 storage.combo3 = 'Revolucao Estelar'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aries'
 storage.sspell = 'create repair hammer'
 storage.ultimate = 'muralha de cristal'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Camus [Aquario]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Esquife de Gelo'
  storage.combo2 = 'circulo de gelo'
  storage.combo3 = 'Daiyamondo Dasuto'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
  storage.sspell = nil
  storage.ultimate = 'Esquife de Gelo Supremo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Camus Renegado [Aquario]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Esquife de Gelo'
  storage.combo2 = 'circulo de gelo'
  storage.combo3 = 'Daiyamondo Dasuto'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento
  storage.sspell = nil
  storage.ultimate = 'Esquife de Gelo Supremo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Daichi [Terra]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Suchiiru hariken'
 storage.combo2 = 'Steek Hurricane'
 storage.combo3 = 'Furacao de Aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  terra'
 storage.sspell = nil
 storage.ultimate = 'stone wall'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ushio [Mar]') then
 storage.elemento = 'Water'
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mar'
 storage.sspell = nil
 storage.ultimate = 'cosmo consumption'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sho [Ceu]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ceu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol [Perseu]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  perseu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol Renegado [Perseu]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  perseu'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro') then
 storage.combo1 = 'Cosmo Punch'
 storage.combo2 = 'Cosmo Impact'
 storage.combo3 = 'Cosmo Galaxy'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ichi [Hidra]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Presas Venenosas'
 storage.combo2 = 'Chute Maravilhoso de Hydrus'
 storage.combo3 = 'Ataque das Mil Presas de Hydrus'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hidra'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ban [Leao Menor]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ataque Explosivo do Leao'
 storage.combo2 = 'Lionet Bomber'
 storage.combo3 = 'Raionetto Bonba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao menor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jabu [Unicornio]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Galope do Unicornio'
 storage.combo2 = 'Golpe do Unicornio'
 storage.combo3 = 'Fuku Yunikon'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  unicornio'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Nachi [Lobo]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Punho Do Lobo'
 storage.combo2 = 'Uivo Mortal'
 storage.combo3 = 'Shi no toboe'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lobo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Geki [Urso]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'punho de urso'
 storage.combo2 = 'abraco do urso'
 storage.combo3 = 'kuma no hoyo'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  urso'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('June [Camaleao]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Punho De Camaleao'
 storage.combo2 = 'Chicote do Camaleao'
 storage.combo3 = 'Kamereon no muchi'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  camaleao'
 storage.sspell = nil
 storage.ultimate = 'poder curativo "' .. player:getName()
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Guarda Graad') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Graad Punch'
 storage.combo2 = 'Graad Impact'
 storage.combo3 = 'Graad Blast'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  graad'
 storage.sspell = nil
 storage.ultimate = 'last cartridge'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses [Baleia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  baleia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cassius') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Cassius Punch'
 storage.combo2 = 'Cassius Impact'
 storage.combo3 = 'Cassius Comet Punch'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ear'
 storage.sspell = nil
 storage.ultimate = 'stay away'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kenuma [Pegasus Negro]') then
 storage.combo1 = 'meteoro negro'
 storage.combo2 = 'cometa negro'
 storage.combo3 = 'turbilhao negro'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pegasus negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ritahoa [Fenix Negro]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Ankoku Houou Genma Ken'
 storage.combo2 = 'Espirito Diabolico do Fenix Negro'
 storage.combo3 = 'Ankoku Houou Hoyoku Tensho'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix negro'
 storage.sspell = nil
 storage.ultimate = 'assalto negro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Umnamed [Andromeda Negro]') then
 storage.combo1 = 'corrente negra'
 storage.combo2 = 'black fang nebula'
 storage.combo3 = 'ankoku fang nebulosa'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jido [Cisne Negro]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante das trevas'
 storage.combo2 = 'nevasca das trevas'
 storage.combo3 = 'burakkuburizodo'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne negro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Minos [Griffon]') then
 storage.elemento = 'Dark'
 storage.combo1 = 'papusa cosmica'
 storage.combo2 = 'griffon strike'
 storage.combo3 = 'marionete'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  griffon'
 storage.sspell = nil
 storage.ultimate = 'marionete cosmica'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro [Cristal]') then
 storage.elemento = 'Water'
 storage.combo1 = 'po de cristal'
 storage.combo2 = 'golpe congelante'
 storage.combo3 = 'toketsu ken'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cristal'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ennetsu [Fogo]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'poder do fogo'
 storage.combo2 = 'fire screw'
 storage.combo3 = 'faiya sukuryu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fogo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Serpente Marinha [Fantasma]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Punho da Serpente Marinha'
 storage.combo2 = 'Phantom Sea Serpent'
 storage.combo3 = 'Sea Serpent Eruption'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  serpente marinha'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Docrates [Hydrus]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'poder de hercules'
 storage.combo2 = 'punho de hercules'
 storage.combo3 = 'heracles moo shuu ken'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hydrus'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == 'Shura [Capricornio]' then
 storage.elemento = 'Earth'
 storage.combo1 = 'pedra saltitante'
 storage.combo2 = 'Excalibur'
 storage.combo3 = 'Shinken ekusukariba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  capricornio'
 storage.sspell = nil
 storage.ultimate = 'excalibur sword'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == 'Shura Renegado [Capricornio]' then
 storage.elemento = 'Earth'
 storage.combo1 = 'pedra saltitante'
 storage.combo2 = 'Excalibur'
 storage.combo3 = 'Shinken ekusukariba'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  capricornio'
 storage.sspell = nil
 storage.ultimate = 'excalibur sword'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dante [Cerberus]') or player:getTitle() == ('Dante Renegado [Cerberus]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Maca Infernal'
 storage.combo2 = 'Jigoku no Kokyusa'
 storage.combo3 = 'Maca Vital'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cerberus'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Asterion [Caes de Caca]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'ataque de um milhao de fantasmas'
 storage.combo2 = 'mirion gosuto atakku'
 storage.combo3 = 'explosao telepatica'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  caes'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jamian [Corvo]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'pluma negra'
 storage.combo2 = 'black wing shaft'
 storage.combo3 = 'black feather'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  corvo'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio [Mosca]') then
  storage.elemento = 'Wind'
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mosca'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolia [Leao]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Capsula do Poder'
 storage.combo2 = 'Lightning Bolt'
 storage.combo3 = 'Relampago de Plasma'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao'
 storage.sspell = nil
 storage.ultimate = 'golpe violento do leao'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aldebaran [Touro]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'Grande Chifre'
 storage.combo2 = 'Gureto Hon'
 storage.combo3 = 'Great Horn'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  touro'
 storage.sspell = nil
 storage.ultimate = 'grande chifre de ouro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dohko [Libra]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'rozan shoryuha'
 storage.combo2 = 'rozan hyaku ryu ha'
 storage.combo3 = 'colera dos cem dragoes'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  libra'
 storage.sspell = nil
 storage.ultimate = 'rejuvenescimento'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolos [Sagitario]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Flecha de Sagitario'
 storage.combo2 = 'Trovao Atomico'
 storage.combo3 = 'Atomikku Sandaaboruto'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sagitario'
 storage.sspell = nil
 storage.ultimate = 'flecha de ouro'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Milo [Escorpiao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'agulha escarlate'
 storage.combo2 = 'sukaretto nidoru antaresu'
 storage.combo3 = 'agulha escarlate de antares'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  escorpiao'
 storage.sspell = nil
 storage.ultimate = 'ferroada mortal'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses Renegado [Baleia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  baleia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  centauro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel Renegado [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  centauro'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shaka [Virgem]') then
 storage.elemento = 'Light'
 storage.combo1 = 'ohm'
 storage.combo2 = 'kahn'
 storage.combo3 = 'rendicao divina'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  virgem'
 storage.sspell = nil
 storage.ultimate = 'tesouro do ceu'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Capella [Auriga]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'discos mortais'
 storage.combo2 = 'saucer kogeki'
 storage.combo3 = 'ripping saucers'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  auriga'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Capella Renegado [Auriga]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'discos mortais'
 storage.combo2 = 'saucer kogeki'
 storage.combo3 = 'ripping saucers'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  auriga'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Shiva [Pavao]') then
 storage.elemento = 'Water'
 storage.combo1 = 'golpe dos mil bracos'
 storage.combo2 = 'senju shinon ken'
 storage.combo3 = 'thousand arms coup'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pavao'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Farao [Esfinge]') then
  storage.elemento = 'Earth'
 storage.combo1 = 'balanca da maldicao'
 storage.combo2 = 'baransu obu kasu'
 storage.combo3 = 'beijo na escuridao'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  esfinge'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio Renegado [Mosca]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mosca'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Misty [Lagarto]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Furacao das Trevas'
 storage.combo2 = 'Mavrou Trypa'
 storage.combo3 = 'Dark Hurricane'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lagarto'
 storage.sspell = nil
 storage.ultimate = 'paredao de ar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Misty Renegado [Lagarto]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'Furacao das Trevas'
 storage.combo2 = 'Mavrou Trypa'
 storage.combo3 = 'Dark Hurricane'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  lagarto'
 storage.sspell = nil
 storage.ultimate = 'paredao de ar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite Renegado [Peixes]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite [Peixes]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Thetis [Sereia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'cilada de coral'
 storage.combo2 = 'death trap coral'
 storage.combo3 = 'coral deslumbrante'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sereia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth [Hercules]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hercules'
 storage.sspell = nil
 storage.ultimate = 'protecao de hercules'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth Renegado [Hercules]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  hercules'
 storage.sspell = nil
 storage.ultimate = 'protecao de hercules'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Marin [Aguia]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Meteoro'
 storage.combo2 = 'Lampejo da Aguia'
 storage.combo3 = 'Iguru Tou Furasshu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aguia'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shina [Ofiuco]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Garras de Trovao'
 storage.combo2 = 'Sanda Kuron'
 storage.combo3 = 'Venha Cobra'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ofiuco'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Fenrir [Alioth]') then
 storage.elemento = 'Earth'
 storage.combo1 = 'garra do lobo assassino'
 storage.combo2 = 'golpe do lobo imortal'
 storage.combo3 = 'immortal wolf explosion'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  alioth'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Alberich [Megrez]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'Couraca Ametista'
 storage.combo2 = 'Espada de Fogo'
 storage.combo3 = 'Unidade da Natureza'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  megrez'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bado [Alcor]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'garras do tigre das sombras'
 storage.combo2 = 'shadow viking tiger claw'
 storage.combo3 = 'Tigre Tiranico das Sombras'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  alcor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shido [Mizar]') then
 storage.elemento = 'Water'
 storage.combo1 = 'Garras do Tigre Negro'
 storage.combo2 = 'Viking Tiger Claw'
 storage.combo3 = 'Impulso Azul'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  mizar'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saga [Maligno]') then
 storage.elemento = 'Dark'
 storage.combo1 = 'Outra Dimensao'
 storage.combo2 = 'Sata Imperial'
 storage.combo3 = 'Explosao Galactica'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  maligno'
 storage.sspell = nil
 storage.ultimate = 'dimensao galactica'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mime [Benetnasch]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'requiem de cordas'
 storage.combo2 = 'sutoringa rekuiemu'
 storage.combo3 = 'stringer requiem'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  benetnasch'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Siegfried [Dubhe]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'odin sodo'
 storage.combo2 = 'odin sword'
 storage.combo3 = 'dragon bravest blizzard'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dubhe'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'Po de Diamante Divino'
 storage.combo2 = 'Trovao Aurora Ataque Divino'
 storage.combo3 = 'Divina Execucao Aurora '
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne divino'
 storage.sspell = nil
 storage.ultimate = 'Execucao Aurora Divina'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Odin]') then
 storage.elemento = 'Water'
 storage.combo1 = 'meteoro de odin'
 storage.combo2 = 'cometa de odin'
 storage.combo3 = 'balmung'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  odin'
 storage.sspell = nil
 storage.ultimate = 'balmung reaper'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Aquario]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante'
 storage.combo2 = 'aniquilacao aurora'
 storage.combo3 = 'aurora destruction'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aquario'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Isaak [Kraken]') then
 storage.elemento = 'Water'
 storage.combo1 = 'aurora boreal'
 storage.combo2 = 'aurora borealis'
 storage.combo3 = 'diamond dust'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  kraken'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'ave fenix divina'
 storage.combo2 = 'golpe de fenix divina'
 storage.combo3 = 'hoyoku tensho divina'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix divina'
 storage.sspell = nil
 storage.ultimate = 'lenda fenix'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao Divino]') then
 storage.elemento = 'Light'
 storage.combo1 = 'colera do dragao divino'
 storage.combo2 = 'divine excalibur'
 storage.combo3 = 'divino colera dos cem dragoes'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragao divino'
 storage.sspell = nil
 storage.ultimate = 'colera dos cem dragoes de rozan'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sorento [Sirene]') then
 storage.elemento = 'Light'
 storage.combo1 = 'sinfonia da morte'
 storage.combo2 = 'sinfonia final da morte'
 storage.combo3 = 'climax final da morte'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sirene'
 storage.sspell = nil
 storage.ultimate = 'canto da sirene'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saori [Athena]') then
 storage.elemento = 'Water'
 storage.combo1 = 'hikari uchu kosen'
 storage.combo2 = 'hikari seiken'
 storage.combo3 = 'hikari cosmo sword'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Sagitario]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'pegasus ryu sei ken'
 storage.combo2 = 'sagittarius ogon no ya'
 storage.combo3 = 'cosmic star arrow'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sagitario'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Celeste]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'po de diamante celeste'
 storage.combo2 = 'trovao aurora celeste'
 storage.combo3 = 'execucao aurora celeste'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cisne celeste'
 storage.sspell = nil
 storage.ultimate = 'execucao celeste'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Rock [Golem]') then
storage.elemento = 'Earth'
 storage.combo1 = 'avalanche explosiva'
 storage.combo2 = 'roringu bonba suton'
 storage.combo3 = 'bomber stone'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  golem'
 storage.sspell = nil
 storage.ultimate = 'avalanche devastadora'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kagaho [Benu]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'explosao de coroa solar'
 storage.combo2 = 'sol negro'
 storage.combo3 = 'chamas negras'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  benu'
 storage.sspell = nil
 storage.ultimate = 'explosao da coroa solar'
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Krishna [Chrysaor]') then
 storage.elemento = 'Fire'
 storage.combo1 = 'flashing lance'
 storage.combo2 = 'maha roshini'
 storage.combo3 = 'lanca relampago'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  chrysaor'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bian [Cavalo Marinho]') then
 storage.elemento = 'Wind'
 storage.combo1 = 'assopro divino'
 storage.combo2 = 'goddo buresu'
 storage.combo3 = 'raijingu birouzu'
 storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cavalo marinho'
 storage.sspell = nil
 storage.ultimate = nil
 storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Radamanthys [Wyvern]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'gureitesuto koshon'
  storage.combo2 = 'greatest caution'
  storage.combo3 = 'destruicao maxima'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  wyvern'
  storage.sspell = nil
  storage.ultimate = 'flying wyvern'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda Divino]') then
 storage.elemento = 'Light'
  storage.combo1 = 'nebulosa de andromeda divina'
  storage.combo2 = 'tempestade nebulosa divina'
  storage.combo3 = 'divino correnteza nebulosa'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'chain sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Pegasus Celeste]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'meteoro de pegasus astral'
  storage.combo2 = 'cometa de pegasus astral'
  storage.combo3 = 'turbilhao de pegasus astral'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  pegasus celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Zelos [Sapo]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'salto esmagador'
  storage.combo2 = 'pulverizador de veneno'
  storage.combo3 = 'muco assombroso'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  sapo'
  storage.sspell = nil
  storage.ultimate = 'jumping smash'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unnamed [Andromeda Negro]') then
  storage.elemento = 'Earth'
  storage.combo1 = 'corrente negra'
  storage.combo2 = 'black fang nebula'
  storage.combo3 = 'ankoku fang nebulosa'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  andromeda negro'
  storage.sspell = nil
  storage.ultimate = 'nebulosa negra'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Poseidon [Deus]') then
  storage.elemento = 'Light'
  storage.combo1 = 'vento artico'
  storage.combo2 = 'divine marine destruction'
  storage.combo3 = 'trovao divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  poseidon'
  storage.sspell = nil
  storage.ultimate = 'tsunami devastador'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kanon [Dragao Marinho]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'genromaoken'
  storage.combo2 = 'marine destruction'
  storage.combo3 = 'great marine destruction'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  dragao marinho'
  storage.sspell = nil
  storage.ultimate = 'triangulo marinho'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unity [Dragao Marinho]') then
  storage.combo1 = 'vento artico'
  storage.combo2 = 'divine marine destruction'
  storage.combo3 = 'trovao divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  poseidon'
  storage.sspell = nil
  storage.ultimate = 'tsunami devastador'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mascara da Morte Renegado [Cancer]') then
  storage.elemento = 'Water'
  storage.combo1 = 'akubensu'
  storage.combo2 = 'sekishiki meikai'
  storage.combo3 = 'sekishiki kisoen'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  cancer'
  storage.sspell = 'yomotsu shield'
  storage.ultimate = 'ondas do inferno'
    storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Leao]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'capsula do poder da fenix'
  storage.combo2 = 'golpe de fenix relampago'
  storage.combo3 = 'phoenix lightning plasma'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  leao'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Golfinho [Fantasma]') then
  storage.combo1 = 'golpe do golfinho'
  storage.combo2 = 'dolphin ryukuchu kaiten'
  storage.combo3 = 'explosive dolphin blow'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  golfinho'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shion [Aries]') then
  storage.elemento = 'Light'
  storage.combo1 = 'kurisutaru woru'
  storage.combo2 = 'sutadasuto reboryushon'
  storage.combo3 = 'destruction of aries'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  shion'
  storage.sspell = nil
  storage.ultimate = 'revolucao divina'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shion Renegado [Aries]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'luz estelar'
  storage.combo2 = 'revolucao da poeira estelar'
  storage.combo3 = 'destruicao maxima de aries'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  aries renegado'
  storage.sspell = nil
  storage.ultimate = 'sobrepelis estelar'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix Celeste]') then
  storage.elemento = 'Fire'
  storage.combo1 = 'ave fenix celeste'
  storage.combo2 = 'golpe de fenix celeste'
  storage.combo3 = 'hoyoku tensho celeste'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  fenix celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao Celeste]') then
  storage.elemento = 'Water'
  storage.combo1 = 'colera do dragao celeste'
  storage.combo2 = 'dragao voador celeste'
  storage.combo3 = 'ultimo dragao celeste'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  dragon celeste'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Unity [Dragao Marinho]') then
  storage.elemento = 'Light'
  storage.combo1 = 'sancto oricalco'
  storage.combo2 = 'holy pillar'
  storage.combo3 = 'santo pilar'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  unity'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Io [Scylla]') then
  storage.elemento = 'Water'
  storage.combo1 = 'aguia poderosa'
  storage.combo2 = 'furia do lobo'
  storage.combo3 = 'tornado violento'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  scylla'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Thanatos [Deus Da Morte]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'teriburu purobidensu'
  storage.combo2 = 'divine punishment'
  storage.combo3 = 'terrivel providencia'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  morte'
  storage.sspell = nil
  storage.ultimate = 'medo do abismo'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Hypnos [Deus Do Sono]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'etanaru doraujinesu'
  storage.combo2 = 'execucao de pesadelo'
  storage.combo3 = 'pesadelo eterno'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  sono'
  storage.sspell = nil
  storage.ultimate = 'sono eterno'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Saga [Gemeos Divino]') then
  storage.elemento = 'light'
  storage.combo1 = 'anaza dimenshon divino'
  storage.combo2 = 'destruicao mental divino'
  storage.combo3 = 'galaxian explosion divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Big Bang'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('El Cid [Capricornio]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Jumping Stone'
  storage.combo2 = 'Seiken Ex'
  storage.combo3 = 'Excalibur Light'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Seiken Excalibur'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolia [Leao Divino]') then
  storage.elemento = 'Light'
  storage.combo1 = 'Capsula Do Poder Divina'
  storage.combo2 = 'Lightning Bolt Divino'
  storage.combo3 = 'Relampago De Plasma Divino'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Relampago Divino'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiacos [Garuda]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'Voo Da Garuda'
  storage.combo2 = 'Conquistador De Indra'
  storage.combo3 = 'Resplendor Da Morte Galactica'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saga Renegado [Gemeos]') then
  storage.elemento = 'Dark'
  storage.combo1 = 'Anaza Dimenshon'
  storage.combo2 = 'Destruicao Mental'
  storage.combo3 = 'Galaxian Explosion'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Myu [Papillon]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Ugly Eruption'
  storage.combo2 = 'Shirukii Suredo'
  storage.combo3 = 'Encantamento Mortal'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Po Dourado'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Orfeu [Lira]') then
  storage.elemento = 'Water'
  storage.combo1 = 'Acorde Noturno'
  storage.combo2 = 'Serenata Da Viagem Da Morte'
  storage.combo3 = 'Acorde Perfeito'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = nil
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Tremy [Flecha]') then
  storage.elemento = 'Wind'
  storage.combo1 = 'Flechas Fantasmas'
  storage.combo2 = 'Phantom Arrows'
  storage.combo3 = 'Fantomu Aro'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Disparo Mortal'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hades [Deus]') then
    storage.elemento = 'Dark'
  storage.combo1 = 'Yami Raitoningu'
  storage.combo2 = 'Naraku No Seiken'
  storage.combo3 = 'Greatest Eclipse'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Divine Execution'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Athena [Deusa]') then
    storage.elemento = 'Light'
  storage.combo1 = 'Divine Justice'
  storage.combo2 = 'Judgment Of Athena'
  storage.combo3 = 'Sacred Light'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Deusa Da Guerra'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Pegasus Divino]') then
    storage.elemento = 'Light'
  storage.combo1 = 'Divino Meteoro De Pegasus'
  storage.combo2 = 'Divino Cometa De Pegasus'
  storage.combo3 = 'Divino Turbilhao De Pegasus'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Aniquilacao Divina De Pegasus'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end


if player:getTitle() == ('Aiolia [Odin]') then
  storage.elemento = 'Light'
  storage.combo1 = 'Raios De Valhalla'
  storage.combo2 = 'Lamina De Sleipnir'
  storage.combo3 = 'Tempestade De Asgard'
  storage.combo4 = 'ultimate ' .. storage.elemento --contelação:  ' .. storage.elemento --contelação:  Gemeos Divino'
  storage.sspell = nil
  storage.ultimate = 'Aniquilacao Divina De Pegasus'
  storage.sense = 'sense'
  info('Load: ' .. player:getTitle())
end

end)





configmode = false
onKeyDown(function(keys)
  if keys == 'Ctrl+4' then
    if configmode == false then
      configmode = true
      info('Config: True')
    end
  end
  if keys == 'Ctrl+5' then
    if configmode then
      configmode = false
      info('Config: False')
    end
  end
  if configmode then
    if keys == 'Ctrl+0' then
    say(player:getTitle())
    end
  end
end)