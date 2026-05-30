//
//  JuegoPrincipalView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct JuegoPrincipalView: View {
    // conectar con estado global
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        ZStack {
            // fondou
            CamaraSimuladaView(estado: estado)
                .ignoresSafeArea()
            
            // GA star on the corner
            VStack {
                HStack {
                    Spacer()
                    EstrellaAgenteView(estado: estado)
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                }
                Spacer()
            }
            
            // INTERFAZ DE USUARIO
            VStack {
                Spacer()
                
                HStack(spacing: 40) {
                    // boton para ir al chat
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
                    
                    // Boton para ir a la colecion/inventario
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
        
        .navigationBarBackButtonHidden(true)
    }
}
