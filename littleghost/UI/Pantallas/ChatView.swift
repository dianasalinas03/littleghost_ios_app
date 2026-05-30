//
//  ChatView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var estado: EstadoJuego
    @State private var textoMensaje: String = ""
    @Environment(\.dismiss) var dismiss // Permite cerrar esta pantalla y volver a la cámara
    
    var body: some View {
        VStack {
            // 1. Cabecera Personalizada
            HStack {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Return to AR")
                    }
                    .foregroundColor(.cyan)
                }
                Spacer()
                Text("Mission chat")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("Return AR").opacity(0).disabled(true) // Centrador óptico
            }
            .padding()
            .background(Color.black.opacity(0.5))
            
            // 2. Historial de burbujas de conversación
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(estado.mensajesChat) { mensaje in
                        HStack {
                            if mensaje.remitente == "User" { Spacer() }
                            
                            VStack(alignment: mensaje.remitente == "User" ? .trailing : .leading, spacing: 4) {
                                Text(mensaje.remitente)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(mensaje.esAlerta ? .red : .gray)
                                
                                Text(mensaje.texto)
                                    .font(.subheadline)
                                    .padding(12)
                                    .background(
                                        mensaje.remitente == "User" ?
                                        Color.cyan.opacity(0.85) :
                                        (mensaje.esAlerta ? Color.red.opacity(0.3) : Color.white.opacity(0.12))
                                    )
                                    .cornerRadius(16)
                                    .foregroundColor(.white)
                            }
                            
                            if mensaje.remitente != "User" { Spacer() }
                        }
                    }
                }
                .padding()
            }
            
            // 3. Campo de texto inferior para escribir
            HStack {
                TextField("type 'clue' to get some help from GA Star...", text: $textoMensaje)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 4)
                
                Button(action: {
                    guard !textoMensaje.isEmpty else { return }
                    estado.enviarMensajeUsuario(textoMensaje)
                    textoMensaje = "" // Limpia el renglón al enviar
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                        .foregroundColor(.cyan)
                        .padding(.horizontal, 8)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
