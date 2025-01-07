setDefaultTab("Main")

schedule(1000, function()

  if player:getTitle() == ('Seiya [Pegasus]') then
 storage.combo1 = 'Meteoro De Pegasus'
 storage.combo2 = 'Cometa De Pegasus'
 storage.combo3 = 'Turbilhao de Pegasus'
 storage.combo4 = 'ultimate pegasus'
 storage.ultimate = 'ataque de pegasus'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne]') then
 storage.combo1 = 'Po de Diamante'
 storage.combo2 = 'Trovao Aurora Ataque'
 storage.combo3 = 'Execucao Aurora'
 storage.combo4 = 'ultimate cisne'
 storage.ultimate = 'circulo de gelo celestial'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao]') then
 storage.combo1 = 'Colera do Dragao'
 storage.combo2 = 'Dragao Voador'
 storage.combo3 = 'Last Dragon'
 storage.combo4 = 'ultimate dragon'
 storage.ultimate = 'life strengthening'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda]') then
 storage.combo1 = 'Nebulosa de Andromeda'
 storage.combo2 = 'Onda Relampago'
 storage.combo3 = 'Correnteza Nebulosa'
 storage.combo4 = 'ultimate andromeda'
 storage.ultimate = 'corrente circular'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix]') then
 storage.combo1 = 'Ave Fenix'
 storage.combo2 = 'Golpe de Fenix'
 storage.combo3 = 'Hoyoku Tensho'
 storage.combo4 = 'ultimate fenix'
 storage.ultimate = 'golpe fantasma de fenix'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mascara da Morte [Cancer]') then
 storage.combo1 = 'akubensu'
 storage.combo2 = 'sekishiki meikai'
 storage.combo3 = 'sekishiki kisoen'
 storage.combo4 = 'ultimate cancer'
 storage.ultimate = 'ondas do inferno'
 storage.sspell = 'yomotsu shield'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mu [Aries]') then
 storage.combo1 = 'Rede de Cristal'
 storage.combo2 = 'Extincao Estelar'
 storage.combo3 = 'Revolucao Estelar'
 storage.combo4 = 'ultimate aries'
 storage.sspell = 'create repair hammer'
 storage.ultimate = 'muralha de cristal'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Camus [Aquario]' or player:getTitle() == 'Camus Renegado [Aquario]') then
  storage.combo1 = 'Esquife de Gelo'
  storage.combo2 = 'circulo de gelo'
  storage.combo3 = 'Daiyamondo Dasuto'
  storage.combo4 = 'ultimate aquario'
  storage.sspell = nil
  storage.ultimate = 'Esquife de Gelo Supremo'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Daichi [Terra]') then
 storage.combo1 = 'Suchiiru hariken'
 storage.combo2 = 'Steek Hurricane'
 storage.combo3 = 'Furacao de Aco'
 storage.combo4 = 'ultimate terra'
 storage.sspell = nil
 storage.ultimate = 'stone wall'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ushio [Mar]') then
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate mar'
 storage.sspell = nil
 storage.ultimate = 'cosmo consumption'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sho [Ceu]') then
 storage.combo1 = 'suchiiru hariken'
 storage.combo2 = 'steek hurricane'
 storage.combo3 = 'furacao de aco'
 storage.combo4 = 'ultimate ceu'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol [Perseu]') then
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate perseu'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algol Renegado [Perseu]') then
 storage.combo1 = 'Gorgona Demoniaca'
 storage.combo2 = 'Rhas Al Ghul Gorgoneion'
 storage.combo3 = 'Gorgona Maligna'
 storage.combo4 = 'ultimate perseu'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro') then
 storage.combo1 = 'Cosmo Punch'
 storage.combo2 = 'Cosmo Impact'
 storage.combo3 = 'Cosmo Galaxy'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ichi [Hidra]') then
 storage.combo1 = 'Presas Venenosas'
 storage.combo2 = 'Chute Maravilhoso de Hydrus'
 storage.combo3 = 'Ataque das Mil Presas de Hydrus'
 storage.combo4 = 'ultimate hidra'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ban [Leao Menor]') then
 storage.combo1 = 'Ataque Explosivo do Leao'
 storage.combo2 = 'Lionet Bomber'
 storage.combo3 = 'Raionetto Bonba'
 storage.combo4 = 'ultimate leao menor'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jabu [Unicornio]') then
 storage.combo1 = 'Galope do Unicornio'
 storage.combo2 = 'Golpe do Unicornio'
 storage.combo3 = 'Fuku Yunikon'
 storage.combo4 = 'ultimate unicornio'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Nachi [Lobo]') then
 storage.combo1 = 'Punho Do Lobo'
 storage.combo2 = 'Uivo Mortal'
 storage.combo3 = 'Shi no toboe'
 storage.combo4 = 'ultimate lobo'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Geki [Urso]') then
 storage.combo1 = 'punho de urso'
 storage.combo2 = 'abraco do urso'
 storage.combo3 = 'kuma no hoyo'
 storage.combo4 = 'ultimate urso'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('June [Camaleao]') then
 storage.combo1 = 'Punho De Camaleao'
 storage.combo2 = 'Chicote do Camaleao'
 storage.combo3 = 'Kamereon no muchi'
 storage.combo4 = 'ultimate camaleao'
 storage.sspell = nil
 storage.ultimate = 'poder curativo "' .. player:getName()
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Guarda Graad') then
 storage.combo1 = 'Graad Punch'
 storage.combo2 = 'Graad Impact'
 storage.combo3 = 'Graad Blast'
 storage.combo4 = 'ultimate graad'
 storage.sspell = nil
 storage.ultimate = 'last cartridge'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses [Baleia]') then
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate baleia'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cassius') then
 storage.combo1 = 'Cassius Punch'
 storage.combo2 = 'Cassius Impact'
 storage.combo3 = 'Cassius Comet Punch'
 storage.combo4 = 'ultimate ear'
 storage.sspell = nil
 storage.ultimate = 'stay away'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kenuma [Pegasus Negro]') then
 storage.combo1 = 'meteoro negro'
 storage.combo2 = 'cometa negro'
 storage.combo3 = 'turbilhao negro'
 storage.combo4 = 'ultimate pegasus negro'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ritahoa [Fenix Negro]') then
 storage.combo1 = 'Ankoku Houou Genma Ken'
 storage.combo2 = 'Espirito Diabolico do Fenix Negro'
 storage.combo3 = 'Ankoku Houou Hoyoku Tensho'
 storage.combo4 = 'ultimate fenix negro'
 storage.sspell = nil
 storage.ultimate = 'assalto negro'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Umnamed [Andromeda Negro]') then
 storage.combo1 = 'corrente negra'
 storage.combo2 = 'black fang nebula'
 storage.combo3 = 'ankoku fang nebulosa'
 storage.combo4 = 'ultimate andromeda negro'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jido [Cisne Negro]') then
 storage.combo1 = 'po de diamante das trevas'
 storage.combo2 = 'nevasca das trevas'
 storage.combo3 = 'burakkuburizodo'
 storage.combo4 = 'ultimate cisne negro'
 storage.sspell = nil
 storage.ultimate = nil
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Minos [Griffon]') then
 storage.combo1 = 'papusa cosmica'
 storage.combo2 = 'griffon strike'
 storage.combo3 = 'marionete cosmica'
 storage.combo4 = 'ultimate griffon'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Cavaleiro [Cristal]') then
 storage.combo1 = 'po de cristal'
 storage.combo2 = 'golpe congelante'
 storage.combo3 = 'toketsu ken'
 storage.combo4 = 'ultimate cristal'
 storage.sspell = nil
 storage.ultimate = nil
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ennetsu [Fogo]') then
 storage.combo1 = 'poder do fogo'
 storage.combo2 = 'fire screw'
 storage.combo3 = 'faiya sukuryu'
 storage.combo4 = 'ultimate fogo'
 storage.sspell = nil
 storage.ultimate = nil
 info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Serpente Marinha [Fantasma]') then
 storage.combo1 = 'Punho da Serpente Marinha'
 storage.combo2 = 'Phantom Sea Serpent'
 storage.combo3 = 'Sea Serpent Eruption'
 storage.combo4 = 'ultimate serpente marinha'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Docrates [Hydrus]') then
 storage.combo1 = 'poder de hercules'
 storage.combo2 = 'punho de hercules'
 storage.combo3 = 'heracles moo shuu ken'
 storage.combo4 = 'ultimate hydrus'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shura Renegado [Capricornio]' or 'Shura [Capricornio]') then
 storage.combo1 = 'Pedra Saltitante'
 storage.combo2 = 'Excalibur'
 storage.combo3 = 'Shinken ekusukariba'
 storage.combo4 = 'ultimate capricornio'
 storage.sspell = nil
 storage.ultimate = 'excalibur sword'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dante [Cerberus]') or player:getTitle() == ('Dante Renegado [Cerberus]') then
 storage.combo1 = 'Maca Infernal'
 storage.combo2 = 'Jigoku no Kokyusa'
 storage.combo3 = 'Maca Vital'
 storage.combo4 = 'ultimate cerberus'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Asterion [Caes de Caca]') then
 storage.combo1 = 'ataque de um milhao de fantasmas'
 storage.combo2 = 'mirion gosuto atakku'
 storage.combo3 = 'explosao telepatica'
 storage.combo4 = 'ultimate caes'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Jamian [Corvo]') then
 storage.combo1 = 'pluma negra'
 storage.combo2 = 'black wing shaft'
 storage.combo3 = 'black feather'
 storage.combo4 = 'ultimate corvo'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio [Mosca]') then
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate mosca'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolia [Leao]') then
 storage.combo1 = 'Capsula do Poder'
 storage.combo2 = 'Lightning Bolt'
 storage.combo3 = 'Relampago de Plasma'
 storage.combo4 = 'ultimate leao'
 storage.sspell = nil
 storage.ultimate = 'golpe violento do leao'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aldebaran [Touro]') then
 storage.combo1 = 'Grande Chifre'
 storage.combo2 = 'Gureto Hon'
 storage.combo3 = 'Great Horn'
 storage.combo4 = 'ultimate touro'
 storage.sspell = nil
 storage.ultimate = 'grande chifre de ouro'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dohko [Libra]') then
 storage.combo1 = 'rozan shoryuha'
 storage.combo2 = 'rozan hyaku ryu ha'
 storage.combo3 = 'colera dos cem dragoes'
 storage.combo4 = 'ultimate libra'
 storage.sspell = nil
 storage.ultimate = 'rejuvenescimento'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Aiolos [Sagitario]') then
 storage.combo1 = 'Flecha de Sagitario'
 storage.combo2 = 'Trovao Atomico'
 storage.combo3 = 'Atomikku Sandaaboruto'
 storage.combo4 = 'ultimate sagitario'
 storage.sspell = nil
 storage.ultimate = 'flecha de ouro'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Milo [Escorpiao]') then
 storage.combo1 = 'agulha escarlate'
 storage.combo2 = 'sukaretto nidoru antaresu'
 storage.combo3 = 'agulha escarlate de antares'
 storage.combo4 = 'ultimate escorpiao'
 storage.sspell = nil
 storage.ultimate = 'ferroada mortal'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Moses Renegado [Baleia]') then
 storage.combo1 = 'kaitos spouding'
 storage.combo2 = 'kaitos spouding bomber'
 storage.combo3 = 'forca explosiva de kaitos'
 storage.combo4 = 'ultimate baleia'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate centauro'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Babel Renegado [Centauro]') then
 storage.combo1 = 'Turbilhao de Chamas'
 storage.combo2 = 'Photia Roufihtra'
 storage.combo3 = 'Chamas de Babel'
 storage.combo4 = 'ultimate centauro'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shaka [Virgem]') then
 storage.combo1 = 'ohm'
 storage.combo2 = 'kahn'
 storage.combo3 = 'rendicao divina'
 storage.combo4 = 'ultimate virgem'
 storage.sspell = nil
 storage.ultimate = 'tesouro do ceu'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Capella [Auriga]') then
 storage.combo1 = 'discos mortais'
 storage.combo2 = 'saucer kogeki'
 storage.combo3 = 'ripping saucers'
 storage.combo4 = 'ultimate auriga'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiva [Pavao]') then
 storage.combo1 = 'golpe dos mil bracos'
 storage.combo2 = 'senju shinon ken'
 storage.combo3 = 'thousand arms coup'
 storage.combo4 = 'ultimate pavao'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Farao [Esfinge]') then
 storage.combo1 = 'balanca da maldicao'
 storage.combo2 = 'baransu obu kasu'
 storage.combo3 = 'beijo na escuridao'
 storage.combo4 = 'ultimate esfinge'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Dio Renegado [Mosca]') then
 storage.combo1 = 'voo mortal'
 storage.combo2 = 'deddo endo furai'
 storage.combo3 = 'dead end fly'
 storage.combo4 = 'ultimate mosca'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Misty [Lagarto]') then
 storage.combo1 = 'Furacao das Trevas'
 storage.combo2 = 'Mavrou Trypa'
 storage.combo3 = 'Dark Hurricane'
 storage.combo4 = 'ultimate lagarto'
 storage.sspell = nil
 storage.ultimate = 'paredao de ar'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite Renegado [Peixes]') then
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Afrodite [Peixes]') then
 storage.combo1 = 'Rosas Diabolicas'
 storage.combo2 = 'Rosas Piranhas'
 storage.combo3 = 'Rosa Sangrenta'
 storage.combo4 = 'ultimate peixes'
 storage.ultimate = 'Rosas Diabolicas Reais'
 storage.sspell = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Thetis [Sereia]') then
 storage.combo1 = 'cilada de coral'
 storage.combo2 = 'death trap coral'
 storage.combo3 = 'coral deslumbrante'
 storage.combo4 = 'ultimate sereia'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth [Hercules]') then
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate hercules'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Algeth Renegado [Hercules]') then
 storage.combo1 = 'Poder Supremo de Hercules'
 storage.combo2 = 'Korunehorosu'
 storage.combo3 = 'Kornephoros'
 storage.combo4 = 'ultimate hercules'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Marin [Aguia]') then
 storage.combo1 = 'Meteoro'
 storage.combo2 = 'Lampejo da Aguia'
 storage.combo3 = 'Iguru Tou Furasshu'
 storage.combo4 = 'ultimate aguia'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shina [Ofiuco]') then
 storage.combo1 = 'Garras de Trovao'
 storage.combo2 = 'Sanda Kuron'
 storage.combo3 = 'Venha Cobra'
 storage.combo4 = 'ultimate ofiuco'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Fenrir [Alioth]') then
 storage.combo1 = 'garra do lobo assassino'
 storage.combo2 = 'golpe do lobo imortal'
 storage.combo3 = 'immortal wolf explosion'
 storage.combo4 = 'ultimate alioth'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Alberich [Megrez]') then
 storage.combo1 = 'Couraca Ametista'
 storage.combo2 = 'Espada de Fogo'
 storage.combo3 = 'Unidade da Natureza'
 storage.combo4 = 'ultimate megrez'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bado [Alcor]') then
 storage.combo1 = 'garras do tigre das sombras'
 storage.combo2 = 'shadow viking tiger claw'
 storage.combo3 = 'garras do tigre viking tiranico das sombras'
 storage.combo4 = 'ultimate alcor'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shido [Mizar]') then
 storage.combo1 = 'Garras do Tigre Negro'
 storage.combo2 = 'Viking Tiger Claw'
 storage.combo3 = 'Impulso Azul'
 storage.combo4 = 'ultimate mizar'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saga [Maligno]') then
 storage.combo1 = 'Outra Dimensao'
 storage.combo2 = 'Sata Imperial'
 storage.combo3 = 'Explosao Galactica'
 storage.combo4 = 'ultimate maligno'
 storage.sspell = nil
 storage.ultimate = 'dimensao galactica'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Mime [Benetnasch]') then
 storage.combo1 = 'requiem de cordas'
 storage.combo2 = 'sutoringa rekuiemu'
 storage.combo3 = 'stringer requiem'
 storage.combo4 = 'ultimate benetnasch'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Siegfried [Dubhe]') then
 storage.combo1 = 'odin sodo'
 storage.combo2 = 'odin sword'
 storage.combo3 = 'dragon bravest blizzard'
 storage.combo4 = 'ultimate dubhe'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Divino]') then
 storage.combo1 = 'Po de Diamante Divino'
 storage.combo2 = 'Trovao Aurora Ataque Divino'
 storage.combo3 = 'Divina Execucao Aurora '
 storage.combo4 = 'ultimate cisne divino'
 storage.sspell = nil
 storage.ultimate = 'Execucao Aurora Divina'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Odin]') then
 storage.combo1 = 'meteoro de odin'
 storage.combo2 = 'cometa de odin'
 storage.combo3 = 'balmung'
 storage.combo4 = 'ultimate odin'
 storage.sspell = nil
 storage.ultimate = 'balmung reaper'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Aquario]') then
 storage.combo1 = 'po de diamante'
 storage.combo2 = 'aniquilacao aurora'
 storage.combo3 = 'aurora destruction'
 storage.combo4 = 'ultimate aquario'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Isaak [Kraken]') then
 storage.combo1 = 'aurora boreal'
 storage.combo2 = 'aurora borealis'
 storage.combo3 = 'diamond dust'
 storage.combo4 = 'ultimate kraken'
 storage.sspell = nil
 storage.ultimate = 'balmung reaper'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Ikki [Fenix Divino]') then
 storage.combo1 = 'ave fenix divina'
 storage.combo2 = 'golpe de fenix divina'
 storage.combo3 = 'hoyoku tensho divina'
 storage.combo4 = 'ultimate fenix divina'
 storage.sspell = nil
 storage.ultimate = 'lenda fenix'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shiryu [Dragao Divino]') then
 storage.combo1 = 'colera do dragao divino'
 storage.combo2 = 'divine excalibur'
 storage.combo3 = 'divino colera dos cem dragoes'
 storage.combo4 = 'ultimate dragao divino'
 storage.sspell = nil
 storage.ultimate = 'colera dos cem dragoes de rozan'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Sorento [Sirene]') then
 storage.combo1 = 'sinfonia da morte'
 storage.combo2 = 'sinfonia final da morte'
 storage.combo3 = 'climax final da morte'
 storage.combo4 = 'ultimate sirene'
 storage.sspell = nil
 storage.ultimate = 'canto da sirene'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Saori [Athena]') then
 storage.combo1 = 'hikari uchu kosen'
 storage.combo2 = 'hikari seiken'
 storage.combo3 = 'hikari cosmo sword'
 storage.combo4 = nil
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Sagitario]') then
 storage.combo1 = 'pegasus ryu sei ken'
 storage.combo2 = 'sagittarius ogon no ya'
 storage.combo3 = 'cosmic star arrow'
 storage.combo4 = 'ultimate sagitario'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Hyoga [Cisne Celeste]') then
 storage.combo1 = 'po de diamante celeste'
 storage.combo2 = 'trovao aurora celeste'
 storage.combo3 = 'execucao aurora celeste'
 storage.combo4 = 'ultimate cisne celeste'
 storage.sspell = nil
 storage.ultimate = 'execucao celeste'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Rock [Golem]') then
 storage.combo1 = 'avalanche explosiva'
 storage.combo2 = 'roringu bonba suton'
 storage.combo3 = 'bomber stone'
 storage.combo4 = 'ultimate golem'
 storage.sspell = nil
 storage.ultimate = 'avalanche devastadora'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Kagaho [Benu]') then
 storage.combo1 = 'explosao de coroa solar'
 storage.combo2 = 'sol negro'
 storage.combo3 = 'chamas negras'
 storage.combo4 = 'ultimate benu'
 storage.sspell = nil
 storage.ultimate = 'explosao da coroa solar'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Krishna [Chrysaor]') then
 storage.combo1 = 'flashing lance'
 storage.combo2 = 'maha roshini'
 storage.combo3 = 'lanca relampago'
 storage.combo4 = 'ultimate chrysaor'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Bian [Cavalo Marinho]') then
 storage.combo1 = 'assopro divino'
 storage.combo2 = 'goddo buresu'
 storage.combo3 = 'raijingu birouzu'
 storage.combo4 = 'ultimate cavalo marinho'
 storage.sspell = nil
 storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Radamanthys [Wyvern]') then
  storage.combo1 = 'gureitesuto koshon'
  storage.combo2 = 'greatest caution'
  storage.combo3 = 'destruicao maxima'
  storage.combo4 = 'ultimate wyvern'
  storage.sspell = nil
  storage.ultimate = 'flying wyvern'
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Shun [Andromeda Divino]') then
  storage.combo1 = 'nebulosa de andromeda divina'
  storage.combo2 = 'tempestade nebulosa divina'
  storage.combo3 = 'divino correnteza nebulosa'
  storage.combo4 = 'ultimate andromeda divino'
  storage.sspell = nil
  storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Seiya [Pegasus Celeste]') then
  storage.combo1 = 'meteoro de pegasus astral'
  storage.combo2 = 'cometa de pegasus astral'
  storage.combo3 = 'turbilhao de pegasus astral'
  storage.combo4 = 'ultimate pegasus celeste'
  storage.sspell = nil
  storage.ultimate = nil
  info('Load: ' .. player:getTitle())
end

if player:getTitle() == ('Zelos [Sapo]') then
  storage.combo1 = 'salto esmagador'
  storage.combo2 = 'pulverizador de veneno'
  storage.combo3 = 'muco assombroso'
  storage.combo4 = 'ultimate sapo'
  storage.sspell = nil
  storage.ultimate = 'jumping smash'
  info('Load: ' .. player:getTitle())
end

end)

onKeyDown(function(keys)
if keys == 'Ctrl+0' then
 say(player:getTitle())
end
end)