# APPLICATIONS

All sites accessible through cloudflare tunnels

## Downloads / Media

Allowing the downloads of totally legit linux iso mkv's.

| Application  | Use                                   | Url
|--------------|---------------------------------------|--------------------------------------|
| bazarr       | subtitles                             | https://DOMAIN_NAME/bazarr           |
| jellyfin     | plex alternative                      | https://jellyfin.DOMAIN_NAME         |
| mylar3       | mylar3                                | https://media.DOMAIN_NAME/comics     |
| ppenbooks    | books                                 | https://media.DOMAIN_NAME/openbooks  |
| prowlarr     | consolidated usenet/trackers searcher | https://media.DOMAIN_NAME/prowlarr   |
| qbittorrent  | torrent downloader                    | https://media.DOMAIN_NAME/qbt/       |
| radarr       | movies                                | https://media.DOMAIN_NAME/radarr     |
| sabnzbd      | usenet downloader                     | https://media.DOMAIN_NAME/sabnzbd    |
| sonarr       | tv shows                              | https://media.DOMAIN_NAME/sonarr     |

All traffic for the download/media namespaces is tunneled through a VPN for enhanced security.

## Home-Automation

Using HASS and Zigbee2MQTT along with mosquitto for MQTT.
Allows me to manage my zigbee and wifi devices.

| Application    | Url
|----------------|----------------------------------------|
| home-assistant | https://hass.DOMAIN_NAME               |
| zigbee2mqtt    | https://hass.DOMAIN_NAME/zigbee2mqtt/  |

## Unifi

Manage Unifi access points

URL: https://unifi.DOMAIN_NAME

## Administration

| Application        | Url
|--------------------|-------------------------------------|
| longhorn GUI       | https://mgmt.DOMAIN_NAME/longhorn/  |
| weaveworks-gitops  | https://flux.DOMAIN_NAME            |
