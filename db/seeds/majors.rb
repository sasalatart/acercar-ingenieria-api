require_relative './uploads'

def create_majors!(options)
  puts 'Creating majors...'

  @majors.each do |key, data|
    @majors[key] = Major.create!(data)

    min_users_per = options[:majors][:min_users_per]
    max_users_per = options[:majors][:max_users_per]
    users_in_major = min_users_per + rand(max_users_per - min_users_per)
    @majors[key].users << User.all.sample(users_in_major)

    next unless @major_questions[key]

    @major_questions[key].each do |major_data|
      Question.create!(major_data.merge(major: @majors[key], author_id: 1))
    end
  end
end

@majors = {}

@majors[:ciencias_ambientales] = {
  name: 'Ciencias Ambientales',
  description: Faker::Lorem,
  short_description: 'El Major en Ciencias Ambientales desarrolla la '\
                     'capacidad de evaluar la sustentabilidad y predecir el '\
                     'impacto de las actividades antropogénicas, proponiendo '\
                     'soluciones a las problemáticas ambientales.',
  video_url_code: 'p4F2LEFXpQ8',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ciencias_ambientales', 'png')
}

@majors[:computacion] = {
  name: 'Computación',
  description: Faker::Lorem,
  short_description: 'El Major en Computación desarrolla la capacidad de '\
                     'aplicar soluciones a problemas complejos de la '\
                     'industria, desarrollando proyectos innovadores '\
                     'mediante el diseño y modelación de procesos '\
                     'computacionales.',
  video_url_code: 'NFUkXwYSgPA',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'computacion', 'png')
}

@majors[:geociencias] = {
  name: 'Geociencias',
  description: Faker::Lorem,
  short_description: 'Los Licenciados en Ciencias de la Ingeniería con Major '\
                     'en Geociencias estarán capacitados para trabajar en '\
                     'equipos multidisciplinarios con interacción entre las '\
                     'Geociencias y las áreas de Ingeniería.',
  video_url_code: 'tJNrrxo4FW4',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'geociencias', 'png')
}

@majors[:ing_ambiental] = {
  name: 'Ingeniería Ambiental',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Ambiental desarrolla la '\
                     'capacidad de proteger y administrar nuestros recursos '\
                     'naturales, incluyendo el aire, el agua y las fuentes '\
                     'de energía.',
  video_url_code: 'pwv8CtOpN_8',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_ambiental', 'png')
}

@majors[:ing_arquitectura] = {
  name: 'Ingeniería y Arquitectura',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería y Arquitectura desarrolla la '\
                     'capacidad de diseñar e implementar procesos de diseño '\
                     'y construcción más fluidos, factibles y sustentables.',
  video_url_code: 'nS2r7bE2qt8',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'ing_arquitectura', 'png')
}

@majors[:ing_biologica] = {
  name: 'Ingeniería Biológica',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Biológica desarrolla la '\
                     'capacidad de entender cómo funcionan los sistemas '\
                     'biológicos y aplicar este conocimiento, tanto a la '\
                     'solución de problemas, como al desarrollo de '\
                     'tecnologías eficientes inspiradas en la biología.',
  video_url_code: 'GxExEaTPVoA',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'ing_biologica', 'png')
}

@majors[:ing_biomedica] = {
  name: 'Ingeniería Biomédica',
  description: Faker::Lorem,
  short_description: 'Este Major desarrolla la capacidad de aplicar '\
                     'soluciones innovadoras a problemas de la salud humana. '\
                     'Además, les permite articular sus conocimientos para '\
                     'desempeñarse en diversos proyectos, pudiendo así '\
                     'solucionar problemas de complejos a través de la '\
                     'formulación y aplicación de modelos matemáticos.',
  video_url_code: 'AjfGBVzbmA0',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'ing_biomedica', 'png')
}

@majors[:ing_civil] = {
  name: 'Ingeniería Civil',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Civil desarrolla la capacidad de '\
                     'aplicar específicamente fundamentos de Ingeniería Civil '\
                     'a la determinación de oportunidades y problemáticas '\
                     'actuales de diseño y ejecución que impactan el '\
                     'desarrollo de proyectos y obras de infraestructura.',
  video_url_code: 'F4IigtLR1Ag',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_civil', 'png')
}

@majors[:ing_construccion] = {
  name: 'Ingeniería de Construcción',
  description: Faker::Lorem,
  short_description: 'El Major en Diseño de Sistemas de Construcción '\
                     'desarrolla la capacidad de planificar y administrar '\
                     'las fases del desarrollo de obras de construcción.',
  video_url_code: 'ytfexTyTCwA',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_construccion', 'png')
}

@majors[:ing_diseno_innovacion] = {
  name: 'Ingeniería, Diseño e Innovación',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería, Diseño e Innovación prepara a '\
                     'sus alumnos para identificar y enfrentar los problemas '\
                     'que afectan a la sociedad, detectando oportunidades '\
                     'para diseñar e implementar propuestas centradas en el '\
                     'usuario bajo el alero de la innovación y el '\
                     'emprendimiento.',
  video_url_code: 'cl6JsUoEkLc',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'ing_diseno_innovacion', 'png')
}

@majors[:ing_electrica] = {
  name: 'Ingeniería Eléctrica',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Eléctrica desarrolla la '\
                     'capacidad de analizar los problemas de la Ingeniería '\
                     'Eléctrica y/o Electrónica como sistemas complejos, '\
                     'estudiando no sólo sus partes individuales, sino '\
                     'también sus interacciones.',
  video_url_code: 'bh8btllzGZU',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_electrica', 'png')
}

@majors[:ing_estructural] = {
  name: 'Ingeniería Estructural',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Estructural desarrolla la '\
                     'capacidad de participar en el análisis y diseño '\
                     'estructural de obras civiles.',
  video_url_code: 'jpbxuxlXwis',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_estructural', 'png')
}

@majors[:ing_geotecnica] = {
  name: 'Ingeniería Geotécnica',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Geotécnica desarrolla la '\
                     'capacidad de solucionar problemas relacionados con el '\
                     'comportamiento de suelos y rocas, y con la interacción '\
                     'que existe entre estos materiales y distintas obras de '\
                     'infraestructura.',
  video_url_code: 'JOSrqwek3jg',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_geotecnica', 'png')
}

@majors[:ing_hidraulica] = {
  name: 'Ingeniería Hidráulica',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Hidráulica desarrolla la '\
                     'capacidad de caracterizar y modelar el comportamiento '\
                     'del agua y otros fluidos en sistemas naturales y '\
                     'artificiales.',
  video_url_code: 'FgKtmUTbLvM',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_hidraulica', 'png')
}

@majors[:ing_matematica] = {
  name: 'Ingeniería Matemática',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Matemática desarrolla la '\
                     'capacidad de solucionar problemas complejos mediante el '\
                     'uso de matemáticas de alto nivel.',
  video_url_code: 'mbXFnRepnss',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'ing_matematica', 'png')
}

@majors[:ing_mecanica] = {
  name: 'Ingeniería Mecánica',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Mecánica desarrolla la capacidad '\
                     'de diseñar, fabricar y mantener diversos sistemas '\
                     'mecánicos.',
  video_url_code: 'y3J264gptEg',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_mecanica', 'png')
}

@majors[:ing_quimica] = {
  name: 'Ingeniería Química',
  description: Faker::Lorem,
  short_description: 'El Major en Ingeniería Química desarrolla la capacidad '\
                     'de diseñar procesos para la producción, transformación '\
                     'y transporte de químicos, bioquímicos, energía y '\
                     'materiales.',
  video_url_code: 'tXiJ_uzXfXk',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'ing_quimica', 'png')
}

@majors[:investigacion_operativa] = {
  name: 'Investigación Operativa',
  description: Faker::Lorem,
  short_description: 'El Major en Investigación Operativa desarrolla la '\
                     'capacidad de modelar y resolver problemas de asignación '\
                     'de recursos (humanos, financieros y materiales) desde '\
                     'una perspectiva crítica y sistémica.',
  video_url_code: 'syAglylSd7c',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'investigacion_operativa', 'png')
}

@majors[:mineria] = {
  name: 'Minería',
  description: Faker::Lorem,
  short_description: 'El Major en Minería desarrolla la capacidad de '\
                     'desempeñarse de manera efectiva en el ámbito de la '\
                     'explotación y operaciones mineras.',
  video_url_code: '6Mmrb8ZqDGY',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'mineria', 'png')
}

@majors[:sistemas_autonomos_roboticos] = {
  name: 'Sistemas Autónomos y Robóticos',
  description: Faker::Lorem,
  short_description: 'El Major en Sistemas Autónomos y Robóticos desarrolla '\
                     'la capacidad de construir y aplicar dispositivos y '\
                     'software en la automatización avanzada de instrumentos, '\
                     'máquinas y procesos productivos complejos, integrando '\
                     'conocimientos de Ingeniería Mecánica, Eléctrica y '\
                     'Computacional.',
  video_url_code: 'QBdDwVH8s3g',
  category: :interdisciplinary,
  logo: create_uploaded_image('major_logos', 'sistemas_autonomos_roboticos', 'png')
}

@majors[:sistemas_transporte] = {
  name: 'Sistemas de Transporte',
  description: Faker::Lorem,
  short_description: 'El Major en Sistemas de Transporte desarrolla la '\
                     'capacidad de desempeñarse en los ámbitos específicos '\
                     'del diseño, operación y gestión de sistemas de '\
                     'transporte.',
  video_url_code: 'erXWL6zBJ30',
  category: :disciplinary,
  logo: create_uploaded_image('major_logos', 'sistemas_transporte', 'png')
}

@major_questions = {
  sistemas_transporte: [{
    question: '¿Qué perfil de alumno se busca en este Major?',
    answer: 'Los problemas de transporte son de gran tamaño y complejidad por '\
            'lo que los alumnos deben ser capaces de lidear con problemas '\
            'complejos. Para poder modelar estos problemas son importantes '\
            'las habilidades computacionales y la capacidad de modelamiento.'\
            "\r\nPor otro lado, los problemas de transporte son "\
            'multidisciplinarios, por lo que se espera que los alumnos sean '\
            'capaces de trabajar con personas de distintos contextos y '\
            'disciplinas con seguridad. Los alumnos también deben ser fuertes '\
            'en estadísticas, investigación operativa, optimización, '\
            'economía, además de saber utilizar computador y contar con '\
            'capacidades analíticas.'
  }, {
    question: '¿Cuáles son las áreas de investigación asociadas al Major?',
    answer: 'Las líneas con más prestigio y tradicionales son dos. Existe la '\
           'línea de modelos de de demanda, los sistemas de transporte '\
           'cuentan con unidades que deciden por sí mismos, por lo que es muy '\
           'importante comprender como las personas toman decisiones, '\
           'entender su comportamiento y predecirlo lo mejor posible. Otra '\
           'línea tradicional es el diseño de sistemas de transporte y '\
           'ecuaciones de equilibrio, esta se dedica a estudiar cómo '\
           'responderán los sistemas ante los distintos requerimientos, por '\
           'ejemplo, el fenómeno de la congestión, la capacidad en los buses, '\
           'etc.'\
           "\r\nExisten otras líneas de investigación como modelos de "\
           'tráfico, comportamiento de vehículos, intersecciones, '\
           'externalidades de contaminación y accidentes, transporte aéreo, '\
           'transporte público y transporte inteligente. El departamento '\
           'también tiene un área de logística que trabaja en conjunto con el '\
           'departamento de Ingeniería Industrial y de Sistemas, se ve el '\
           'transporte de carga, líneas de producción, logística reversa, '\
           'entre otros temas más.'
  }],
  ing_matematica: [{
    question: '¿Con qué título puedo articular si sigo este Major?',
    answer: 'La más sencilla es el programa de Ingeniero Civil de Industria '\
            'con Especialidad en Ingeniería Matemática, pero también se puede '\
            'articular con otras especialidades dependiendo del minor que se '\
            'eligió. En general la articulación es bastante amplia, debido a '\
            'que las herramientas que da este Major se pueden usar en '\
            'múltiples áreas de la ingeniería.'
  }, {
    question: '¿En qué áreas puedo trabajar si sigo este Major?',
    answer: 'El alumno que termina este Major se podrá insertar en áreas tan '\
            'distintas como mercado financiero, simulación de procesos de '\
            'transporte, dispositivos biomédicos, etc. El campo es bastante '\
            'amplio.'
  }, {
    question: '¿Qué áreas de investigación hay en este Major?',
    answer: 'Las áreas de investigación son muy amplias. Van desde resultados '\
            'teóricos (como teoremas), hasta el estudio de la implementación '\
            'de técnicas y simulaciones para resolver un problema.'
  }],
  ciencias_ambientales: [{
    question: '¿Qué perfil de alumno se busca en este Major?',
    answer: 'Una de las cosas que se espera de los alumnos de este Major es '\
            'que tengan una mente abierta para aprender de distintos campos, '\
            'y que tengan en esta amplitud de conocimientos y de campos '\
            'tengan la vocación necesaria para profundizar en cosas que sean '\
            'de su interés.'
  }, {
    question: '¿Cuál es la diferencia entre Ingeniería Ambiental y Ciencias '\
              'Ambientales?',
    answer: 'La diferencia entre estos Majors tiene que ver con el ámbito de '\
            'aplicación y la formación que se recibe a través de los cursos. '\
            'El Major de ciencias ambientales está más orientado a ver y '\
            'evaluar la sustentabilidad. No se tiene un enfoque de producir '\
            'soluciones tecnológicas, sino más bien uno de producir '\
            'información que luego permita tomar decisiones que apunten hacia '\
            'la sustentabilidad.'
  }, {
    question: '¿Dónde puedo trabajar con una licenciatura en ciencias '\
              'ambientales?',
    answer: 'Hay un rango bien amplio donde se puede trabajar, partiendo por '\
            'el sector público. Aquí se necesita que, en las políticas '\
            'públicas, se incorpore gente que entienda la mecánica del medio '\
            'ambiente. Los ministerios y la labor pública se presentan como '\
            'lugares donde se podría trabajar solo con la licenciatura, sin '\
            'la necesidad de obtener el título.'
  }],
  computacion: [{
    question: '¿Qué perfil de alumno se busca para este Major?',
    answer: 'Se busca preparar alumnos a nivel de ser un investigador, '\
            'desarrollador y gestor de la tecnología computacional moderna. '\
            'Por ejemplo de la web, la robótica, las aplicaciones móviles, la '\
            'minería, los juegos de video, etc. Se busca reforzar el '\
            'aprendizaje de los conceptos, modelos y técnicas que se les '\
            'enseñan a los alumnos con el desarrollo de proyectos prácticos '\
            'reales.'
  }, {
    question: '¿Con qué título se puede articular este Major?',
    answer: 'Este Major se puede articular de preferencia con los títulos '\
            'profesionales de:'\
            "\r\n\r\n- Ingeniería Civil en Computación: Está más asociado con "\
            'la ciencia y la tecnología de la computación.'\
            "\r\n- Ingeniería Civil de Industria con Diploma en Computación: "\
            'Está más orientado al desarrollo de aplicaciones y la ingeniería '\
            'de software.'\
            "\r\n- Ingeniería Civil de Industria con Diploma en Ingeniería de "\
            'Tecnologías de la Información (TI): Va orientado a las '\
            'tecnologías de la información en las organizaciones.'\
            "\r\n\r\nEl Major le sirve exactamente igual a estos tres títulos "\
            'profesionales.'
  }, {
    question: '¿Cómo es el campo laboral?',
    answer: 'Hay muchos alumnos que se han dedicado al emprendimiento, ellos '\
            'iniciaron sus propias empresas de servicios computacionales y '\
            'desarrollo de software. Después están las empresas que tienen '\
            'grandes áreas de informática como las líneas aéreas, los bancos, '\
            'retail, etc. Luego están las empresas que sí son desarrolladoras '\
            'de software, como Google, Microsoft, Amazon, etc. Estas han '\
            'venido a buscar alumnos de la universidad para emplearlos.'
  }, {
    question: '¿Cuáles son las diferencias con el Major de Sistemas Autónomos '\
    'y Robóticos?',
    answer: 'El Major de Sistemas Autónomos y Robóticos es una mezcla entre '\
            'los Major de Ingeniería Robótica, Ingeniería Mecánica y Ciencias '\
            'de la Computación, por lo que no se hace un énfasis en cosas '\
            'como el desarrollo de software, en la teoría detrás del '\
            'desarrollo del software o en las bases de datos. Más bien hace '\
            'un énfasis en cómo aplicar ciertos aspectos del desarrollo de '\
            'software a la robótica y a la automatización. Sin embargo, los '\
            'egresados del Major de sistemas autónomos y robóticos también '\
            'pueden optar a los títulos en computación.'
  }],
  ing_diseno_innovacion: [{
    question: '¿Qué habilidades entrega este Major?',
    answer: 'El alumno que termina este Major adquirirá principalmente dos '\
            'tipos de habilidades prácticas. Primero aprenderá Procesos, lo '\
            'que permite al estudiante lidiar con problemas actuales, '\
            'asesorar y trabajar con información que desembocan en proyectos '\
            'concretos en diferentes áreas; tales como sistemas, plataformas, '\
            'procesos y productos, además de técnicas de prototipado.'\
            "\r\nTambién adquirirá habilidades en cuanto al Emprendimiento "\
            'dentro del campo laboral, o bien inter-emprendimiento formando '\
            'nuevas áreas dentro de una empresa. Además aprenderá a trabajar '\
            'con personas para lograr innovar.'
  }, {
    question: '¿Cómo es el campo laboral si salgo de este Major?',
    answer: 'En Chile son requeridas personas que cumplan con el perfil '\
            'entregado en el Major, principalmente en consultoras de '\
            'innovación, consultoras de procesos y departamentos de Resources '\
            'Development que se están creando dentro de las empresas. '\
            'Actualmente en el país no son tan requeridos como en el '\
            'extranjero por lo que se recomienda comenzar a formar redes '\
            'desde los primeros años de estudio.'
  }, {
    question: '¿Con qué título puedo articular si sigo este Major?',
    answer: 'Este Major no conduce a titulación, por lo que se debe tomar un '\
            'minor que sí lo haga. El Major contiene “tracks” de mecánica, '\
            'TI, diseño, y uno mixto (Ingeniería-Diseño) los cuáles facilitan '\
            'el cambio a algunas de estas áreas.'
  }, {
    question: '¿Qué perfil de alumno busca este Major?',
    answer: 'Busca alumnos con liderazgo, comprometidos y dinámicos en las '\
            'clases. Éste Major cuenta con una postulación donde se evaluará '\
            'si se cumple con el perfil.'
  }],
  ing_construccion: [{
    question: '¿Cuál es el perfil de alumno que se busca para este Major?',
    answer: 'Se busca que el alumno sea inquieto por mejorar lo que hoy día '\
            'existe en el ámbito de la construcción, por usar competencias de '\
            'diseño para hacer más profesional y más eficiente esa industria. '\
            'Al mismo tiempo también se busca que sea inquieto en '\
            'emprendimiento, que esté en busca de oportunidades y nuevos '\
            'desarrollos para emprender en un ámbito tan rico como es la '\
            'construcción.'
  }, {
    question: '¿Con qué títulos profesionales se puede articular este Major?',
    answer: 'Los más directos son los títulos de Ingeniero Civil en '\
            'Ingeniería y Gestión de la Construcción o Ingeniero Industrial '\
            'en Ingeniería y Gestión de la Construcción. Sin embargo, igual '\
            'se puede articular con cualquier otra especialidad civil, solo '\
            'que esto podría significar invertir algunos cursos adicionales.'
  }, {
    question: '¿Cómo es el campo laboral?',
    answer: 'Este Major les permite a los alumnos trabajar en distintos '\
            'ámbitos. Por ejemplo se puede trabajar en una constructora, ya '\
            'que tienen conocimientos en ámbitos como la planificación, '\
            'materiales, estructuras, etc. También pueden trabajar en una '\
            'consultora, porque tienen una visión amplia de distintos '\
            'aspectos para el estudio de nuevos proyectos. Tienen '\
            'conocimientos de Ingeniería Ambiental, planificación e '\
            'Ingeniería en Construcción, por lo que tienen una visión más '\
            'completa para el estudio de proyectos.'
  }],
  ing_estructural: [{
    question: '¿Dónde puedo trabajar si sigo este Major?',
    answer: 'Un estudiante que haya terminado el Major puede trabajar en '\
            'Oficinas de Ingenieria que se preocupen del diseño y '\
            'construcción de obras civiles, tanto nacionales como '\
            'internacionales. También puede participar en consultoras de '\
            'ingeniería, minería u obras públicas.'
  }, {
    question: '¿Cuáles son las áreas de investigación asociadas al Major?',
    answer: 'La principal preocupación de la Ing. estructural es el diseño '\
            'sísmico de las estructuras, debido a que Chile se expone '\
            'constantemente a estas situaciones, lo cual permite probar '\
            'nuevas tecnologías y verificar el comportamiento de las '\
            'estructuras.'
  }],
  ing_mecanica: [{
    question: '¿Para qué labores quedan capacitados los alumnos que egresen '\
              'de este Major?',
    answer: 'La ingeniería mecánica en Chile tiene mucho que ver con el '\
            'montaje de sistemas productivos y su mantención, con sistemas de '\
            'conversión de energía y, también, con lo que tiene que ver con '\
            'materiales. El Major de mecánica cubre estas áreas en tres '\
            'líneas: '\
            "\r\n\r\n- Diseño mecánico/diseño mecatrónico"\
            "\r\n- Sistemas técnicos de energía"\
            "\r\n- Manufactura y producción de productos y materiales"
  }, {
    question: '¿Dónde se desempeñan los egresados del área de mecánica?',
    answer: 'Los egresados de este departamento se han empleado en labores '\
            'diversas dentro del ámbito de la producción. Por ejemplo: '\
            'montaje de sistemas productivos, reparación de estos sistemas, '\
            'etc. Hay muchos egresados que se emplean en áreas de mantención, '\
            'producción o de gerencia operativa.'
  }, {
    question: '¿Cuáles son los desafíos de la Ingeniería Mecánica en Chile?',
    answer: 'Chile no es un país que no fabrica automóviles, aviones o '\
            'barcos. Aquí hay un desafío para los futuros alumnos de mecánica '\
            'para que ellos sean los futuros emprendedores en PYMEs que '\
            'apunten al desarrollo de productos de esta naturaleza.'
  }],
  sistemas_autonomos_roboticos: [{
    question: '¿Qué oportunidades de emprendimiento existen en esta área?',
    answer: 'En Chile la robótica está un poco atrasada con respecto a otros '\
            'países, en ese sentido hay mucho potencial para seguir '\
            'creciendo. Hay alumnos de la universidad que ya han empezado a '\
            'emprender en este tema.'
  }, {
    question: '¿Cuáles son las áreas de investigación asociadas a este Major?',
    answer: 'Hay múltiples áreas de investigación en robótica debido a las '\
            'distintas aplicaciones que esta puede tener. En la PUC se están '\
            'estudiando principalmente manipuladores móviles. Hay temas de la '\
            'robótica que aún no están resueltos y todos estos presentan una '\
            'oportunidad para avanzar.'
  }, {
    question: '¿Es necesario tomar el curso exploratorio "Introduccion a la '\
              'Robótica"?',
    answer: 'Este curso es un curso de fundamentos de la robótica, el cual '\
            'establece las bases de este Major, por lo que sí es necesario '\
            'hacerlo. En este caso el curso cumple un rol dual de '\
            'exploratorio y de fundamentos.'
  }, {
    question: '¿Con qué título profesional puedo articular si tomo este Major?',
    answer: 'Este Major está diseñado para articular de la mejor manera con '\
            'los títulos de Ingeniero Civil en Computación e Ingeniero Civil '\
            'Electricista. La idea es que en el futuro también se pueda '\
            'lograr una mejor articulación con el Ingeniero Civil Mecánico. '\
            'La robótica es un área en la cual convergen estas tres '\
            'disciplinas.'
  }],
  ing_ambiental: [{
    question: '¿Se le da mucho énfasis a la química en este Major?',
    answer: 'Se deben integrar distintas disciplinas y, en este sentido, la '\
            'química es parte de esta necesidad. Se utiliza la química pero '\
            'de forma aplicada a distintas disciplinas.'
  }, {
    question: '¿Cuál es el campo laboral para quienes salen de este Major?',
    answer: 'Hay campo en la industria privada, en el área de la búsqueda de '\
            'minimización de impacto ambiental en la producción, y en '\
            'consultorías, asesorando a otros en el mismo tema. En áreas de '\
            'servicios, a la hora de operar plantas de distinto tipo y '\
            'finalmente, en el sector público, trabajando en políticas '\
            'públicas en variados sectores que buscan minimizar el impacto '\
            'ambiental.'
  }, {
    question: '¿Qué áreas de investigación existen actualmente en este Major?',
    answer: 'Celdas de combustible para generar energía desde los residuos. '\
            'En geoquímica ambiental, está la geoquímica urbana, relacionada '\
            'con los riesgos ambientales a los que las personas están '\
            'expuestos según donde viven y la geoquímica de los ríos, que '\
            'analiza cómo se comportan los contaminantes y cómo llegan a las '\
            'distintas fuentes de agua.'
  }],
  ing_quimica: [{
    question: '¿Con qué títulos profesionales puedo articular si elijo este '\
              'Major?',
    answer: 'En primer lugar, en Ingeniería Civil en Industrias, con dos '\
            'Títulos distintos, Industrial mención Química y mención '\
            'Bioprocesos. Son posibles otras articulaciones que pueden llevar '\
            'a obtener el Título de Ingeniero Civil en Biotecnología o '\
            'Ingeniero Civil Ambiental.'
  }, {
    question: '¿En qué áreas puedo trabajar al egresar con este Major?',
    answer: 'En cualquier tipo de empresas productivas, consultoras o '\
            'gubernamentales que se relacionen con la producción química, '\
            'tratamiento de residuos, producción de agua potable, problemas '\
            'relacionados con el ambiente, medicina, minería, productos '\
            'cosméticos y farmacéuticos, entre muchas otras áreas.'
  }, {
    question: '¿Cuáles son las áreas de investigación de los profesores de '\
              'esta área?',
    answer: 'Alimentos, ingeniería ambiental, biotecnología, biomateriales, '\
            'productos naturales y modelamiento.'
  }, {
    question: '¿Cómo se diferencia con otros Majors?',
    answer: 'Este Major tiene énfasis en balances de masa, balances de '\
            'energía y en procesos de equilibrio fisicoquímico y fenómenos de '\
            'transporte. En su aplicación, se centra en el diseño de procesos '\
            'de separación y reacción química.'
  }, {
    question: '¿Cuál es el perfil del alumno de este Major?',
    answer: 'Se buscan alumnos que tengan alto compromiso por la disciplina y '\
            'que busquen trabajar por mejorar la industria y el bienestar '\
            'general de la población. Pueden tener habilidades '\
            'computacionales o de laboratorio, ambos son bienvenidos mientras '\
            'tengan ganas de trabajar.'
  }],
  ing_biologica: [{
    question: '¿Por qué elegir este Major?',
    answer: 'En el futuro, está presente la biotecnología, el desarrollo de '\
            'esta área está en gran aumento. La proyección de lo que se viene '\
            'se basa en tecnologías de información y en biotecnología. A '\
            'aquellos que les motive, deben atreverse a ser parte de este '\
            'futuro.'
  }, {
    question: '¿Con qué título puedo articular si elijo este Major?',
    answer: 'La articulación más común es el título de Ingeniero Civil en '\
            'Biotecnología, que tiene dos menciones, Ambiental y Procesos. '\
            'En segundo lugar, se puede articular con Ingeniería Civil '\
            'Industrial Química y Bioprocesos. Finalmente, con un poco más de '\
            'esfuerzo, se puede articular con Ingeniería Ambiental.'
  }, {
    question: '¿Cuáles son las aplicaciones de este Major?',
    answer: 'Desde prevención, diagnóstico y curación de enfermedades hasta '\
            'procesos de manufactura, como bioplásticos o biocombustibles e '\
            'incluso síntesis de fármacos. También se aplica a la '\
            'sustentabilidad ambiental.'
  }],
  ing_biomedica: [{
    question: '¿Cuál es el campo laboral para este Major?',
    answer: 'Depende mucho de la articulación con el título. Si se sigue '\
            'trabajando en el área biomédica, se puede trabajar en redes de '\
            'salud pública y privada, en empresas de comercialización de '\
            'productos médicos, en el emprendimiento propio en materia '\
            'biomédica y también en el área de investigación.'
  }, {
    question: '¿Cuáles son las áreas de investigación?',
    answer: 'A nivel universidad, están las imágenes médicas (radiografías, '\
            'escáner, etc), los biomateriales y su uso dentro del ser humano '\
            'y, finalmente, la biomecánica, que estudia la interacción entre '\
            'las células y las fuerzas. A nivel mundial, está el control a '\
            'través del cerebro de prótesis, bioinformática, políticas de '\
            'salud, gestión operativa de hospitales, entre muchos otros '\
            'temas.'
  }, {
    question: '¿Cómo afrontar el número limitado de cupos del Major?',
    answer: 'Ser optimistas, creer en que quedarán y recordar que el Major no '\
            'es un título, por lo que pueden articular mediante otros Majors '\
            'con ramos de este, obtener un Magister o un Doctorado, entre '\
            'otras posibilidades.'
  }],
  ing_civil: [{
    question: '¿Qué es lo distinto de este Major?',
    answer: 'El Major de Ingeniería Civil otorga una gran amplitud y da una '\
            'visión amplia de muchas especialidades, el conocimiento '\
            'entregado es más bien vasto y no tan específico. Este modo de '\
            'operar se asemeja a la realidad y se vuelve útil en esta, ya que '\
            'los proyectos traen problemas amplios en donde se necesita tener '\
            'muchas herramientas y contar con un gran equipo para poder '\
            'responder a estos desafíos de manera innovadora.'\
            "\r\nSi comparamos al Ingeniero UC con respecto a otros "\
            'ingenieros existirán ciertas diferencias entre ellos dado al: '\
            'tiempo, la profundización de ciertos tópicos y el perfil de cada '\
            'universidad. El Major tiene la tarea de conservar esta visión '\
            'amplia de ingeniería.'
  }, {
    question: '¿Qué mensaje le daría a los estudiantes para elegir este Major?',
    answer: 'Mauricio López considera que, por un lado, este currículo abre '\
            'muchísimos caminos y por el otro lado asusta ya que aquí las '\
            'oportunidades de elección se siguen tomando en cada momento. No '\
            'obstante esto no implica que no exista una reflexión vocacional '\
            'y que el estudiante no pueda cambiar. De hecho, es bastante '\
            'fácil cambiar el foco del Major y agrega diciendo que de esa '\
            'forma el alumno puede reinventarse de manera fácil dentro de la '\
            'Ingeniería Civil.'
  }, {
    question: '¿Cuáles son las posibilidades de investigación en este Major?',
    answer: 'Si bien Ingeniería Civil es una carrera tradicional es una '\
            'disciplina en la que aún se sabe muy poco ya que los preguntas o '\
            'los desafíos de hoy no están muy claros, temas como: '\
            'productividad, seguridad, sustentabilidad, etc.'\
            "\r\nPor lo que investigar en dichos temas es totalmente "\
            'necesario y este Major puede fomentar el espíritu de '\
            'investigación y a tratar de responder distintas preguntas, por '\
            'ejemplo cómo compatibilizar una cosa técnica con temas mayores y '\
            'con la sociedad.'
  }],
  ing_arquitectura: [{
    question: '¿Cómo es la selección y postulación a este Major?',
    answer: 'El postulante presenta una carta de interés donde establece las '\
            'razones por las cuáles se encuentra interesado en el Major, '\
            'luego a través de los antecedentes académicos el comité '\
            'seleccionará a 15 candidatos de los cuales sólo 8 podrán acceder '\
            'al Major.'
  }, {
    question: '¿Es necesario articular Arquitectura para estudiar '\
              'Planificación Urbana?',
    answer: 'Esta área se puede desarrollar desde ambas disciplinas, '\
            'ingeniería o arquitectura, por lo que no es necesario articular '\
            'pero los enfoques de los roles pueden ser distintos.'
  }, {
    question: '¿Cuál es el costo en créditos de articular con Arquitectura?',
    answer: 'Aún no está estipulado esté costo, aunque puede estar cercano a '\
            '270 créditos y 16 semestres al tratarse de un Major de '\
            'interdisciplina.'
  }, {
    question: '¿Hay ramos de taller en este Major?',
    answer: 'Sí, existe un ramo de taller y según el minor se pueden tener '\
            'hasta dos más sin incluir los Optativos que se pueden tomar.'
  }, {
    question: '¿Qué diferencias tiene este Major con otros similares?',
    answer: 'La diferencia de éste Major respecto a otros disciplinarios '\
            'dentro de ingeniería es que forma profesionales, en sus '\
            'respectivos diplomas, que aprenden a entender e interactuar con '\
            'otras disciplinas de mejor forma, gracias a la interdisciplina. '\
            'Los otros buscan una forma directa y formal para formar alumnos '\
            'en sus respectivas áreas.'
  }],
  ing_geotecnica: [{
    question: '¿Qué tipo de proyectos se realizan en esta disciplina?',
    answer: 'La geotécnica se puede ver en grandes proyecto, por ejemplo la '\
            'expansión de líneas de metro, tranques y depósitos grandes de '\
            'desechos, y grandes obras civiles. Últimamente se ha '\
            'profundizado en puertos al tener una componente hidráulica y de '\
            'suelo importante.'
  }, {
    question: '¿Cuál es el perfil de alumno que busca este Major?',
    answer: 'Este Major se encuentra en el área civil, por tanto se busca '\
            'interesados en obras que ayuden al desarrollo del país. El foco '\
            'se encuentra en la modelación del comportamiento de suelos y '\
            'rocas para resolver las distintas problemáticas estructurales.'
  }, {
    question: '¿Cuáles son las posibilidades de empleo en este Major?',
    answer: 'Los egresados de este Major principalmente trabajan en la '\
            'operación y desarrollo de proyectos mineros. También se puede '\
            'trabajar en oficinas consultoras de Ingeniería en geotecnia para '\
            'obras de infraestructura más tradicionales.'
  }, {
    question: '¿Cuáles son las diferencias con Geociencias y Geoingeniería?',
    answer: 'El Major de Geociencias tiene un foco más descriptivo y '\
            'cualitativo, mientras que el de Geotecnia se preocupa de los '\
            'datos cuantitativos, los cuáles son importantes en igual medida '\
            'dentro de un proyecto.'\
            "\r\nLa diferencia con Geoingeniería es el tipo de proyecto, "\
            'puesto que en Geotecnia tiene un foco en proyectos de Ingeniería '\
            'Civil, grandes obras de infraestructura.'
  }],
  investigacion_operativa: [{
    question: '¿Qué tipo de formación entrega este Major?',
    answer: 'Una formación sólida y profunda en las metodologías cuantitivas '\
            'analíticas de modelación y resolución de problemas, dando una '\
            'flexibilidad para moverse dentro de diversas áreas. Todo esto '\
            'gracias a los fundamentos de la modelación que entrega este '\
            'Major.'
  }, {
    question: '¿En qué proyectos concretos se aplica la investigación '\
              'operativa?',
    answer: 'La Investigación operativa es un área que lleva más de medio '\
            'siglo de desarrollo aportando en diversos ámbitos, tanto en los '\
            'tradicionales industriales como en minería, líneas áreas, etc, '\
            'en donde se maneja una vasta cantidad de recursos. También se '\
            'aplica en el sector público, como el área de la salud, haciendo '\
            'un buen uso de los recursos y mejorando la planificación.'
  }, {
    question: '¿Cómo articula este Major con títulos profesionales?',
    answer: 'El Major se puede articular con cualquier título debido a su '\
            'amplitud. Sin embargo tiene una mayor afinidad con el área de '\
            'Ingeniería Matemática y en Transportes por mencionar algunas. Es '\
            'importante la planificación para poder articular correctamente.'
  }, {
    question: '¿Cómo enfocar la elección de Major?',
    answer: 'Lo mejor que se puede hacer es analizar las opciones y elegir lo '\
            'que realmente les gusta y aprovechar el potencial de ser '\
            'Ingeniero UC.'
  }],
  mineria: [{
    question: '¿Cómo es el trabajo en minería?',
    answer: 'Se puede trabajar o no en la mina, es una decisión personal. Sin '\
            'embargo, la experiencia muestra que para poder tener un mejor '\
            'desarrollo profesional hay que estar en la mina. La minería da '\
            'la opción de desarrollarse tanto en empresas mineras como en '\
            'empresas relacionadas a ella, estas últimas pueden tener sus '\
            'bases en Santiago pero les puede tocar mucho viajar.'\
            "\r\nLa minería da la opción para que alumnos al año de egresados "\
            'sean capaces de tomar decisiones de relevancia dentro de una '\
            'empresa.'
  }, {
    question: '¿Cuáles son las áreas de investigación en minería?',
    answer: 'A nivel mundial la industria está revisando lo que se hace '\
            'actualmente, buscando nuevas formas de explotar las minas, '\
            'pensando en diversos métodos como el uso de bacterias para poder '\
            'realizar una explotación más eficiente. La investigación está '\
            'apuntando a hacer una minería distinta, una mejora continua en '\
            'los procesos y equipos, pensando en una minera inteligente.'
  }, {
    question: '¿Por qué elegir este Major?',
    answer: 'Porque da la opción de trabajar en una de las industrias más '\
            'relevantes del país, trabajando en CODELCO o empresas '\
            'proveedoras, lugares en los cuales se puede aportar el '\
            'desarrollo económico, social y tecnológico del país. También '\
            'conduce rápidamente a tomar decisiones de relevancia en la '\
            'empresa. Si gustan de los desafíos, quieren tener una mirada '\
            'crítica y trabajar en equipo este Major los prepara para eso.'
  }]
}
