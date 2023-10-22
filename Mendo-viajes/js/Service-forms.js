const form_in = document.querySelector("#Fly-in-form");
const form_in_out = document.querySelector("#Fly-in-out-form");

const btn_form_in = document.querySelector("#btn-fly-in");
const btn_form_out = document.querySelector("#btn-fly-in-out");
console.log(btn_form_in);
console.log(form_in);

btn_form_in.addEventListener("click", function (e) {
    form_in.style.display = "block";
    form_in_out.style.display = "none";
});
btn_form_out.addEventListener("click", function (e) {
    form_in_out.style.display = "block";
    form_in.style.display = "none";
});