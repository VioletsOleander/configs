export extern main [
    --header (-H): string # (HTTP IMAP SMTP) Extra header to include in information sent. When used within an HTTP request, it is added to the regular request headers.
    --data (-d): string # (HTTP MQTT) Send the specified data in a POST request to the HTTP server, in the same way that a browser does when a user has filled in an HTML form and presses the submit button. 
    --data-raw: string # (HTTP) Post data similarly to --data but without the special interpretation of the @ character.
    --location (-L) # (HTTP) If the server reports that the requested page has moved to a different location (indicated with a Location: header and a 3XX response code), this option makes curl redo the request to the new place.
    --proxy (-x) # Use the specified proxy.
    --request (-X): string # Change the method to use when starting the transfer. This options is normally not need for HTTP request. 
    --verbose (-v) # Make curl output verbose information during the operation. Useful for debugging and seeing what's going on under the hood. 
]
