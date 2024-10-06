# Family Rules Sony Bravia client

!!! warning "This is an ongoing project. It has bugs!"

    It has still many bugs! I use it at home, but keep in mind that it's not a commercial product.


A simple Python-based client for a Sony Bravia TV. Tested on `Sony Bravia KD-49XH8505`.

It should run on some server inside home network and communicates with the TV using the Sony API and Chromecast
protocol.

Distributed as a Docker image.

## Supported TV states

- Active (default; usage is permitted)
- Turned off (the TV is turned off immediately after being turned on)

## Links

* [Source code](https://github.com/rzarajczyk/family-rules-sony-bravia-client)
* [Docker hub](https://hub.docker.com/r/rzarajczyk/family-rules-sony-bravia-client)

## Usage - docker compose

!!! warning "The app does not perform the initial setup"

    You have to manually execute the initial setup request, and collect the instance-id and token from the response. It's a one-time action, but it's required.

```yaml
services:
  sony:
    container_name: sony
    image: rzarajczyk/family-rules-sony-bravia-client:latest
    restart: unless-stopped
    volumes:
      - ./config/sony-bravia-family-rules.yaml:/app/config.yaml
      - ./data/family-rules-sony-bravia-client:/app/data  # optional, for storing usage data
    depends_on:
      - family  # optional, wait for Family Rules Server
```

**sony-bravia-family-rules.yaml**

```yaml
timezone: "Europe/Warsaw"
interval-seconds: 10            # How often should the app check if the TV is on

tv:
  name: "SONY KD-49XH8505"      # The name of the TV
  ip: '192.168.xx.xxx'          # The IP address of the TV
  mac: '4C:EB:XX:XX:XX:XX'      # The MAC address of the TV
  pin: '1234'                   # The PIN code for the TV, set in the TV settings
  unique-id: 'sony kd-49xh8505' # Whatever you want, it's used as a unique identifier for the TV

family-rules-server:
  host: http://family:8080      # The address of the Family Rules Server
  user: admin                   # The username of the administrator
  instance-name: sony-tv        # The name of the device in the Family Rules Server
  instance-id: 81cc589b-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # The device ID from the Family Rules Server
  token: 0e26aeb3-xxxx-xxxx-xxxx-xxxxxxxxxxxx        # The token from the Family Rules Server  
```