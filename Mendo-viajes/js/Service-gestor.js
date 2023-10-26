const in_fly_destiny = document.querySelector("#Fly-in-form #Fly-destiny");
const in_fly_in_date = document.querySelector("#Fly-in-form #Fly-in");
const in_fly_adult = document.querySelector("#Fly-in-form #Fly-adult");
const in_fly_minor = document.querySelector("#Fly-in-form #Fly-young");
const in_fly_class = document.querySelector("#Fly-in-form #Fly-class");

const result_div= document.querySelector(".div-result-do");

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
    result_div.className = "result-show";
    result_div.innerHTML = "";
    if (datos.length > 0) {
        document.querySelector(".h-result-obtained").innerText = `Se han encontrado ${datos.length} resultados.`
    } else {
        document.querySelector(".h-result-obtained").innerText = `No se han encontrado resultados.`
    }
    for (i = 0; i < datos.length; i++) {
        console.log(datos[i]);
        let num_vuelo = datos[i].numVuelo;
        let clase = datos[i].clase;
        clase = clase.charAt(0).toUpperCase() + clase.slice(1);
        let hora_vuelo =  new Date(`${datos[i].fechaVuelo}T${datos[i].horaVuelo}`);
        let duracion_vuelo = datos[i].duracionVuelo;
        let equipaje = datos[i].equipaje;
        equipaje = equipaje.charAt(0).toUpperCase() + equipaje.slice(1);
        console.log(hora_vuelo);
        precio_persona = Math.round(datos[i].precioPer);
        result_div.innerHTML += 
        `<div id="resultado${i}" class="query-result">
        <div class="upperrow">
        <div class="fly-name"><h4>Vuelo ${num_vuelo}</h4><p>Clase ${clase}</p></div>
        <div class="price-result"><p> Precio por persona: ${precio_persona}<br>Precio Total: ${precio_persona*in_fly_adult.value}</p></div>
        </div>
        <div class="lowerrow"><div class="date-result">
        <p>Fecha de ingreso: <br> ${hora_vuelo.toLocaleDateString()} a las ${hora_vuelo.getHours()}:${hora_vuelo.getMinutes()}</p>
        <p>Duración del viaje: <br> ${duracion_vuelo}</p></div>
        <div class="equipaje-result"><p>Equipaje: ${equipaje}</p></div>
        </div>
        <div class="btn-row"> <button id="b-reservar${i}" class="btn-reservar">Reservar</button>
        </div>
        </div>`;
    }
}