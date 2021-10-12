import { LightningElement,track } from 'lwc';

export default class Iptracker extends LightningElement {
@track ipAdd = '';
ipValue;

    connectedCallback(){
        //do something
        console.log('load method');
        handleFetch1(() => {
            fetch('https://api.ipify.org')
            .then((response) => {
                if (!response.ok) {
                    throw Error(response);
                } else {
                    return response.text();
                }
            })
            .then((textResponse) => {
               this.ipAdd = textResponse;
            })
            .catch((error) => {
                this.error = error;
                this.ipAdd = undefined;
            });
        });
       
        console.log('load track value'+this.ipAdd);
        console.log('load ip value'+this.ipValue);
   } 

   renderedCallback() {
    // this.handleFetch();
     console.log('render track value'+this.ipAdd);
     console.log('render ip value'+this.ipValue);
   }

   handleFetch(){

    fetch('https://api.ipify.org')
            .then((response) => {
               
                if (!response.ok) {
                    throw Error(response);
                } else {
                    return response.text();
                }
            })
            .then((textResponse) => {
               this.ipAdd = textResponse;
            })
            .catch((error) => {
                this.error = error;
                this.ipAdd = undefined;
            });
       /*
    var request = new XMLHttpRequest();
    request.open('GET', "https://api.ipify.org?format=jsonp=", true);
    request.onload = function () {
        if (request.status >= 200 && request.status < 400) {
            this.ipAdd = request.responseText;
            let ipaddrss = request.responseText;
            console.log(ipaddrss);
        } else {
            // We reached our target server, but it returned an error
            console.log(request.statusText);
        }
    }
    request.onerror = function () {
        // There was a connection error of some sort
        console.log(request.statusText);
    }
    request.send(); 
     let endPoint = "https://api.ipify.org";
        fetch(endPoint, {
        method: "GET"
        })
        .then((response) => response.text()) 
        /* response.json() gives us back a promise
        we need to process the promise in .then()
        .then((repos) => {
            this.ipAdd = repos;
            this.ipValue = repos;
            console.log('RESP'+repos);
        });*/
  }
}