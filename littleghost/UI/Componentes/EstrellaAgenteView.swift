//
//  Estrella.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct EstrellaAgenteView: View {
  
    @ObservedObject var estado: EstadoJuego
    
    // Estados locales para controlar los movimientos de SwiftUI
    @State private var flotacionY: CGFloat = 0.0
    @State private var oscilacionX: CGFloat = 0.0
    @State private var rotacionExito: Double = 0.0
    
    var body: some View {
        VStack(spacing: 8) {
            //  (GA Star)
            ZStack {
                // Placeholder circular
                Circle()
                    .fill(obtenerColorEstrella().gradient)
                    .frame(width: 90, height: 90)
                    .shadow(color: obtenerColorEstrella().opacity(0.6), radius: 15, x: 0, y: 0)
                
                // Expresion facial o textura simulada
                Text(obtenerExpresionEstrella())
                    .font(.system(size: 40))
            }
            // 3 ANIMACIONES REQUERIDAS
            .offset(x: oscilacionX, y: flotacionY) // Controla Reposo (Y) y Pensando (X)
            .rotationEffect(.degrees(rotacionExito)) // Controla exito (Giro 360)
            
        
            Text("GA Star")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(.ultraThinMaterial))
        }
        .onAppear {
            // Iniciar de inmediato la Animacion 1: Reposo (Flotando suave de arriba a abajo)
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                flotacionY = -12
            }
        }
        // listen to game changes para activar los efectos especiales
        .onChange(of: estado.mostrarOsoEnojado) { _ in
            ejecutarGiroExito()
        }
        .onChange(of: estado.mostrarConfeti) { _ in
            ejecutarGiroExito()
        }
    }
    
    // Funcion para cambiar expresiones
    private func obtenerExpresionEstrella() -> String {
        if estado.mostrarOsoEnojado {
            return "😰" // scared of kwb
        } else if estado.mostrarConfeti {
            return "🤩" // successs
        } else {
            return "⭐" // normal/happy
        }
    }
    
    // Funcion para cambiar el color del aura del agente
    private func obtenerColorEstrella() -> Color {
        if estado.mostrarOsoEnojado {
            return .orange
        } else if estado.mostrarConfeti {
            return .yellow
        } else {
            return .cyan
        }
    }
    
    // Animacion 3: 360 turn
    private func ejecutarGiroExito() {
        withAnimation(.interpolatingSpring(stiffness: 60, damping: 8)) {
            rotacionExito += 360
        }
    }
}
