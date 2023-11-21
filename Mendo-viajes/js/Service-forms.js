const form_in = document.querySelector("#Fly-in-form");
const form_in_out = document.querySelector("#Fly-in-out-form");

const btn_form_in = document.querySelector("#btn-fly-in");
const btn_form_out = document.querySelector("#btn-fly-in-out");
console.log(btn_form_in);
console.log(form_in);

btn_form_in.addEventListener("click", function (e) {
    form_in.style.display = "block";
    form_in.reset();
    form_in_out.style.display = "none";
    reset_result();
});
btn_form_out.addEventListener("click", function (e) {
    form_in_out.style.display = "block";
    form_in_out.reset();
    form_in.style.display = "none";
    reset_result();
});

function reset_result() {
    if (result_div.class == "result-show") {
        console.log("Cambiando.")
        result_div.class = "div-result-do"
        result_div.innerHTML = `
        <i class='bx bx-search-alt-2 bx-lg'><p>Haga su busqueda.</p></i>
        `
    }
}