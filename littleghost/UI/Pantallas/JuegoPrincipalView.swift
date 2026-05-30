//
//  JuegoPrincipalView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct JuegoPrincipalView: View {
    // Conectamos con el estado global que creamos en el Paso 2
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        ZStack {
            // 1. FONDO: El visor de la cámara con los efectos de las Eras
            CamaraSimuladaView(estado: estado)
                .ignoresSafeArea()
            
            // 2. AGENTE: GA Star flotando en la esquina superior derecha
            VStack {
                HStack {
                    Spacer()
                    EstrellaAgenteView(estado: estado)
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                }
                Spacer()
            }
            
            // 3. INTERFAZ DE USUARIO (Botones flotantes estéticos)
            VStack {
                Spacer()
                
                HStack(spacing: 40) {
                    // Botón para ir al Chat (Pantalla 3)
                    NavigationLink(destination: ChatView(estado: estado)) {
                        VStack {
                            Image(systemName: "bubble.left.and.exclamationmark.bubble.right.fill")
                                .font(.title)
                            Text("Chat")
                                .font(.caption).bold()
                        }
                        .frame(width: 80, height: 80)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                    }
                    
                    // Botón para ir a la Colección/Inventario (Pantalla 4)
                    NavigationLink(destination: InventarioView(estado: estado)) {
                        VStack {
                            Image(systemName: "opticaldisc.fill")
                                .font(.title)
                            Text("Vinyls")
                                .font(.caption).bold()
                        }
                        .frame(width: 80, height: 80)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        // Ocultamos la barra de navegación estándar para que se vea más como un juego
        .navigationBarBackButtonHidden(true)
    }
}
