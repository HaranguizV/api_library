# API LIBRARY

API de ejercicio para ComunidadFeliz

Para iniciarla, seguir estos pasos:

* Tener instalado Rails 8
* Usar el comando bundle install desde la raíz del proyecto en una consola
* Esta app se conecta actualmente con SQLite, que ya está incluido en las gemas
* Finalmente, usar el comando bin/rails s desde la raíz del proyecto en una consola

Esto debería permitir usar la web desde el puerto 3000

Para probar los endpoint, importar API Library.postman_collenction.json a Postman.

Comandos para test unitarios:

- bundle exec rspec spec/requests/book_spec.rb
- bundle exec rspec spec/requests/users_spec.rb
- bundle exec rspec spec/requests/review_spec.rb