# HTTP\&HTTPS

HTTP is stateless: Every request is completely independant

HTTPS : Data is encrypted with SSL/TLS&#x20;

SSL: secure sockets layer

TLS: transport layer security.(Layer 4 in osi model)

SSL Certificate : certificate that establishes a secure encrypted connection between a web server and a web browser.



## HTTP METHODS:

1- GET: get data

\#you can add/submit data to the server using get but it's bad idea because it will visible in the url and then it will saved in the server&#x20;

2- POST: adding/submit data to the server

3-PUT:update data already on the server&#x20;

4-DELETE : Deletes data from the server



## REQUEST STRUCTURE:

1-header:

a-general header: url,method,status code

b-Response header: server:apache/apache/hidden,Set-Cookie,Content-Type,Date,Content-Length

c-Request header:Cookies:send your cookies back to the server,Accept-xxx ,Content-type ,User-Agent: descripe the user enviroment such its browser mozila or chrome and its version ,Referrer

2-body:

in the REQUEST for example if you send form it will be in the body

in the response it's the html page &#x20;



## HTTP STATUS CODES:

1xx: the request is being received / processing

2xx:successfully

3xx: Redirect

4xx: Client Error : permission or the request is missing some thing

5xx: Server error

## more notes:

http/2 more faster,secure,efficient than http/1.1



## USEFULL URL'S:

[https://www.getpostman.com/](https://www.postman.com/)

&#x20;

