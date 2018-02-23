def create_questions!
  puts 'Creating general questions...'

  @questions.each { |data| Question.create!(data.merge(author_id: 1)) }
end

@questions = [
  { question: '¿Cómo funciona la página de Preguntas Frecuentes?',
    answer: 'Aquí podrás ver las preguntas frecuentes de la Nueva Malla. '\
            'Puedes enviar una pregunta haciendo click en el botón "Crear '\
            'pregunta". Un administrador se encargará luego de responderlas.',
    pinned: true },
  { question: '¿Qué es un major? ¿Cuál es la diferencia entre major '\
              'disciplinario e interdisciplinario?',
    answer: 'Un major es una concentración de cursos que equivale a 100 '\
            'créditos, por lo general son grupos de 10 ramos.'\
            "\r\nHay majors disciplinarios, o sea que tienen relación directa "\
            'con áreas que son conocidas como propias de Ingeniería, como'\
            'Ingeniería en minería, química, mecánica, eléctrica, etc. Son 14 '\
            'al año 2014.'\
            "\r\nHay majors interdisciplinarios, estos son los que plantean "\
            'una aplicación de la Ingeniería en otros ámbitos como la '\
            'arquitectura, medicina, diseño, entre otros. Son 8 los majors '\
            'que se clasifican de esta forma.'\
            "\r\n\r\nDebes tener en cuenta de que si articulas con un título "\
            'profesional de la Escuela, el major que escojas no es la mención '\
            'de tu título. Tienes que elegir tu major como una herramienta '\
            'para desempeñarte en tu futuro, más allá del título.'\
            "\r\n\r\n\"Un elemento crucial del perfil de egreso del "\
            'Licenciado en Ciencias de la Ingeniería, según competencias '\
            'disciplinares y competencias transversales."'\
            "\r\nDesafiando Límites, Majors y Minors."\
            "\r\nhttp://www.desafiandolimites.cl/majors-minors",
    pinned: true },
  { question: '¿El major tiene que ver con mi especialidad?',
    answer: 'Esto depende solo de ti. La malla apunta a que puedas usarla '\
            'como tú sientas que más aportará a tu futuro profesional y '\
            'personal. Por lo que el major puede o no tener que ver con tu '\
            'especialidad. OJO! ten cuidado que si tienes como visión '\
            'terminar la carrera en un tiempo determinado una combinación de '\
            'major, minor y título que no tengan relación entre sí es casi '\
            'seguro que sumarán semestres en la Universidad.',
    pinned: true },
  { question: '¿Cómo sé cuáles ramos tomar para articular con mi especialidad?',
    answer: 'Para esto debes consultar en esta página, en Desafiando Límites, '\
            'en tu SidIng, donde aparece información sobre los majors y qué '\
            'temáticas abordan. Luego, si tu prioridad es articular con el '\
            'título, puedes "jugar" en el planner que es lo que más se adecua '\
            'y adapta a tus intereses sobre el tiempo y conocimiento '\
            'adquirido. Además recuerda que solo a modo de ORIENTACIÓN está '\
            'la Orientadora Académica en Dirección de Pregrado, a quién '\
            'puedes acudir si tienes dudas sobre articulaciones, pero ten '\
            'claro que su objetivo no es armarte la malla.',
    pinned: true },
]
