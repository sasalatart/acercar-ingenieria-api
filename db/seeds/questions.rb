def create_questions!
  puts 'Creating general questions...'

  admin = User.with_role(:admin).first
  @questions.each { |data| Question.create!(data.merge(author: admin)) }
end

line_skip = "\r\n\r\n"
half_line_skip = "\r\n"

@questions = [
  {
    question: '¿Cómo funciona la página de Preguntas Frecuentes?',
    answer: 'Aquí podrás ver las preguntas frecuentes de la Nueva Malla. '\
            'Puedes enviar una pregunta haciendo click en el botón "Proponer '\
            'una". Un administrador se encargará luego de responderla.',
    pinned: true
  },
  {
    question: '¿Qué es un major? ¿Cuál es la diferencia entre los majors '\
              'disciplinarios e interdisciplinarios?',
    answer: 'Un major es una concentración de cursos que equivale a 100 '\
            "créditos, por lo general son grupos de 10 ramos.#{line_skip}"\
            'Hay majors disciplinarios: Tienen relación directa con áreas '\
            'que son conocidas como propias de Ingeniería, como Ingeniería '\
            "en Minería, Química, Mecánica, etc. Son 14 al año 2014.#{line_skip}"\
            'Hay majors interdisciplinarios: Son los que plantean una '\
            'aplicación de la Ingeniería en otros ámbitos como la '\
            'arquitectura, medicina, diseño, entre otros. Son 8 los majors '\
            "que se clasifican de esta forma.#{line_skip}"\
            'Debes tener en cuenta que si articulas con un título profesional '\
            'de la Escuela, el major que escojas no es la mención de tu '\
            'título. Tienes que elegir tu major como una herramienta para '\
            "desempeñarte en tu futuro, más allá del título.#{line_skip}"\
            'Desafiando Límites, Majors y Minors '\
            '(http://www.desafiandolimites.cl/majors-minors)',
    pinned: true
  },
  {
    question: '¿El major tiene que ver con mi especialidad?',
    answer: 'Esto depende solo de ti. La malla apunta a que puedas usarla '\
            'como tú sientas que más aportará a tu futuro profesional y '\
            'personal, por lo que el major puede o no tener que ver con tu '\
            "especialidad..#{line_skip}"\
            '¡OJO! Considera que si deseas terminar la carrera en un tiempo '\
            'determinado, una combinación de major, minor y título que no '\
            'tengan relación entre sí es casi seguro que sumarán más '\
            'semestres en la Universidad.',
    pinned: true
  },
  {
    question: '¿Cómo sé cuáles ramos tomar para articular con mi especialidad?',
    answer: 'Para esto debes consultar en esta página, en Desafiando Límites, o '\
            'en tu SIDING, donde aparece información sobre los majors y qué '\
            'temáticas abordan. Luego, si tu prioridad es articular con el '\
            'título, puedes "jugar" en el planner qué es lo que más se adecua '\
            'y adapta a tus intereses sobre el tiempo y conocimiento '\
            'adquirido. Además, recuerda que sólo a modo de ORIENTACIÓN está '\
            'la Orientadora Académica en Dirección de Pregrado, a quién '\
            'puedes acudir si tienes dudas sobre articulaciones, pero ten '\
            'claro que su objetivo no es armarte la malla.',
    pinned: true
  },
  {
    question: '¿Cuándo se declara major?',
    answer: 'Durante el tercer semestre de la carrera, y es independiente de '\
            'tu avance curricular.',
    pinned: true
  },
  {
    question: '¿Puedo hacer más de un major?',
    answer: 'No, sólo puedes hacer uno.',
    pinned: true
  },
  {
    question: '¿Cómo postulo a un major con cupo?',
    answer: 'Debes inscribirlo en el SIDING en el proceso oficial y además '\
            'participar de un proceso de postulación especial, que dependerá '\
            "del major que estés inscribiendo.#{line_skip}"\
            'Puedes encontrar toda la información sobre esta postulación '\
            "especial en:#{half_line_skip}"\
            'SIDING/Pregrado/Normativa Declaración, Postulación e '\
            'Inscripción/Proceso de Postulación y Selección Majors con cupos.',
    pinned: true
  },
  {
    question: 'No me gustó el major que elegí. ¿Puedo cambiarme a otro?',
    answer: 'Sí, puedes cambiarte dentro de los plazos establecidos para cada '\
            "semestre.#{line_skip}"\
            'Para realizar el cambio debes hacer una solicitud de propósito '\
            "general en el SIDING, con lo siguiente:#{half_line_skip}"\
            "En \"Solicitud\" colocar: CAMBIO MAJOR#{half_line_skip}"\
            'En "Razón Solicitud" colocar: Major que tienes inscrito, major '\
            'al cual deseas cambiarte, y explicar los motivos del cambio.',
    pinned: true
  }
]
