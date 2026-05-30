//
//  Estrella.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct EstrellaAgenteView: View {
    // Conexión con el estado global del juego
    @ObservedObject var estado: EstadoJuego
    
    // Estados locales para controlar los movimientos de SwiftUI
    @State private var flotacionY: CGFloat = 0.0
    @State private var oscilacionX: CGFloat = 0.0
    @State private var rotacionExito: Double = 0.0
    
    var body: some View {
        VStack(spacing: 8) {
            // 1. Cuerpo del Agente (GA Star)
            ZStack {
                // Placeholder circular con color reactivo mientras recortas tus PNGs en Photoshop
                Circle()
                    .fill(obtenerColorEstrella().gradient)
                    .frame(width: 90, height: 90)
                    .shadow(color: obtenerColorEstrella().opacity(0.6), radius: 15, x: 0, y: 0)
                
                // Expresión facial o textura simulada según lo que esté haciendo
                Text(obtenerExpresionEstrella())
                    .font(.system(size: 40))
            }
            // --- CÓDIGO DE LAS 3 ANIMACIONES REQUERIDAS ---
            .offset(x: oscilacionX, y: flotacionY) // Controla Reposo (Y) y Pensando (X)
            .rotationEffect(.degrees(rotacionExito)) // Controla Éxito (Giro 360)
            
            // 2. Letrero con el nombre del Agente
            Text("GA Star")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(.ultraThinMaterial))
        }
        .onAppear {
            // Iniciar de inmediato la Animación 1: Reposo (Flotando suave de arriba a abajo)
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                flotacionY = -12
            }
        }
        // Escuchar cambios en el juego para activar los efectos especiales
        .onChange(of: estado.mostrarOsoEnojado) { _ in
            ejecutarGiroExito()
        }
        .onChange(of: estado.mostrarConfeti) { _ in
            ejecutarGiroExito()
        }
    }
    
    // Función para cambiar de textura/cara dinámicamente
    private func obtenerExpresionEstrella() -> String {
        if estado.mostrarOsoEnojado {
            return "😰" // Susto por el Oso K.W.B
        } else if estado.mostrarConfeti {
            return "🤩" // Éxito total
        } else {
            return "⭐" // Reposo / Feliz
        }
    }
    
    // Función para cambiar el color del aura del agente
    private func obtenerColorEstrella() -> Color {
        if estado.mostrarOsoEnojado {
            return .orange
        } else if estado.mostrarConfeti {
            return .yellow
        } else {
            return .cyan
        }
    }
    
    // Animación 3: Éxito (Giro de 360 grados de alegría)
    private func ejecutarGiroExito() {
        withAnimation(.interpolatingSpring(stiffness: 60, damping: 8)) {
            rotacionExito += 360
        }
    }
}
