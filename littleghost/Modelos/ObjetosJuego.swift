//
//  ObjetosJuego.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//
import Foundation
import SwiftUI

// 1. Estructura para los botones de interacción en las pistas
struct BotonInteraccion: Identifiable {
    let id = UUID()
    let mensaje: String
    let conectaConPista: String
}

// 2. Modelo principal para tus 5 Vinilos (Pistas)
struct Vinilo: Identifiable {
    let id: String              // Ej: "debut", "fearless", "red"
    let nombreAlbum: String     // Ej: "Fearless Era"
    let nombreReino: String     // Ej: "Countryside Realm"
    let pistaTexto: String      // El acertijo que dice GA Star
    let interactuable: Bool     // Si activa dinámicas especiales
    var encontrado: Bool = false // Control del inventario
}

// 3. Estructura para el Chat con GA Star
struct MensajeChat: Identifiable {
    let id = UUID()
    let remitente: String       // "Usuario", "GA Star" o "K.W.B"
    let texto: String
    let esAlerta: Bool          // Para poner textos en rojo si aparece el oso
}
