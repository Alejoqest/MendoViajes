const in_fly_destiny = document.querySelector("#Fly-in-form #Fly-destiny");
const in_fly_in_date = document.querySelector("#Fly-in-form #Fly-in");
const in_fly_adult = document.querySelector("#Fly-in-form #Fly-adult");
const in_fly_minor = document.querySelector("#Fly-in-form #Fly-young");
const in_fly_class = document.querySelector("#Fly-in-form #Fly-class");

const URL_SERVIDOR = "http://localhost/Mendo-viajes/php/vuelos.php?";
let gestor = new Fly_Fetch(URL_SERVIDOR);


form_in.addEventListener("submit", function (e) {
    e.preventDefault();
    let vuelo = [];
    let GET = new URLSearchParams({
        destino : in_fly_destiny.value,
        clase : in_fly_class.value,
        fechaVuelo : in_fly_in_date.value
    }).toString();
    console.log("Enviando los siguientes datos:\n"+GET);
    gestor.GET(GET)
    .then(function(response) {
        if (response.datos) {
            vuelo = response.datos;
            armar_resultados(vuelo);
        } else if (response.error) {
            console.log (response);
        }
    })
    .catch(function(response) {console.error(response);});
});

function armar_resultados(datos) {
    if (datos.length > 0) {
        document.querySelector(".h-result-obtained").innerText = "Se han econtrado "+ datos.length +" resultados para su busqueda";
    } else {document.querySelector(".h-result-obtained").innerText = "No hay resultados para su busqueda.";}
    for (i = 0; i < datos.length; i++) {
        let num_vuelo = datos[i].numVuelo;
        let clase = datos[i].numVuelo;
        let fecha_vuelo = new Date(Date.parse(datos[i].fechaVuelo));
        let hora_vuelo = new Date(Date.parse(datos[i].horaVuelo));
        let duracion_vuelo = new Date(Date.parse(datos[i].duracionVuelo));
        let llegada_vuelo = hora_vuelo + duracion_vuelo;
        console.log(hora_vuelo+" DV="+duracion_vuelo+" LV="+llegada_vuelo);
    }
}