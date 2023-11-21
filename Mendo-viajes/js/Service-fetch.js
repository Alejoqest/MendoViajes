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
    async POST(param) {
        return await(await fetch(this.url, {
            method : "POST",
            headers : {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body : new URLSearchParams(param).toString()
        })).json();
    }
}