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
    console.log(GET);
    gestor.GET(GET)
    .then(function(response) {
        if (response.datos) {
            vuelo = response.datos;
            console.log(vuelo);
        } else if (response.error) {
            console.log (response);
        }
    })
    .catch(function(response) {console.error(response);});
});