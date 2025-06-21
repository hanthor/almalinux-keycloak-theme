# Use a specific version of the official Keycloak image for consistency.
# You can find other versions on Quay.io: https://quay.io/repository/keycloak/keycloak
FROM quay.io/keycloak/keycloak:latest

# Set environment variables for the initial admin user.
# IMPORTANT: Use these credentials for development only.
# Change these for any production-like environment.
ENV KC_BOOTSTRAP_ADMIN_USERNAME=admin
ENV KC_BOOTSTRAP_ADMIN_PASSWORD=admin
ENV KC_FEATURES=preview,quick-theme

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
# The server will be available on port 8080.
CMD ["start-dev"]