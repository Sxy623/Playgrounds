import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var userRegistrationViewModel = UserRegistrationViewModel()
    
    let themeColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var body: some View {
        VStack {
            Text("Create an account")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(.bottom, 30)
            
            FormField(fieldName: "Username", fieldValue: $userRegistrationViewModel.username)
            
            RequirementText(iconColor: userRegistrationViewModel.isUsernameLengthValid ? Color.secondary : themeColor, text: "A minimum of 4 characters", isStrikeThrough: userRegistrationViewModel.isUsernameLengthValid)
                .padding()
            
            FormField(fieldName: "Password", fieldValue: $userRegistrationViewModel.password, isSecure: true)
            
            VStack {
                RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordLengthValid ? Color.secondary : themeColor, text: "A minimum of 8 characters", isStrikeThrough: userRegistrationViewModel.isPasswordLengthValid)
                
                RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordCapitalLetter ? Color.secondary : themeColor, text: "One uppercase letter", isStrikeThrough: userRegistrationViewModel.isPasswordCapitalLetter)
            }
            .padding()
            
            FormField(fieldName: "Confirm Password", fieldValue: $userRegistrationViewModel.passwordConfirm, isSecure: true)
            
            RequirementText(iconColor: userRegistrationViewModel.isPasswordConfirmValid ? Color.secondary : themeColor, text: "Your confirm password should be the same as password", isStrikeThrough: userRegistrationViewModel.isPasswordConfirmValid)
                .padding()
                .padding(.bottom, 50)
            
            Button {
                // Proceed to the next screen
            } label: {
                Text("Sign Up")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            HStack {
                Text("Already have an account?")
                    .font(.system(.body, design: .rounded))
                    .bold()
                
                Button{
                    // Proceed to Sign in screen
                } label: {
                    Text("Sign in")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .foregroundStyle(themeColor)
                }
            }
            .padding(.top, 50)
            Spacer()
        }
        .padding()
    }
}
