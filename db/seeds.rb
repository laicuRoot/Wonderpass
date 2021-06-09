# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'json'
require "open-uri"

locations = [{name: "Durdle Door", description: "Durdle Door is probably the most famous stone arch anywhere in the world. It was created when the sea pierced through the Portland limestone around 10,000 years ago.", category: "Natural", location_pic: "https://upload.wikimedia.org/wikipedia/commons/6/64/Durdle_Door_Overview.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Seven Sisters", description: "Situated in the South Downs National Park, the Seven Sisters Country Park is made up of 280 hectares of chalk cliffs, meandering river valley and open chalk grassland. It is a popular place for a number of outdoor activities including walking, bird watching, cycling, canoeing and paddle boarding.", category: "Natural", location_pic: "https://media-cdn.tripadvisor.com/media/photo-s/06/1b/ac/df/seven-sisters-country.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Cheddar Gorge", description: "Cheddar Gorge is one of England's most iconic and spectacular landscapes. At almost 400 feet deep and three miles long, this is England’s largest gorge, and with its weathered crags and pinnacles, one of our most spectacular natural sights.", category: "Natural", location_pic: "https://mowgli-adventures.com/wp-content/uploads/2016/05/Cheddar-Gorge-walks.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Giant’s Causeway", description: "The Giant’s Causeway and Causeway Coast is a spectacular area of global geological importance on the sea coast at the edge of the Antrim plateau in Northern Ireland. The most characteristic and unique feature of the site is the exposure of some 40,000 large, regularly shaped polygonal columns of basalt in perfect horizontal sections, forming a pavement. Celebrated in the arts and in science, it has been a visitor attraction for at least 300 years and has come to be regarded as a symbol for Northern Ireland.", category: "Natural", location_pic: "https://www.thegiantscausewaytour.com/wp-content/uploads/2019/01/The-Giants-Causeway-Story-M.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Ben Nevis", description: "Ben Nevis, the highest mountain in the UK is located behind the Highland town of Fort William. It is arguably the most popular mountain for walking and climbing in the UK.", category: "Natural", location_pic: "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Ftimes%2Fprod%2Fweb%2Fbin%2Fa17b5a52-574d-11ea-ae40-36d0719ad0bc.jpg?crop=3648%2C2052%2C0%2C190&resize=1180", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Snowdon", description: "Snowdon is the highest mountain in Wales and England. It's one of our most famous and regonizable landmarks and is well worth a visit.", category: "Natural", location_pic: "https://upload.wikimedia.org/wikipedia/commons/6/6c/Snowdon_massif.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Titanic Belfast", description: "Located beside the Titanic Slipways, the Harland and Wolff Drawing Offices and Hamilton Graving Dock – the very place where Titanic was designed, built and launched in 1912, Titanic Belfast tells the story of the Titanic, from her conception in Belfast in the early 1900s, through her construction and launch, to its maiden voyage and subsequent place in history.", category: "Historical", location_pic: "https://s3.visitbelfast.com/app/uploads/2019/05/Titanic-Belfast-visitors_1557863289.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Cotswolds", description: "The Cotswolds covers a huge area – almost 800 square miles – and runs through five counties (Gloucestershire, Oxfordshire, Warwickshire, Wiltshire and Worcestershire). One of the delights of visiting the Cotswolds is exploring the different areas, each with its own identity, yet all with those defining Cotswold features: golden stone and rolling hills, the ‘wolds’.", category: "Natural", location_pic: "https://www.telegraph.co.uk/content/dam/Travel/Destinations/Europe/United%20Kingdom/Cotswolds/cotswolds-village-main-cotswolds-destination-guide.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Stonehenge", description: "For centuries, historians and archaeologists have puzzled over the many mysteries of Stonehenge, the prehistoric monument that took Neolithic builders an estimated 1,500 years to erect. Located in southern England, it is comprised of roughly 100 massive upright stones placed in a circular layout.", category: "Historical", location_pic: "https://mymodernmet.com/wp/wp-content/uploads/2019/06/facts-about-stonehenge-thumbnail-1.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "The Roman Baths", description: "Constructed in around 70AD as a grand bathing and socialising complex, the Roman Baths is one of the best-preserved Roman remains in the world, where 1,170,000 litres of steaming spring water, reaching 46°C, still fills the bathing site every single day.", category: "Historical", location_pic: "https://eu-assets.simpleview-europe.com/greatwestway/imageresizer/?image=%2Fdmsimgs%2F15DF7DB6350B304065A8386E152439D04CAF1881.jpg&action=ProductDetailProFullWidth", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Big Ben", description: "Big Ben is a tower clock known for its accuracy and for its massive hour bell. Strictly speaking, the name refers only to the bell, which weighs 15.1 tons (13.7 metric tons), but it is commonly associated with the whole clock tower at the northern end of the Houses of Parliament, in the London borough of Westminster. ", category: "Historical" , location_pic: "https://cdn.londonandpartners.com/visit/london-organisations/big-ben/100225-640x360-elisabeth-tower-clock-face-640.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"} ,{name: "London Eye", description: "The London Eye, or the Millennium Wheel, is a cantilevered observation wheel on the South Bank of the River Thames in London. It is Europe's tallest cantilevered observation wheel, and is the most popular paid tourist attraction in the United Kingdom with over 3 million visitors annually. It has made many appearances in popular culture.", category: "Historical", location_pic: "https://offloadmedia.feverup.com/secretldn.com/wp-content/uploads/2020/10/31034412/London-eye-pumpkin-scaled.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Houses of Parliament", description: "The Palace of Westminster serves as the meeting place for both the House of Commons and the House of Lords, the two houses of the Parliament of the United Kingdom. ", category: "Historical", location_pic: "https://cdn.britannica.com/s:800x450,c:crop/25/139425-138-050505D0/consideration-London-Houses-of-Parliament.jpg" , stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "St Paul's Cathedral ", description: "The cathedral is one of the most famous and most recognisable sights of London. Its dome, framed by the spires of Wren's City churches, has dominated the skyline for over 300 years. At 365 feet (111 m) high, it was the tallest building in London from 1710 to 1963. The dome remains among the highest in the world. ", category: "Historical", location_pic: "https://media.timeout.com/images/105603344/630/472/image.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Tower Bridge ", description: "Tower Bridge is famous because it's London's most striking bridge thanks to its Neo-Gothic architecture and lifting central sections. When it opened, it was the most sophisticated bascule bridge in the world.", category: "Historical", location_pic: "https://mywowo.net/media/images/cache/londra_tower_bridge_01_introduzione_jpg_1200_630_cover_85.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Buckingham Palace ", description: "Buckingham Palace is the London residence and administrative headquarters of the monarch of the United Kingdom. Located in the City of Westminster, the palace is often at the centre of state occasions and royal hospitality. It has been a focal point for the British people at times of national rejoicing and mourning. ", category: "Historical" , location_pic: "https://cdn.londonandpartners.com/asset/buckingham-palace-buckingham-palace-photographer-andrew-holt-ba2d2924f687e5713154dbf611c103e1.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Portobello Road ", description: "Portobello Road is a street in the Notting Hill district of the Royal Borough of Kensington and Chelsea in west London. It runs almost the length of Notting Hill from south to north, roughly parallel with Ladbroke Grove. On Saturdays it is home to Portobello Road Market, one of London's notable street markets, known for its second-hand clothes, pastries and antiques. Every August since 1996, the Portobello Film Festival has been
 held in locations around Portobello Road and in 2015, Portobello Radio was founded as the area's community radio station.", category: "Historical", location_pic: "https://afar-production.imgix.net/uploads/images/post_images/images/1kTejHayqa/original_712ce552b54fd2fdd8ed4cb8057731c0.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},
 {name: "Trafalgar Square ", description: "Trafalgar Square is one of the most important and bustling squares in London: designed in 1830 to commemorate the British victory against the French and Spanish fleets in the Battle of Trafalgar. In the centre of the square is Nelson’s Column, built in 1843 in honour of Admiral Lord Nelson, shot and killed in action as commander in chief of the British army in the battle of Trafalgar.", category: "Historical", location_pic: "https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/27/5f/a2.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "The Tower of London ", description: "The Tower of London is a 900-year-old castle and fortress in central London that is notable for housing the crown jewels and for holding many famous and infamous prisoners. ", category: "Historical", location_pic: "https://evanevanstours.com/blog/wp-content/uploads/2019/12/tower-of-london.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Greenwich Observatory", description: "The Royal Observatory Greenwich is most famous as the home of the Prime Meridian. It’s basically a longitudinal (north-south) marker, representing Longitude 0. Every place on earth could be measured in terms of its distance east or west from the Prime Meridian. This was hugely beneficial when it came to mapping the night sky, with separate observation points able to be recorded in terms of their distance from the Prime Meridian. ", category: "Historical", location_pic: "https://cdn.londonandpartners.com/asset/royal-observatory-greenwich_see-the-time-ball-drop-at-1pm-daily-image-courtesy-of-the-royal-observatory-greenwich_5b30f693aedad7721ae7d10a09ce921f.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},
 {name:"Hyde Park", description:"Hyde Park is a Grade I-listed major park in Central London. It is the largest of four Royal Parks that form a chain from the entrance of Kensington Palace through Kensington Gardens and Hyde Park, via Hyde Park Corner and Green Park past the main entrance to Buckingham Palace", category:"Natural", location_pic: "https://imgs-akamai.mnstatic.com/a7/0d/a70d993a72c150ad723a9ff1522d3a86.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Green Park", description:"The Green Park, usually known without the definite article simply as Green Park, is one of the Royal Parks of London. It is in the southern part – the core part – of the City of Westminster, Central London, but before that zone was extended to the north, to take in Marylebone and Paddington it lay in its north-centre.", category:"Natural", location_pic:"https://www.royalparks.org.uk/parks/green-park/things-to-see-and-do/memorials,-fountains-and-statues/canada-gate/_gallery/Canada-Gate-and-the-memorial-gardens.jpg/w_1200.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png" },{name: "Richmond Park", description:"Richmond Park, in the London Borough of Richmond upon Thames, was created by Charles I in the 17th century as a deer park. The largest of London's Royal Parks, it is of national and international importance for wildlife conservation", category:"Natural", location_pic:"http://www.montcalmlondonmarblearch.co.uk/blog/wp-content/uploads/2017/04/shutterstock_240895507.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png" },{name: "Trent Park", description:"Trent Park is an English country house, together with its former extensive grounds, in north London. The original great house and a number of statues and other structures located within the grounds are Grade II listed buildings", category: "Natural", location_pic:"https://www.telegraph.co.uk/content/dam/property/2018/05/31/TELEMMGLPICT000164392771_trans_NvBQzQNjv4Bq9-zn32UdN-2qebTEmhS1ZchKDu3GQk7WOwEY0CqJhkw.jpeg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "National History Museum", description:"The Natural History Museum in London is a natural history museum that exhibits a vast range of specimens from various segments of natural history. It is one of three major museums on Exhibition Road in South Kensington, the others being the Science Museum and the Victoria and Albert Museum.", category:"Cultural", location_pic:"https://upload.wikimedia.org/wikipedia/commons/7/76/Entrance_to_Natural_History_Museum%2C_Cromwell_Road%2C_London_SW7_-_geograph.org.uk_-_1034304.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png" },{name: "Victoria and Albert Museum", description:"The Victoria and Albert Museum in London is the world's largest museum of applied and decorative arts and design, as well as sculpture, housing a permanent collection of over 2.27 million objects. It was founded in 1852 and named after Queen Victoria and Prince Albert.", category:"Cultural", location_pic:"https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/VictoriaAlbert2_small.jpg/512px-VictoriaAlbert2_small.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "Tate London", description:"Tate is an institution that houses, in a network of four art galleries, the United Kingdom's national collection of British art, and international modern and contemporary art. It is not a government institution, but its main sponsor is the UK Department for Digital, Culture, Media and Sport", category:"Cultural", location_pic:"https://cdn.britannica.com/39/136939-050-4EFA1B8D/Tate-Modern-London.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name: "British Museum", description:"The British Museum, in the Bloomsbury area of London, England, is a public institution dedicated to human history, art and culture. Its permanent collection of some eight million works is among the largest and most comprehensive in existence, having been widely collected during the era of the British Empire", category:"Cultural", location_pic:"https://offloadmedia.feverup.com/secretldn.com/wp-content/uploads/2018/04/18142807/British-Museum-22.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Tate Britain", description:"Tate Britain, known from 1897 to 1932 as the National Gallery of British Art and from 1932 to 2000 as the Tate Gallery, is an art museum on Millbank in the City of Westminster in London. It is part of the Tate network of galleries in England, with Tate Modern, Tate Liverpool and Tate St Ives.", category:"Cultural", location_pic:"https://www.tate.org.uk/sites/default/files/styles/width-600/public/tate-britain-millbank-entrance-cyclists-passing_2.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png" },{name: "National Gallery", description:"The National Gallery is an art museum in Trafalgar Square in the City of Westminster, in Central London. Founded in 1824, it houses a collection of over 2,300 paintings dating from the mid-13th century to 1900.", category:"Cultural", location_pic:"https://cdn.londonandpartners.com/asset/national-gallery_the-national-gallery-trafalgar-square-image-courtesy-of-the-national-gallery_6f4aadb5504ea5d216bd00c8e6214995.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png" },{name: "Wembley Stadium", description:"The new Wembley was the largest stadium in Great Britain at the time of its opening in 2007, with a seating capacity of 90,000.", category:"Sports", location_pic:"https://atlanta-mp7static.mlsdigital.net/styles/image_landscape/s3/images/Wembley%20Stadium%20Big.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"National Football Museum", description:"The National Football Museum is England's national museum of football. It is based in the Urbis building in Manchester city centre, and preserves, conserves and displays important collections of football memorabilia.", category:"Sports", location_pic:"https://www.performanceelectrical.co.uk/wp-content/uploads/2017/07/national-football-museum-1-1000x450.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Lord's Cricket Ground", description:"Lord's Cricket Ground, commonly known as Lord's, is a cricket venue in St John's Wood, London. Named after its founder, Thomas Lord, Lord's is the home of the MCC Museum, which is the oldest sports museum in the world, and contains the world's most celebrated collection of cricket memorabilia, including The Ashes urn.", category:"Sports", location_pic:"https://www.burohappold.com/wp-content/uploads/2019/08/Lords_00_MCC.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},
 {name:"Rugby School", description:"Steeped in fascinating history and positively crammed with old world charm, a tour of Rugby School and its museum is not to be missed. Top of many international visitors’ ‘must–see’ venues in the UK, the impressive school buildings and hallowed rugby ground alone never fail to impress. In fact, there’s so much to see, a tour of the school’s highlights takes an hour and-a half with one of our knowledgeable and enthusiastic guides.", category:"Sports", location_pic:"https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Rugby_School_850.jpg/800px-Rugby_School_850.jpg", stamp_pic: "https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Wimbledon Tennis Museum", description:"Wimbledon Lawn Tennis Museum is the largest tennis museum in the world. The museum was inaugurated at The Championships centenary event in 1977. ", category:"Sports", location_pic:"https://www.ianvisits.co.uk/blog/wp-content/uploads/2018/03/wimbledon-tennis-museum.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},
 {name:"Le Cordon Bleu London", description:"Le Cordon Bleu London is the leading culinary arts, wine and management school in Great Britain since 1931. Considered as the guardian of French culinary techniques, it offers comprehensive training for chefs and managers in the food and hospitality industries.", category:"Culinary", location_pic:"https://media-cdn.tripadvisor.com/media/photo-s/02/96/58/b5/filename-building-jpg.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Beefeater Distillery", description:"Housed in an Edwardian building with a 1950s extension, the Beefeater Distillery features original Victorian pot stills and a botanical room, where the fresh ingredients are stored. A custom-built visitor centre allows connoisseurs to see the original stills, view the distilling process and learn about the history of gin in London.", category:"Culinary", location_pic:"https://www.thespiritsbusiness.com/content/http://www.thespiritsbusiness.com/media/2018/05/Beefeater-main.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Black Friars Distillery", description:"Black Friars Distillery, the working home of Plymouth Gin since 1793, is the oldest working gin distillery in England and is situated in the heart of the historic port city of Plymouth. The building also features a lofty roof-timbered public cocktail lounge in the historic Refectory on the first floor and an adjoining popular restaurant.", category:"Culinary", location_pic:"https://www.devonguide.com/sites/default/files/photos/plymouth_gin.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"Rock and Sole Plaice", description:"The oldest fish and chip shop in London, Rock & Sole Plaice is in the heart of Covent Garden. Founded way back in 1871 on Endell Street, it was the third fish shop ever opened in London and has been a part of the city for almost 150 years. Its basement room served as a meeting place for community volunteers to plan where provisions would be distributed to displaced people during the Blitz in WWII", category:"Culinary", location_pic:"https://crummbs.co.uk/wp-content/uploads/2017/08/RockSolPlaice_02-1024x683.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"},{name:"The Spaniards Inn", description:"The Spaniards Inn is a pub that is most definitely steeped in history. It was built in 1585, as a toll-gate at the then boundary of Finchley and the Bishop of London's Estate.", category:"Culinary", location_pic:"https://www.thespaniardshampstead.co.uk/content/dam/castle/pub-images/thespaniardshampstead/thespaniardshampstead-gallery1.jpg", stamp_pic:"https://www.pikpng.com/pngl/m/123-1236563_20-red-empty-stamp-vector-transparent-background-fact.png"}]


url = 'https://randomuser.me/api/?results=5'
users_serialized = URI.open(url).read
users = JSON.parse(users_serialized)
stamp_url = {"https://source.unsplash.com/random?badges"}

puts 'Cleaning DB'
Location.destroy_all
User.destroy_all
puts 'DB is clean'
puts 'Creating Locations'

locations.each do |location|
	puts "Creating #{location[:name]}"
  location_pic = URI.open(location[:location_pic])
	sleep 5
	stamp_pic = URI.open(stamp_url)
  place = Location.new(
    location_name: location[:name],
    location_description: location[:description],
    category: location[:category].capitalize
	)
  place.location_photos.attach(io: location_pic, filename: "location_pic-#{location[:name]}.png", content_type: "image/png")
  place.stamp_photos.attach(io: stamp_pic, filename: "stamp_pic-#{location[:name]}.png", content_type: "image/png")
  place.save!
  puts "#{place.location_name} has been created"
end

puts 'Creating Users'
users['results'].each do |user|
	file = URI.open(user["picture"]["large"])
	user_new = User.new(
		email: user["email"],
		password: Faker::Internet.password(min_length: 7),
		first_name:user["name"]["first"],
		last_name:user["name"]["last"],
		username: user["login"]["username"]
	)
  user_new.photo.attach(io: file, filename: 'user_pic.png', content_type: 'image/png')
  user_new.save!
	puts "#{user_new.username} created"
	stampbook = Stampbook.new(stampbook_name: "Top Wonders of the UK", stampbook_description: "Collect stamps for the major attractions in the UK")
	stampbook.user = user_new
	stampbook.save!
	puts "#{stampbook.stampbook_name} is created"
	places = Location.all
	places.each do |place|
		stamp = Stamp.new(
			location: place,
			stampbook: stampbook
		)
		stamp.save!
		puts "#{stamp.location.location_name} stamp is created!"
	end
end
