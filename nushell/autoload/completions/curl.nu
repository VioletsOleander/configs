export extern main [
    --header (-H): string # (HTTP IMAP SMTP) Extra header to include in information sent. When used within an HTTP request, it is added to the regular request headers.
    --data (-d): string # (HTTP MQTT) Send the specified data in a POST request to the HTTP server, in the same way that a browser does when a user has filled in an HTML form and presses the submit button. 
    --verbose (-v) # Make curl output verbose information during the operation. Useful for debugging and seeing what's going on under the hood. 
]
