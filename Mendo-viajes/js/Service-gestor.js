const in_fly_destiny = document.querySelector("#Fly-in-form #Fly-destiny");
const in_fly_in_date = document.querySelector("#Fly-in-form #Fly-in");
const in_fly_adult = document.querySelector("#Fly-in-form #Fly-adult");
const in_fly_minor = document.querySelector("#Fly-in-form #Fly-young");
const in_fly_class = document.querySelector("#Fly-in-form #Fly-class");

const in_out_fly_destiny = document.querySelector("#Fly-in-out-form #Fly-destiny");
const in_out_fly_in_date = document.querySelector("#Fly-in-out-form #Fly-in");
const in_out_fly_out_date = document.querySelector("#Fly-in-out-form #Fly-out");
const in_out_fly_adult = document.querySelector("#Fly-in-out-form #Fly-adult");
const in_out_fly_minor = document.querySelector("#Fly-in-out-form #Fly-young");
const in_out_fly_class = document.querySelector("#Fly-in-out-form #Fly-class");

const result_div= document.querySelector(".div-result-do");

let busqueda = {};

const URL_SERVIDOR = "http://localhost/Mendo-viajes/php/vuelos.php?";
let gestor = new Fly_Fetch(URL_SERVIDOR);

form_in_out.addEventListener("submit", buscar_vuelos);
form_in.addEventListener("submit", buscar_vuelos)/*function (e) {
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
            console.log(vuelo);
            armar_resultados(vuelo);
        } else if (response.error) {
            console.log (response);
        }
    })
    .catch(function(response) {console.error(response);});
});*/

function buscar_vuelos(e) {
    e.preventDefault();
    let vuelta = false;
    busqueda = {};
    let GET = {};
    switch (e.target) {
        case form_in: 
            busqueda = {
                adultas: in_fly_adult.value,
                menores: in_fly_minor.value,
                tipo: "ida"
            };
            GET = new URLSearchParams({
                destino: in_fly_destiny.value,
                clase: in_fly_class.value,
                fechaVuelo: in_fly_in_date.value
            }).toString();
        break;
        case form_in_out:
            vuelta = true;
            busqueda = {
                adultas: in_out_fly_adult.value,
                menores: in_out_fly_minor.value,
                tipo: "vuelta"
            };
            GET = new URLSearchParams({
                ubicacion: in_out_fly_destiny.value,
                fechaVuelta: in_out_fly_out_date.value,
                clase: in_out_fly_class.value,
                fechaVuelo: in_out_fly_in_date.value
            }).toString();
            break;
    }
    gestor.GET(GET)
    .then(function(response) {
        if (response.datos) {
            vuelo = response.datos;
            console.log(vuelo);
            armar_resultados(vuelo);
        } else if (response.error) {
            console.log (response);
        }
    })
    .catch(function(response) {console.error(response);});
}

function armar_resultados(datos) {
    result_div.className = "result-show";
    result_div.innerHTML = "";
    document.querySelector(".h-result-obtained").innerText = `No se han encontrado resultados.`
    if (datos.length > 0) {
        document.querySelector(".h-result-obtained").innerText = `Se han encontrado ${datos.length} resultados.`
    } 
    for (i = 0; i <= datos.length; i++) {
        if (busqueda.tipo == "ida") {
            resultados_ida_mostrar(datos[i]);
        } else {
            resultados_vuelta_mostrar(datos[i]);
        }
        amar_event();
    }
}

function resultados_ida_mostrar(datos) {
    let clase = datos.clase.charAt(0).toUpperCase() + datos.clase.slice(1);
    let fecha_vuelo = datos.fechaVuelo.replace(/[-]/g, '/')+" "+datos.horaVuelo;
    let hora_vuelo = new Date(Date.parse(fecha_vuelo));
    let duracion_vuelo = datos.duracionVuelo;
    let llegada_vuelo = new Date(Date.parse(fecha_vuelo));
    llegada_vuelo = new Date(llegada_vuelo.setHours(llegada_vuelo.getHours() + Number(duracion_vuelo.split(":")[0]), (llegada_vuelo.getMinutes() + Number(duracion_vuelo.split(":")[1]))));
    let equipaje = datos.equipaje.charAt(0).toUpperCase() + datos.equipaje.slice(1);
    let precio_persona = Math.round(datos.precioPer);
    let upperrow = `<div class="upperrow">
    <div class="fly-name"><h4>Vuelo ${datos.numVuelo}</h4><p>Clase ${clase}</p></div>
    <div class="price-result"><p> Precio por persona: $${precio_persona}<br>
    Precio Total: $${precio_persona*in_fly_adult.value}</p></div>
    </div>`;
    let middlerow = `<div class ="middlerow">
    <div class="date-result">
    <p>Fecha de ingreso: <br> ${hora_vuelo.toLocaleDateString()} 
    ${hora_vuelo.toLocaleTimeString()}</p>
    <p>Duración del viaje: <br> ${duracion_vuelo}</p>
    <p>Llegada del viaje: <br> ${llegada_vuelo.toLocaleDateString()} 
    ${llegada_vuelo.toLocaleTimeString()}</div>
    </div>`
    let lowerrow = `<div class="lowerrow">
    <div class="equipaje-result"><p>Equipaje: ${equipaje}</p></div>
    </div>`;
    let btnrow = `<div class="btn-row"> <button id="b-reservar${datos.id}" class="btn-reservar">Reservar</button>
    </div>`;
    let warningrow = `<div id="warning${datos.id}" class="warningrow"></div>`;
    result_div.innerHTML += `<div id="resultado${i}" class="query-result">`
    +upperrow.concat(``, middlerow,``, lowerrow, ``, btnrow, ``, warningrow)+
    `</div>`;
}

function sumar_horas(salida, duracion) {
    return new Date(salida.setHours(salida.getHours() + Number(duracion.split(":")[0]), (salida.getMinutes() + Number(duracion.split(":")[1]))));
}

function resultados_vuelta_mostrar(datos) {
    let hora_vuelo = new Date(datos.fechaVuelo);
    let llegada_vuelo = new Date(datos.fechaVuelo);
    llegada_vuelo = sumar_horas(llegada_vuelo, datos.duracionVuelo);
    let hora_vuelta = new Date(datos.fechaVuelta);
    let llegada_vuelta = new Date(datos.fechaVuelta);
    llegada_vuelo = sumar_horas(llegada_vuelta, datos.duracionVuelta);
    let fly_in = `<div class="upperrow">
    <div class="fly-name"><h4>Vuelo ${datos.numVuelo}</h4></div></div>
    <div class ="middlerow"> <div class="date-result">
    <p>Fecha de ingreso: <br> ${hora_vuelo.toLocaleDateString()} 
    ${hora_vuelo.toLocaleTimeString()}</p>
    <p>Duración del viaje: <br> ${datos.duracionVuelo}</p>
    <p>Llegada del viaje: <br> ${llegada_vuelo.toLocaleDateString()} 
    ${llegada_vuelo.toLocaleTimeString()}</div>
    </div>
    <div class="lowerrow">
    <div id="more-about-${datos.idaId+"-"+datos.id}" class="more-about">
    <button id="btn-more-ida-${datos.idaId+"-"+datos.id}" class="btn-more-about">Más información</button>
    </div>
    </div>`;
    let fly_out = `<div class="upperrow">
    <div class="fly-name"><h4>Vuelo ${datos.numVuelta}</h4></div></div>
    <div class ="middlerow"> <div class="date-result">
    <p>Fecha de ingreso: <br> ${hora_vuelta.toLocaleDateString()} 
    ${hora_vuelta.toLocaleTimeString()}</p>
    <p>Duración del viaje: <br> ${datos.duracionVuelta}</p>
    <p>Llegada del viaje: <br> ${llegada_vuelta.toLocaleDateString()} 
    ${llegada_vuelta.toLocaleTimeString()}</div>
    </div>
    <div class="lowerrow">
    <div id="more-about-${datos.id+"-"+datos.idaId}"" class="more-about">
    <button id="btn-more-vue-${datos.id+"-"+datos.idaId}"" class="btn-more-about">Más información</button>
    </div>
    </div>`;
    result_div.innerHTML += 
    `<div id="resultado${datos.id+"-"+datos.idaId}" class="query-result">
    <div id="result_body${datos.id+"-"+datos.idaId}" class="query-result-body">
    <div class="query-fly-indicator"><p>Vuelo de ida</p></div><div class="fly-query-wrapper"> 
    `+fly_in+`</div><div class="query-fly-indicator"><p>Vuelo de ida</p></div><div class="fly-query-wrapper"> 
    `+fly_out+`</div>
    <div class="fly-amount">
    <div class="price-result"><p> Precio por persona: $${datos.precioPer}<br>
    Precio Total del vuelo: $${datos.precioPer*busqueda.adultas}</p></div>
    </div>
    </div>
    <div class="btn-row-in-out"> <button id="b-reservar${datos.id+"-"+datos.idaId}" class="btn-reservar">Reservar</button>
    </div>
    <div id="warning${datos.id+"-"+datos.idaId}" class="warningrow"></div>
    </div>
    </div>`;
}

function amar_event() {
    if(busqueda.tipo == "vuelta") {
        button_more_about = document.querySelectorAll(".btn-more-about");
        for (const btn_more of button_more_about) {
            btn_more.addEventListener("click", event_more_info);
        }
    }
    button_reservar = document.querySelectorAll(".btn-reservar");
    for(const btn_reser of button_reservar) {
        btn_reser.addEventListener("click", event_reservar_warning);
    }
}

function get_fly_id(e, numberspilt, target) {
    id = e.id.slice(numberspilt);
    console.log(id);
    if (busqueda.tipo != "ida") {
        id_main = id.split("-")[0];
        id_other = id.split("-")[1]
    }
    return document.querySelector(target+""+id);
}

function event_more_info(e) {
    let id_modalidad = e.target.id.split("-")[2];
    let id_part = e.target.id.split("-")[3];
    let id_other = e.target.id.split("-")[4];
    let div_more = document.querySelector(`#more-about-${id_part}-${id_other}`);
    let GET = new URLSearchParams({
        id : id_part,
        modalidad : id_modalidad
    }).toString();
    gestor.GET(GET)
    .then(function(response) {
        if (response.datos) {
            vuelo = response.datos[0];
            console.log(vuelo);
            let clase =  vuelo.clase.charAt(0).toUpperCase() + vuelo.clase.slice(1);
            let equipaje = vuelo.equipaje.charAt(0).toUpperCase() + vuelo.equipaje.slice(1);
            div_more.innerHTML = `
            <div class="clase-result"> <p>Clase ${clase}</p></div>
            <div class="equipaje-result"><p>Equipaje: ${equipaje}</p></div>
            <div class="price-result"><p> Precio por persona: $${Math.round(vuelo.precioPer)}<br>
            Precio Total del vuelo: $${vuelo.precioPer*busqueda.adultas}</p></div>
            </div>`;
        } else if (response.error) {
            console.log (response);
        }
    })
    .catch(function(response) {console.error(response);});
}

function event_reservar_warning(e) {
    let div_warning = get_fly_id(e.target, 10, `#warning`);
    if (cuenta.id == 0) {
        div_warning.innerHTML =
        `<div class="warning-without-account">
        <p>Necesitas una cuenta para poder reservar</p>
        </div>`
    } else {
        div_warning.innerHTML = 
        `<div>
        <p>Estas seguro que quieres que reservar?</p>
        </div>
        <div class="div-warning-btn">
        <button id="btn-options-yes${id}" class="btn-reserva-option">Si</button>
        <button id="btn-options-no${id}" class="btn-reserva-option">No</button>
        </div>`;
        let btn_warning_yes = document.querySelector(`#btn-options-yes${id}`);
        let btn_warning_no = document.querySelector(`#btn-options-no${id}`);
        btn_warning_no.addEventListener("click", click_reservar_no);
        btn_warning_yes.addEventListener("click", click_reservar_yes);
    }
}

function click_reservar_no(e) {
    let div_warning = get_fly_id(e.target, 14, `#warning`);
    div_warning.innerHTML = "";
}

function click_reservar_yes(e) {
    let div_warning = get_fly_id(e.target, 15, `#warning`);
    let POST = {};
    if (busqueda.tipo == "ida") {
        POST = {
        vueloId: id,
        numAdultos: busqueda.adultas,
        numMenores: busqueda.menores
        }
    } else {
        POST = {
            vueloVueltaId: id_main,
            vueloIdaId: id_other,
            numAdultos: busqueda.adultas,
            numMenores: busqueda.menores
        }
    }
    gestor.POST(POST)
        .then(function(response) {
            if (response.error) {
                console.log (response);
                div_warning.innerHTML =
                `<div class="warning-error">
                <p>No se pudo realizar la consulta</p>
                </div>`;
            } else {
                div_warning.innerHTML =
                `<div class="warning-success">
                <p>${response.resultado}</p>
                </div>`;
            }
        })
        .catch(function(response) {console.error(response);});
}

