require_relative './likes'

ARTICLE_VARIANTS = [
  "{\"blocks\":[{\"key\":\"bq47q\",\"text\":\"Article Variant 1\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":17,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"9je7k\",\"text\":\"Subtitle 1\",\"type\":\"header-three\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":10,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"92bug\",\"text\":\"Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":341,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"5igqo\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"6aqov\",\"text\":\"Subtitle 2\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":10,\"style\":\"color-rgba(0,0,0,0.85)\"},{\"offset\":0,\"length\":10,\"style\":\"bgcolor-rgb(253,253,253)\"},{\"offset\":0,\"length\":10,\"style\":\"fontsize-16.38\"},{\"offset\":0,\"length\":10,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"ef8mi\",\"text\":\"At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It va esser tam simplic quam Occidental in fact, it va esser Occidental.\",\"type\":\"blockquote\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":367,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"7qn07\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"4qs91\",\"text\":\"Subtitle 3\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":10,\"style\":\"color-rgba(0,0,0,0.85)\"},{\"offset\":0,\"length\":10,\"style\":\"bgcolor-rgb(253,253,253)\"},{\"offset\":0,\"length\":10,\"style\":\"fontsize-16.38\"},{\"offset\":0,\"length\":10,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"deeti\",\"text\":\"A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es. Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation e li plu commun vocabules. Omnicos directe al desirabilite de un nov lingua franca: On refusa continuar payar custosi traductores.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":449,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"aog1t\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"bcdct\",\"text\":\"Subtitle 4\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":10,\"style\":\"color-rgba(0,0,0,0.85)\"},{\"offset\":0,\"length\":10,\"style\":\"bgcolor-rgb(253,253,253)\"},{\"offset\":0,\"length\":10,\"style\":\"fontsize-16.38\"},{\"offset\":0,\"length\":10,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"ecll8\",\"text\":\"At solmen va esser necessi far uniform grammatica, pronunciation e plu sommun paroles. Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It va esser tam simplic quam Occidental in fact, it va esser Occidental. A un Angleso it va semblar un simplificat Angles, quam un skeptic Cambridge amico dit me que Occidental es. Li Europan lingues es membres del sam familie. Lor separat existentie es un myth. Por scientie, musica, sport etc, litot Europa usa li sam vocabular. Li lingues differe solmen in li grammatica, li pronunciation\",\"type\":\"code\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":686,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}",
  "{\"blocks\":[{\"key\":\"bq47q\",\"text\":\"Article Variant 2\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"dnrm4\",\"text\":\"Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia.\",\"type\":\"blockquote\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":309,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"a3o6u\",\"text\":\"It is a paradisematic country, in which roasted parts of sentences fly into your mouth. Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":308,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"cr8g0\",\"text\":\"The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn’t listen. She packed her seven versalia, put her initial into the belt and made herself on the way.\",\"type\":\"code\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":256,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"7ro8c\",\"text\":\"When she reached the first hills of the Italic Mountains, she had a last view back on the skyline of her hometown Bookmarksgrove, the headline of Alphabet Village and the subline of her own road, the Line Lane. Pityful a rethoric question ran over her cheek, then she continued her way. On her way she met a copy.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":313,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"32lp2\",\"text\":\"The copy warned the Little Blind Text, that where it came from it would have been rewritten a thousand times and everything that was left from its origin would be the word \\\"and\\\" and the Little Blind Text should turn around and return to its own, safe country. But nothing the copy said could convince her and so it didn’t take long until a few insidious Copy Writers ambushed her, made her drunk with Longe and Parole and dragged her into their agency, where they abused her for their projects again and again.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":510,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"dm99m\",\"text\":\"And if she hasn’t been rewritten, then they are still using her. Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":462,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"3h3am\",\"text\":\"Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar. The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn’t listen. She packed her seven versalia, put her initial into the belt and made herself on the way.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":477,\"style\":\"fontfamily-Arial\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}}],\"entityMap\":{}}",
  "{\"blocks\":[{\"key\":\"bq47q\",\"text\":\"Article Variant 3\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{\"text-align\":\"justify\"}},{\"key\":\"8aikg\",\"text\":\"The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox. Bright vixens jump; dozy fowl quack. Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. Sex-charged fop blew my junk TV quiz.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":408,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":408,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":408,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{}},{\"key\":\"avmj8\",\"text\":\"How quickly daft jumping zebras vex. Two driven jocks help fax my big quiz. Quick, Baz, get my woven flax jodhpurs! \\\"Now fax quiz Jack! \\\" my brave ghost pled. Five quacking zephyrs jolt my wax bed. Flummoxed by job, kvetching W. zaps Iraq. Cozy sphinx waves quart jug of bad milk. A very bad quack might jinx zippy fowls. Few quips galvanized the mock jury box. Quick brown dogs jump over the lazy fox.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":402,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":402,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":402,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"d5p0j\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"5v0ea\",\"text\":\" \",\"type\":\"atomic\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[{\"offset\":0,\"length\":1,\"key\":0}],\"data\":{}},{\"key\":\"5nie8\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"asbci\",\"text\":\"The jay, pig, fox, zebra, and my wolves quack! Blowzy red vixens fight for a quick jump. Joaquin Phoenix was gazed by MTV for luck. A wizard’s job is to vex chumps quickly in fog. Watch \\\"Jeopardy! \\\", Alex Trebek's fun TV quiz game. Woven silk pyjamas exchanged for blue quartz. Brawny gods just flocked up to quiz and vex him. Adjusting quiver and bow, Zompyc[1] killed the fox.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":378,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":378,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":378,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"5553i\",\"text\":\"My faxed joke won a pager in the cable TV quiz show. Amazingly few discotheques provide jukeboxes. My girl wove six dozen plaid jackets before she quit. Six big devils from Japan quickly forgot how to waltz. Big July earthquakes confound zany experimental vow. Foxy parsons quiz and cajole the lovably dim wiki-girl. Have a pick: twenty six letters - no forcing a jumbled quiz!\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":377,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":377,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":377,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"1m691\",\"text\":\"Crazy Fredericka bought many very exquisite opal jewels. Sixty zippers were quickly picked from the woven jute bag. A quick movement of the enemy will jeopardize six gunboats. All questions asked by five watch experts amazed the judge. Jack quietly moved up front and seized the big ball of wax. The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":411,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":411,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":411,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"1l723\",\"text\":\"Bawds jog, flick quartz, vex nymphs. Waltz, bad nymph, for quick jigs vex! Fox nymphs grab quick-jived waltz. Brick quiz whangs jumpy veldt fox. Bright vixens jump; dozy fowl quack. Quick wafting zephyrs vex bold Jim. Quick zephyrs blow, vexing daft Jim. Sex-charged fop blew my junk TV quiz. How quickly daft jumping zebras vex. Two driven jocks help fax my big quiz. Quick, Baz, get my woven flax jodhpurs!\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":408,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":408,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":408,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"b94mm\",\"text\":\"\\\"Now fax quiz Jack! \\\" my brave ghost pled. Five quacking zephyrs jolt my wax bed. Flummoxed by job, kvetching W. zaps Iraq. Cozy sphinx waves quart jug of bad milk. A very bad quack might jinx zippy fowls. Few quips galvanized the mock jury box. Quick brown dogs jump over the lazy fox. The jay, pig, fox, zebra, and my wolves quack! Blowzy red vixens fight for a quick jump. Joaquin Phoenix was gazed by MTV for luck.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":418,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":418,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":418,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"au5d2\",\"text\":\"A wizard’s job is to vex chumps quickly in fog. Watch \\\"Jeopardy! \\\", Alex Trebek's fun TV quiz game. Woven silk pyjamas exchanged for blue quartz. Brawny gods just flocked up to quiz and vex him. Adjusting quiver and bow, Zompyc[1] killed the fox. My faxed joke won a pager in the cable TV quiz show. Amazingly few discotheques provide jukeboxes. My girl wove six dozen plaid jackets before she quit.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":399,\"style\":\"color-rgb(102,102,102)\"},{\"offset\":0,\"length\":399,\"style\":\"bgcolor-rgb(255,255,255)\"},{\"offset\":0,\"length\":399,\"style\":\"fontsize-14\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}}],\"entityMap\":{\"0\":{\"type\":\"IMAGE\",\"mutability\":\"MUTABLE\",\"data\":{\"src\":\"https://upload.wikimedia.org/wikipedia/commons/4/4c/Jacques_Louis_David_-_Bonaparte_franchissant_le_Grand_Saint-Bernard%2C_20_mai_1800_-_Google_Art_Project.jpg\",\"height\":\"640px\",\"width\":\"400px\",\"alignment\":\"none\"}}}}",
]

def create_articles!(options)
  puts 'Creating articles...'

  all_user_ids = User.all.pluck(:id)
  all_majors = Major.all

  options[:amount].times do |index|
    major = rand <= options[:majors_proportion] ? all_majors.sample : nil
    author_id = major ? major.users.sample.id : all_user_ids.sample

    category_list = Category.all
                            .sample(options[:max_categories_per])
                            .pluck(:name)
                            .join(', ')

    article = Article.create!(
      major: major,
      title: "#{index}-#{Faker::Lorem.sentence(2)}",
      short_description: Faker::Lorem.paragraph(3),
      content: ARTICLE_VARIANTS.sample,
      author_id: author_id,
      category_list: category_list
    )

    likers_ids = all_user_ids.sample(rand(options[:max_likes_per]))
    add_likes_to(article, likers_ids)
  end
end
