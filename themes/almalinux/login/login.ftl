<#--
    This template is for Keycloak 26.2 and includes a custom JavaScript function
    `concatenatePassword()` that combines the password and OTP
    fields into a single password field before form submission. This is used
    to handle scenarios where the OTP is appended to the password for authentication.

    This modified version disables the OTP field by default and provides a <noscript>
    notice for users without JavaScript, instructing them to append the OTP to the password.
    If JavaScript is enabled, a script will enable the OTP field and the concatenation
    will happen automatically.
-->

<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
          <div id="kc-form-wrapper">
            <#if realm.password>
                <form id="kc-form-login" class="${properties.kcFormClass!}" onsubmit="concatenatePassword(); login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate="novalidate">
                    <#if !usernameHidden??>
                        <#assign label>
                            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                        </#assign>
                        <@field.input name="username" label=label error=kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc autofocus=true autocomplete="username" value=login.username!'' />

                        <@field.password name="password" label=msg("password") error="" forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                            <#if realm.rememberMe && !usernameHidden??>
                                <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                            </#if>
                        </@field.password>
                    <#else>
                        <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                            <#if realm.rememberMe && !usernameHidden??>
                                <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                            </#if>
                        </@field.password>
                    </#if>

                    <#--
                        The OTP field is disabled by default. We assume the 'field.ftl' macro can take an 'other_attributes' parameter.
                        If this does not work, you should replace this macro with the raw HTML below to ensure the field is disabled.
                    -->
                    <@field.input name="otp" label=msg("loginAccountOtp") autocomplete="off" other_attributes='disabled="disabled"' />

                    <#--
                        If the macro above doesn't work, comment it out and use this raw HTML instead.
                        <div class="form-group">
                            <label for="otp" class="control-label">${msg("loginAccountOtp")}</label>
                            <input id="otp" name="otp" type="text" class="form-control" autocomplete="off" disabled />
                        </div>
                    -->

                    <#-- This notice will ONLY be displayed to users with JavaScript disabled. -->
                    <noscript>
                        <div class="alert alert-warning" role="alert">
                          <span>JavaScript is disabled. Please append the OTP directly to your password in the password field.</span>
                        </div>
                    </noscript>

                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <@buttons.loginButton />
                </form>
            </#if>
            </div>
        </div>

        <script>
            // This script runs only if JavaScript is enabled.
            // It immediately enables the OTP field, overriding the 'disabled' default state from the HTML.
            document.getElementById('otp').disabled = false;

            function concatenatePassword() {
                var passwordField = document.getElementById('password');
                var otpField = document.getElementById('otp');

                // Proceed only if both fields have values
                if (passwordField && otpField && passwordField.value && otpField.value) {
                    // Concatenate password and OTP
                    passwordField.value = passwordField.value + otpField.value;

                    // Disable the OTP field right before submission so it isn't sent as a separate parameter
                    otpField.disabled = true;
                }
            }
        </script>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers?? && social.providers?has_content>
            <@identityProviders.show social=social/>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
