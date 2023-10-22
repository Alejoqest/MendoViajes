class Fly_Fetch {
    constructor(url) {
        this.url = url;
    }
    async GET(param) {
        return await(await fetch(this.url + param, {
            method : "GET",
            headers : {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        })).json();
    }
}