//
//  ContentView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct ContentView: View {
    // Initialize the global game state here so it is inherited throughout the app
    @StateObject private var estado = EstadoJuego()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 70s Pop Style Pastel Background
                Color(red: 0.96, green: 0.91, blue: 0.93)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    Spacer()
                    
                    // 1. Main Avatar (Little Ghost Placeholder)
                    VStack(spacing: 8) {
                        Text("👻")
                            .font(.system(size: 85))
                            .shadow(radius: 5)
                        
                        Text("LITTLE GHOST")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                            .tracking(3)
                    }
                    
                    // 2. Story Introduction
                    VStack(spacing: 12) {
                        Text("Mission: Lost Rhythm")
                            .font(.headline)
                            .foregroundColor(.yellow) // Cambiado de .orange a .yellow 💛
                        
                        Text("The evil Bear K.W.B has stolen the legendary vinyls and hidden them in mysterious realms inside your own room. With the help of GA Star, follow the clues and restore the music!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 24)
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(.white.opacity(0.7)))
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // 3. Start Search Button (Screen 2)
                    NavigationLink(destination: JuegoPrincipalView(estado: estado)) {
                        HStack {
                            Text("Start Quest")
                                .font(.headline)
                            Image(systemName: "arrow.right.circle.fill")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        // Cambiado de .cyan a un tono oscuro retro que combina con el título 🎨
                        .background(Color(red: 0.2, green: 0.2, blue: 0.3).gradient)
                        .cornerRadius(30)
                        .shadow(color: Color(red: 0.2, green: 0.2, blue: 0.3).opacity(0.4), radius: 10, y: 5)
                    }
                    .padding(.bottom, 40)
                }
            }
            // 4. SCREEN 5 (Showdown / Victory): Automatically triggers when all 5 vinyls are found
            .sheet(isPresented: Binding(
                get: { estado.listaVinilos.allSatisfy { $0.encontrado } },
                set: { _ in }
            )) {
                PantallaVictoriaView(estado: estado)
            }
        }
    }
}

// --- SCREEN 5: VICTORY COMPONENT ---
struct PantallaVictoriaView: View {
    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        ZStack {
            Color(red: 0.1, green: 0.1, blue: 0.15).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("🎉 MISSION ACCOMPLISHED! 🎉")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.yellow)
                
                Text("👻 ✨ 🎵 💿 🤩")
                    .font(.system(size: 50))
                    .padding()
                
                Text("MUSIC RESTORED")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("You have recovered all 5 albums stolen by K.W.B. Little Ghost and GA Star have saved the musical universe thanks to you!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Button(action: {
                    // Reset the game in case the professor wants to try it again
                    for i in 0..<estado.listaVinilos.count {
                        estado.listaVinilos[i].encontrado = false
                    }
                    estado.filtroMoradoActivo = false
                    estado.mostrarOsoEnojado = false
                    estado.mostrarConfeti = false
                    estado.ubicacionActualSimulada = "📍 Location: Unknown (Scan a vinyl)"
                }) {
                    Text("Play Again")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.yellow.cornerRadius(10))
                }
                .padding(.top, 20)
            }
        }
    }
}
