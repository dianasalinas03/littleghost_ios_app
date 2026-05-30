//
//  ObjetosJuego.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//
import Foundation
import SwiftUI

// estructura para los botones de interacción en las pistas
struct BotonInteraccion: Identifiable {
    let id = UUID()
    let mensaje: String
    let conectaConPista: String
}

// 2. Modelo principal for the vinyls (Pistas)
struct Vinilo: Identifiable {
    let id: String              // debut, fearless, red
    let nombreAlbum: String     // fearless era
    let nombreReino: String     //  countryside realm
    let pistaTexto: String      // GA star bestie help
    let interactuable: Bool     // special dinmamcics
    var encontrado: Bool = false // control de inventario
}

// 3. Estructura para el Chat con GA Star
struct MensajeChat: Identifiable {
    let id = UUID()
    let remitente: String       // user, star or bear
    let texto: String
    let esAlerta: Bool          // red bear 
}
