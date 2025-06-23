FROM quay.io/keycloak/keycloak:26.2

# Set environment variables for the initial admin user.
# IMPORTANT: Use these credentials for development only.
# Change these for any production-like environment.
ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin

# The user's local themes are expected to be in a 'themes' directory
# next to this Containerfile. This command copies them into the
# correct location within the Keycloak container.
#
# Your local directory structure should be:
# .
# ├── Containerfile
# └── themes/
#     └── your-theme-name/
#         ├── login/
#         │   └── theme.properties
#         └── account/
#             └── theme.properties
#
COPY --chown=keycloak:keycloak ./themes/ /opt/keycloak/themes/

# This command starts Keycloak in development mode, which is convenient
# for testing themes without needing a full production database setup.
# The server will be available on port 8080. you can run with docker -p 8080:8080
# to expose it on your host machine.
CMD ["start-dev"]