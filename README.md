# Football Legue Santex Api

## Descripción

El proyecto expone 2 recursos api para importar ligas desde una API externa llamada https://www.football-data.org/ y para contar el número total de jugadores en una liga.

## Insalación y despliegue

Para desplegar el proyecto se deberá:
- Si se instala desde un archivo ZIP
  - Descomprimir el archivo
  - Ingresar a la ruta raíz del proyecto a través de una ventana de comandos
  - Ejecutar el comando `bundle install`
  - Ejecutar el comando `rails server`. El servidor empezará a escuchar en el puerto
  3000 por defecto.
  - Ingresar a un navegador y utilizar uno de los recursos que expone el servicio API

- Si se obtiene desde el respositorio en Github
  - En una ventana de comandos ejecutar `git clone https://github.com/xtrmdarc/SantexFotballLeague.git`
  - Ingresar a la ruta raíz del proyecto a través de una ventana de comandos
  - Ejecutar el comando `bundle install`
  - Ejecutar el comando `rails server`. El servidor empezará a escuchar en el puerto
  3000 por defecto.
  - Ingresar a un navegador y utilizar uno de los recursos que expone el servicio API

## Recursos API

- Endpoint: `http://localhost:3000/`

  - Recurso: `/import-league/{league_code}`
  Este servicio importa los datos de la competición, los equipos participantes y 
  los jugadores de dichos equipos desde un API externa a la base de datos local.
    - Ejemplo: `http://localhost:3000/import-league/CL`

  - Recurso: `/total-players/{league_code}`
  Este servicio retorna en formato JSON la cantidad total de jugadores participantes
  en la competición ingresada como parámetro.
    - Ejemplo: `http://localhost:3000/total-players/CL`
