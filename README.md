# itunes
Search API de iTunes

Crea un proyecto en Xcode y desarrolla una aplicación que conste de una simple navegación entre 2 pantallas.

En la primera pantalla nos gustaría que apareciese una barra de búsqueda donde podamos introducir los términos (ya sean artistas, canciones, álbumes, géneros...). En la misma pantalla deberán listarse los resultados de la búsqueda mostrando el título de la canción y el artista, y más en detalle el nombre del álbum y la fecha de lanzamiento, una miniatura de la carátula y la duración, género y el precio. Deberá ofrecerse la posibilidad de ordenar la lista sobre estos tres últimos campos.
Cada uno de los resultados de búsqueda debería navegar a una segunda pantalla en la que, con un diseño parecido al de los reproductores de música actuales, nos permita visualizar el detalle de la carátula en grande, la información básica de la canción y los controles básicos de reproducción para poder escuchar la canción, pausarla y pasar a la anterior/siguiente canción de la lista de resultados de búsqueda.
Adicionalmente la pantalla de reproducción deberá tener un botón para poder compartir lo que estoy escuchando en mis redes sociales favoritas.

Anexo:
Para poder implementar esta prueba necesitarás emplear la Search API de iTunes:
https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store‐web- -service‐search‐api.html
En ella encontrarás muchísima documentación además de la necesaria, por eso puedes ir directamente al subapartado de “Search Examples” y comprobar que únicamente necesitarás usar una llamada del tipo https://itunes.apple.com/search?term=michael+jackson para una búsqueda de canciones del mítico Michael Jackson. No será necesario usar ningún parámetro adicional en la llamada. La respuesta obtenida será la siguiente (se han eliminado los campos innecesarios y sombreado el campo de descarga de la preview de la canción):
{
"resultCount":50,
"results":
[
"wrapperType":"track",
"kind":"song",
"artistId":32940,
"collectionId":850697616,
"trackId":850697815,
"artistName":"Michael Jackson & Justin Timberlake", "collectionName":"XSCAPE (Deluxe)", "trackName":"Love Never Felt So Good", "collectionCensoredName":"XSCAPE (Deluxe)", "trackCensoredName":"Love Never Felt So Good", "collectionArtistName":"Michael Jackson",
"artworkUrl30":"http://a1.mzstatic.com/us/r30/Features2/v4/f4/25/67/f425676c-bebd- 611b-226c‐ed4b6e8675f1/dj.sxghjyyn.30x30-50.jpg", "artworkUrl60":"http://a5.mzstatic.com/us/r30/Features2/v4/f4/25/67/f425676c‐bebd‐ 611b‐226c‐ed4b6e8675f1/dj.sxghjyyn.60x60‐50.jpg", "artworkUrl100":"http://a3.mzstatic.com/us/r30/Features2/v4/f4/25/67/f425676c‐bebd- 611b‐226c‐ed4b6e8675f1/dj.sxghjyyn.100x100--‐75.jpg",
"collectionPrice":16.99, "trackPrice":1.29, "releaseDate":"2014--‐05--‐02T07:00:00Z", "trackTimeMillis":245671, "currency":"USD", "primaryGenreName":"Pop"
}, }
