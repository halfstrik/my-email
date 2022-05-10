# Setup of personal blog/website

Using OpenBSD build in httpd

File `/etc/httpd.cong`:
```
server "sergeypetrunin.com" {
        listen on * port 80
        alias "www.sergeypetrunin.com"
        location "/.well-known/acme-challenge/*" {
                root "/acme"
                request strip 2
        }
        location * {
                block return 302 "https://$HTTP_HOST$REQUEST_URI"
        }
}

server "sergeypetrunin.com" {
        listen on * tls port 443
        alias "www.sergeypetrunin.com"
        root "/htdocs"
        tls {
                certificate "/etc/ssl/sergeypetrunin.com.fullchain.pem"
                key "/etc/ssl/private/sergeypetrunin.com.key"
        }
        location "/.well-known/acme-challenge/*" {
                root "/acme"
                request strip 2
        }
        location "/*" {
                directory auto index
        }
}
```

Crontab:
```
~	*	*	*	*	acme-client sergeypetrunin.com && rcctl reload httpd
```

Website's files are in `/var/www/htdocs/`
