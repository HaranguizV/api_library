-- Qué decidiste frente a cada uno de los cinco mensajes de la primera
semana, y a cuál le dijiste que no.

● Moderación: "Antes de banear a alguien con 4.000 reseñas necesito saber cuánto
le va a mover el promedio a cada libro. Hoy baneo a ciegas y después me llegan los
reclamos."

Se entiende su preocupación. A corto plazo, se puede implementar un sistema de envío de correo cada vez que se haga una eliminación de reseñas a todos los afectados. A mediano plazo, sería conveniente además crear una vista previa para la persona a cargo, que pueda ver y descargar un excel, o guardar en una tabla log, con un listado de los libros afectados, y su antes y después en los puntajes.

● Growth: "El cartel de 'Reseñas Insuficientes' en la home nos está matando el
click-through. ¿No podemos mostrar el promedio igual, aunque sea con dos
reseñas?"

No recomiendo esa opción. Considerando que la plataforma incluye el sistema de calificación, ésta pierde su propósito y confianza si el juicio de la calificación se hace con poco feedback. La aproximación debería orientarse a otro sector: una propuesta sería crear una parte de libros sugeridos en el sitio, que muestre libros que no tengan calificación, pero que coincidan con lo ya reseñado por el usuario, y si no hay reseñado nada, que muestre un listado aleatorio.

● Un autor, vía soporte: "Mi libro bajó de 4.6 a 2.3 de un día para otro y nadie me
avisó nada. Exijo una explicación."

Lamentamos leer que haya ocurrido ese problema. Según nuestra investigación, el sitio recibió un ataque de reseñas falsas, que produjeron un conflicto en la calificación de varios libros y autores. El equipo realizó un trabajo de limpieza para entregar el resultado que se considera correcto, e implementará un sistema de correo para casos futuros en caso de que esto ocurra otra vez. Una vez más lamentamos los inconvenientes por lo ocurrido.

● Soporte: "Tengo 12 tickets de usuarios preguntando por qué su reseña 'ya no
aparece'. No sé qué responderles."

Hace falta más información para atender ese caso. Se registró algún tipo de ataque o inconveniente en el funcionamiento normal del sitio? Se hizo alguna limpieza de reseñas? Hay registro de que alguna persona de soporte haya borrado reseñas? Toda esta información ayuda a entender si el problema es externo o interno.

● Dirección: "Que no se vuelva a repetir." Sin más detalle.

Lamentamos que haya tenido algún problema con el sitio. Nos gustaría que pudiera especificar cuál o cuáles son las problemáticas o reclamos que pueda estar teniendo para poder resolver su solicitud.

-- Las métricas o eventos que definiste, y qué acción concreta desencadena
cada señal.

Para saber si está ocurriendo una campaña, principalmente nos deberíamos fijar en la fechas de creación de los usuarios, las fechas de creación de las reviews, y los comentarios de las mismas reviews. Esto último es un poco más lento, pero encontrar un patrón en los comentarios nos puede dar una pista acerca de unn posible ataque de bots. Ahora, para el tema de las fechas señaladas, hacer una comparación entre fechas de cuando se crea el usuario, y cuando hace reviews, nos puede ayudar mucho, sobre todos si ese usuario hace más de 50 o 100 reviews el mismo día, que nos hace pensar de un posible comportamiento sospechoso. Y si son reviews de 5 estrellas, mucho más.

-- El plan para los promedios que hoy están mal en producción: qué corres, en
qué orden, y qué se comunica hacia afuera.

Con la implementación creada, habría que hacer o un cronjob, o usar otro tipo de alternativa que hiciera la activacion del servicio /reviews/clean. Esta activación debería hacerse en un horario poco concurrido en el día, para no molestar a los clientes del sitio, y debería comunicarse mediante correo masivo, agregando esa funcionalidad al procedimiento. Así, todos los dueños de libros se enterarán del problema y la solución implementada.

-- Una cosa del enunciado que cambiarías si este fuera tu producto — el
umbral de 3 reseñas, el redondeo, la regla de baneos, lo que sea — y por
qué.

Creo que agregaría un conteo de visitas. Independiente de que se puede explotar como cualquier otra valoración, el agregar un contador de visitas, de forma interna principalmente, entrega la oportunidad de generar una métrica que permite crear una categoría de tipo "Trending", que ayudaría a los autores que no tienen reviews suficientes a ser expuestos para que la gente los vea, e incluso puede incentivar a las personas a dejar sus opiniones del libro.