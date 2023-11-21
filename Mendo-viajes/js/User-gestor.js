class user_Fetch {
    constructor(url) {
        this.url = url;
    }
    async GET() {
        return await(await fetch(this.url, {
            method : "GET",
        })).json();
    }
}
const URL_USERMANAGER = "http://localhost/Mendo-viajes/php/usermanager.php?";
let user_gestor = new user_Fetch(URL_USERMANAGER);

let cuenta = {};

user_gestor.GET().then(function(response) {
    if (response.datos) {
        user = response.datos;
        if (user.id != 0) {
            cambiar_sesion(user.id);
            armar_cuenta(user);
        } else {
            armar_cuenta_vacia();
        }
    } else if (response.error) {
        console.log (response);
    }
})
.catch(function(response) {console.error(response);});

const cuenta_link = document.querySelector("a.navop.nav-account");

function cambiar_sesion(userid) {
    cuenta_link.href = `account.html?${userid}`;
}

function armar_cuenta_vacia() {
    cuenta = {
        id: 0,
        username: "",
        email: "",
        type: ""
    }
    console.log(cuenta);
}

function armar_cuenta(user) {
    cuenta = {
        id: user.id,
        username: user.username,
        email: user.email,
        type: user.type
    }
    console.log(cuenta);
}