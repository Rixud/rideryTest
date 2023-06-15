//
//  ContentView.swift
//  RideryTest
//
//  Created by LuisGuerra on 14/6/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView{
         
            ZStack{
            
                Constant.backgroundColor.ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
               Image("AppLogo").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.bottom, 60.0)
               // .offset(x: 0, y: 25.0)
         
                
                LogInAndRegisterView()
                
            }
            
            }.navigationBarHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    
    
    
    
    
    }
}


struct LogInAndRegisterView:View {
    
    @State var isLogIn:Bool = true
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer()
                
                Button("INICIAR SESIÓN"){
                    
                    print("Pantalla Inicio sesion")
                    isLogIn = true
                }
                .foregroundColor(isLogIn ? .white : .gray)
                
                Spacer()
                
                Button("REGÍSTRATE"){
                    
                    print("Pantalla Registro")
                    isLogIn = false
                }.foregroundColor(isLogIn ? .gray : .white)
                
                Spacer()
            }
            
            
            Spacer(minLength: 42)
            
            
            if(isLogIn){
                LogInView()
                //RegistroView()
            }else{
                RegisterView(isLogIn: $isLogIn)
            }
            
        }
        
    }
}

struct LogInView: View {
    
    @StateObject var emailString = TFManager()
    @StateObject var passwordString = TFManager()
    @State var isHomeActive:Bool = false
    
    var body: some View {
        
     
        
        ScrollView{
            
            VStack(alignment: .leading){
                
                rideryTextField(placeholder: "ejemplo@gmail com", tittle: "Correo electrónico", textInputString: emailString)
                rideryTextField(placeholder: "Introduce tu contraseña", tittle: "Contraseña", isSecure: true, textInputString: passwordString)

                
                Divider()
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 300,  alignment: .trailing)
                    .foregroundColor(Constant.mainColor)
                    .padding(.bottom)
                
                rideryButton(tittle: "Iniciar Sesión", action: logInButtonPress)
                
                
    
            }.padding(.horizontal, 42.0)
        
        
            //Destinos de navegación
            NavigationLink(
                destination: HomeView(isActive: self.$isHomeActive),
                isActive: $isHomeActive,
                label: { EmptyView()
                })
        
        }
        

        
    }
    
    func logInButtonPress() {
        let service = LogInService()
        logInSession(service)
    }
    
    
    func logInSession(_ service:LogInService) {
        
       let service = service
        
        if service.logInCall(email: emailString.text, password: passwordString.text){
            isHomeActive.toggle()
        }else{
            print("Tus datos son incorrectos")
            
        }
        
        
            
    }
    
    
}

struct RegisterView: View {
    
    @StateObject var emailString = TFManager()
    @StateObject var passwordString = TFManager()
    @StateObject var passwordConfirmString = TFManager()
    @StateObject var phoneNumberString = TFManager()
    @Binding var isLogIn: Bool
    
    @State var alertTitle:String = ""
    @State var alertMsg:String = ""
    @State var isPresentingAlert:Bool = false
    
    
    var body: some View {
        
        
        ScrollView{
            
            
            VStack(alignment: .center){
               
                Text("Elije una foto de perfíl")
                    .fontWeight(.bold)
                    .foregroundColor(Constant.mainColor)
                    
                
                Text("Puedes cambiar o elejirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
               
                
                
                Button(action: takePhoto, label: {
                    ZStack{
                        
                        Image("perfilEjemplo").resizable().aspectRatio(contentMode: .fill).frame(width: 80.0, height: 80.0).cornerRadius(80)
                        
                        Image(systemName: "camera").foregroundColor(.black)
       
                        
                    }
                })
                
                
               
                 
                    
                
            }.padding(.bottom, 18)
                .alert(alertTitle, isPresented: $isPresentingAlert){
                    Button("Ok", role: .cancel){
                        isLogIn.toggle()
                    }
                }
            
          
            
            VStack(alignment: .leading){
                
                
                VStack{
                
                    rideryTextField(placeholder: "ejemplo@gmail com", tittle: "Correo electrónico", textInputString: emailString)
               
                    rideryTextField(placeholder: "0414 000 00 00", tittle: "Numero de teléfono", textInputString: phoneNumberString)
                    
                    rideryTextField(placeholder: "Introduce tu contraseña", tittle: "Contraseña", isSecure: true, textInputString: passwordString)
                    
                    rideryTextField(placeholder: "Repite tu contraseña", tittle: "Confirma contraseña", isSecure: true, textInputString: passwordConfirmString)
                
                    
                }
                
                Divider()

                 
                    
                }
               
                
                Button(action: registrarse) {
                   
                    Text("REGÍSTRATE")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame( maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6).stroke(Constant.mainColor, lineWidth: 3).shadow(color: Constant.mainColor, radius: 6))
   
                       
                }.padding(.bottom)
                
              
                
            }.padding(.horizontal, 42.0)
            
    
       }
        


    
    func takePhoto()  {
        print("Tomo foto")
        //logica de tomar fotos.
    }
    
    func registrarse()  {
        let SQLManager = SQLiteRideryViewModel()
        //print("Me registro con el correo \(emailString.text), la contraseña \(passwordString.text) y confirmación de contraseña \(passwordConfirmString.text), numero de telefono \(phoneNumberString)")
    
        //validación contraseña
        if passwordString.text == passwordConfirmString.text{
            SQLManager.createTable()
            let newID = SQLManager.addUser(phone: phoneNumberString.text, mail: emailString.text)
            
            SQLManager.checkDatabase()
            if newID != nil {
                alertTitle = "Cuenta Creada"
                clearTextField()
            }
            //let objetoActualizadorDatos = SaveData()
            
            //let resultado = objetoActualizadorDatos.guardarDatos(correo: emailString.text, contrasena: passwordString.text, nombre: "")
            
            //print("Se guardaron los datos con exito?: \(resultado)")
            
        }else{
            
            print("Contraseñas diferentes, vuelve a intentarlo")
        }
        
        
        
    }
    
    func clearTextField () {
        emailString.text = ""
        passwordString.text = ""
        passwordConfirmString.text = ""
        phoneNumberString.text = ""
        isPresentingAlert.toggle()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
     
        Group {
            ContentView()
            LogInView().background(Color(red: 18/255, green: 31/255, blue: 61/255, opacity: 100).ignoresSafeArea())
        }
        
    }
}


