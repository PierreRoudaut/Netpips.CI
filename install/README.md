

# Run `journalctl -fu netpips-server` to check netpips-server service status
> journalctl -fu netpips-server

# Allow netpips to run passwordless sudo commands
Run `visudo` and append the following line
> netpips ALL=(ALL) NOPASSWD: ALL

# edit `/etc/environment` and add following variable and reboot

> ASPNETCORE_ENVIRONMENT=

> DOMAIN=

> CERTBOT_CONTACT_EMAIL=

> APPSETTINGS_ID=

> APPSETTINGS_TEST_ID=

