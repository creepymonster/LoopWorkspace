//
//  LoginSignupView.swift
//  TidepoolKitUI
//
//  Created by Darin Krauss on 4/17/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import SwiftUI
import TidepoolKit

struct LoginSignupView: View {
    @State private var isEnvironmentActionSheetPresented = false
    @State private var message = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var isCloseAlertPresented = false

    var viewModel: LoginSignupViewModel

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Spacer()
                        logo
                            .padding(.horizontal, 30)
                            .padding(.bottom)
                        VStack {
                            VStack(alignment: .leading) {
                                messageView
                                emailField
                            }
                            VStack(alignment: .trailing) {
                                passwordField
                                forgotPasswordLink
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                        loginButton
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .navigationTitle(LocalizedString("Your Tidepool Account", comment: "Tidepool login view title"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: closeButton)
    }

    private var logo: some View {
        Image(frameworkImage: "TidepoolLogo", decorative: true)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onLongPressGesture(minimumDuration: 2) {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                isEnvironmentActionSheetPresented = true
            }
            .actionSheet(isPresented: $isEnvironmentActionSheetPresented) { environmentActionSheet }
    }

    private var environmentActionSheet: ActionSheet {
        var buttons: [ActionSheet.Button] = viewModel.environments.map { environment in
            .default(Text(environment.description)) {
                viewModel.environment = environment
            }
        }
        buttons.append(.cancel())
        return ActionSheet(title: Text(LocalizedString("Environment", comment: "Tidepool login environment action sheet title")),
                           message: Text(viewModel.resolvedEnvironment.description), buttons: buttons)
    }

    private var messageView: some View {
        Text(message)
            .font(.callout)
            .foregroundColor(.red)
    }

    private var emailField: some View {
        TextField(LocalizedString("Email", comment: "Tidepool login email field placeholder"), text: $email, onCommit: login)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .keyboardType(.emailAddress)
            .disabled(isLoggingIn)
    }

    private var passwordField: some View {
        SecureField(LocalizedString("Password", comment: "Tidepool login password field placeholder"), text: $password, onCommit: login)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disabled(isLoggingIn)
    }

    private var forgotPasswordLink: some View {
        Link(LocalizedString("Forgot your password?", comment: "Tidepool login forgot password link title"), destination: viewModel.resolvedEnvironment.url(path: "/request-password-reset")!)
            .font(.callout)
            .accentColor(.secondary)
            .foregroundColor(.accentColor)
            .disabled(isLoggingIn)
    }

    private var loginButton: some View {
        Button(action: login) {
            if isLoggingIn {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text(LocalizedString("Login", comment: "Tidepool login button title"))
            }
        }
        .buttonStyle(ActionButtonStyle())
        .disabled(email.isEmpty || password.isEmpty)
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty, !isLoggingIn else {
            return
        }

        isLoggingIn = true
        viewModel.login(email: email, password: password) { error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {     // Prevent flash from too quick state changes
                setError(error)
                isLoggingIn = false
            }
        }
    }

    private func setError(_ error: Error?) {
        if case .requestNotAuthenticated = error as? TError {
            self.message = LocalizedString("Wrong username or password.", comment: "The message for the request not authenticated error")
        } else {
            self.message = error?.localizedDescription ?? ""
        }
    }

    private var closeButton: some View {
        Button(action: { isCloseAlertPresented = true }) {
            Text(closeButtonTitle)
                .fontWeight(.regular)
        }
        .alert(isPresented: $isCloseAlertPresented) { closeAlert }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(closeButtonTitle)
        .accessibilityIdentifier("button_close")
    }

    private var closeButtonTitle: String { LocalizedString("Close", comment: "Close navigation button title of an onboarding section page view") }

    private var closeAlert: Alert {
        Alert(title: Text(LocalizedString("Are you sure?", comment: "Alert title confirming close of Tidepool Service view")),
              primaryButton: .cancel(),
              secondaryButton: .destructive(Text(LocalizedString("End", comment: "Alert button confirming close of Tidepool Service view")),
                                            action: { viewModel.cancel() }))
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreview {
            LoginSignupView(viewModel: LoginSignupViewModel(api: TAPI()))
        }
    }
}
