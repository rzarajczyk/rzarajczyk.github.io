# Family Rules Server - Client API

!!! warning "This is an ongoing project. It has bugs!"

    It has still many bugs! I use it at home, but keep in mind that it's not a commercial product.

This is an API used by the clients to communicate with the server.

## Initial setup
This request should be executed only once, after the client is installed. It registers the client in the server.

```shell
export HOST="http://localhost:8080"         # The address of the server
export INSTANCE_NAME="new-instance"         # The name of the device
export CLIENT_TYPE="custom"                 # The type of the client - it's a custom value, can be anything
export USERNAME="username"                  # The username of the administrator 
export PASSWORD="password"                  # The password of the administrator  

curl --header "Content-Type: application/json" \
  --request POST \
  --user "$USERNAME:$PASSWORD" \
  --data "{\"instanceName\":\"$INSTANCE_NAME\",\"clientType\":\"$CLIENT_TYPE\"}" \
  "$HOST/api/v1/register-instance"
```

Sample response:
```json
{
  "status":"SUCCESS",
  "instanceId":"81cc589b-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "token":"0e26aeb3-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

## Launching instance
This request should be executed every time the client is started. It informs the server that the client is active and
updates some basic metadata about the client. 

```shell
export HOST="http://localhost:8080"       # The address of the server
export USERNAME="username"                # The username of the administrator
export INSTANCE_ID="81cc589b-xxxx-xxxx-xxxx-xxxxxxxxxxxx"   # The device ID from the server
export TOKEN="0e26aeb3-xxxx-xxxx-xxxx-xxxxxxxxxxxx"         # The token from the server 

export VERSION="v1"                        # The version of the client. While technically it can be anything, I strongly recommended to use reasonable versioning

curl --header "Content-Type: application/json" \
  --request POST \
  --user "$USERNAME:$TOKEN" \
  --data '{
  "instanceId": "'"$INSTANCE_ID"'",
  "version": "'"$VERSION"'",
  "availableStates": [
    {
      "deviceState": "ACTIVE",
      "title": "Active",
      "icon": "<path d=\"m424-296 282-282-56-56-226 226-114-114-56 56 170 170Zm56 216q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z\"/>",
      "description": null
    }
  ]
}' \
  "$HOST/api/v1/launch"
```
Notes:

 * `availableStates` is a list of states that the client can be in.
    * `deviceState` is the internal name of the state
    * `title` is the human-readable name
    * `icon` (optional) is the SVG icon that will be displayed in the Family Rules Server UI (without the `<svg>` tag itself)
    * `description` (optional) is the additional, descriptive text which will be displayed in the Family Rules Server UI


## Sending report
This request should be executed periodically, to send the usage statistics to the server.
It's recommended to execute this request every 15 secs.

```shell
export HOST="http://localhost:8080"       # The address of the server
export USERNAME="username"                # The username of the administrator
export INSTANCE_ID="81cc589b-xxxx-xxxx-xxxx-xxxxxxxxxxxx"   # The device ID from the server
export TOKEN="0e26aeb3-xxxx-xxxx-xxxx-xxxxxxxxxxxx"         # The token from the server 

curl --header "Content-Type: application/json" \
  --request POST \
  --user "$USERNAME:$TOKEN" \
  --data '{
    "instanceId": "'"$INSTANCE_ID"'",
    "screenTime": 5,
    "applications": {
      "YouTube": 5
    }
  }' \
  "$HOST/api/v1/report"
```
Notes:

* `screenTime` is the total time the device's screen was on in seconds
* `applications` is a map of application names and their usage time in seconds

Sample response:
```json
{
  "deviceState":"ACTIVE"
}
```

The deviceState shows the current state of the device. The client should take action based on this value.