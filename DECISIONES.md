○ Los requisitos de este enunciado que te resultaron ambiguos o
contradictorios, y qué decidiste en cada caso.

Este ejercicio deja varias cosas abiertas. No señala si hay un sistema de autenticación ya disponible, como un OAuth o similar, por lo que por la naturaleza y tiempo de esta tarea, decidí dejarlo sin autenticación, y priorizar funcionalidad por sobre seguridad. También se deja abierto lo que significa "eliminar" información de las bases de datos, y dadas las condiciones del ejercicio para precisar de la mejor forma la nota de reseñas, preferí usar el sistema de flags dentro de las bases de datos, permitiendo "apagar" y "encender" registros según sea necesario.
Un tema más pequeño, es que una de los endpoint que se pide es mostrar 50 libros, pero no dice si ese es el total, o si hay más, y hay que mostrar los 50 mejores, o los 50 primeros, por ejemplo.
Una cosa más, es que no se especifica con qué puntaje inicial se parte un libro. 0.0? 5.0? decidí que para hacer el promedio más preciso, cada libro parte con puntaje 0.0.


○ Los trade-offs que tomaste y qué costo tiene cada uno.

Un tradeoff que decidí tomar fue el no uso de las claves foraneas dentro de active record, justamente para priorizar funcionalidad por sobre estructura con el tiempo límite, lo cual puede generar un posible problema con registros de reviews, principalmente. Para esos casos, de todas maneras voy agregando ciertas condicionales a los endpoint con los que trabajo, como por ejemplo el preguntar si una review que se va a ingresar pertenece al mismo usuario que hizo una review de cierto libro, evitando que así usuarios no pongan varias review para un solo libro.

○ Qué dejarías fuera si esto saliera a producción mañana, y qué harías distinto

Si saliera mañana, tendría que dejar fuera los temas de rendimiento. Si bien mi sistema de puntaje de review es útil para elementos con pocos registros, lo más conveniente sería ocupar algún tipo de balanceador de carga, que permita que las request que se hacen de forma simultánea se hagan sin sobreexplotar los servidores.
Y luego de pensarlo, mi técnica de active para las review solo funcionaría a full en los casos de eliminar reviews por medio de la api, pues si las "elimino" cuando "elimino" a un usuario de la plataforma, si lo reinstauro podría devolver reviews que no deberían ser devueltas al sistema, compromentiendo nuevamente la valoración. Una opción para evitar esto sería tener un servicio que las borrara totalmente de la base de datos, o también crear un campo de status que me permita seleccionar cuáles reviews deberían volver luego de una eliminación.