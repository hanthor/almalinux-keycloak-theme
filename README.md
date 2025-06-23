![image](https://github.com/user-attachments/assets/6caa208e-cc33-49d4-8c9a-2a7da7f281db)


# AlmaLinux Keycloak Theme

This repository contains a custom theme for Keycloak, designed to align with the AlmaLinux branding.

## Features

*   **Login Page:** Custom look and feel for the Keycloak login page.
*   **Registration Page:** Themed registration page.
*   **Account Management:** Consistent styling for user account management.
*   **Error Pages:** Branded error pages.

## Installation

To install this theme, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/hanthor/almalinux-keycloak-theme.git
    ```

2.  **Copy the theme to Keycloak:**
    Navigate to your Keycloak installation directory (e.g., `/opt/keycloak`) and copy the `almalinux` theme folders into the `themes` directory.
    ```bash
    cp -r almalinux-keycloak-theme/themes/almalinux /opt/keycloak/themes/
    ```

3.  **Configure Keycloak to use the theme:**
    *   Log in to the Keycloak Admin Console.
    *   Select your realm (e.g., `master`).
    *   Go to `Realm Settings` -> `Themes` tab.
    *   Set the following theme options to `almalinux`:
        *   `Login Theme`
        *   `Account Theme`
        *   `Admin Console Theme` (optional, if you want the admin console to also use this theme)
        *   `Email Theme` (optional)

4.  **Save** the changes.

## Development

    ```bash
    podman build . -t kctheme
    podman run -p 8080:8080 -v ./themes:/opt/keycloak/themes:z kctheme
    
    ```
you can login at https://localhost:8080 with `admin` / `admin`

    
