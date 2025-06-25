run:
    podman build . -t kctheme
    podman run -p 8080:8080 -v ./themes:/opt/keycloak/themes:z kctheme
    open http://localhost:8080/