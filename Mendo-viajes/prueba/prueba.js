const datos = [{clase: "economica", 
    destino: "buenos-aires", 
    duracionVuelo: "01:40:00", 
    equipaje: "sin equipaje", 
    fechaVuelo: "2023-11-01", 
    horaVuelo: "13:30:00", 
    numVuelo: "124", 
    precioPer: "35300.00000"},{clase: "economica",
    destino: "buenos-aires",
    duracionVuelo : "02:00:00",
    equipaje: "sin equipaje",
    fechaVuelo: "2023-11-01", 
    horaVuelo: "17:35:00", 
    numVuelo : "139",
    precioPer : "38580.00000"}];
const btn = document.querySelector(".load-button");
const result_div= document.querySelector(".div-result-do");
btn.addEventListener("click", function() {
    result_div.className = "result-show";
    result_div.innerHTML = "";
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
        <div class="price-result"><p> Precio por persona: ${precio_persona}<br>Precio Total: ${precio_persona*1}</p></div>
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
}, true);
