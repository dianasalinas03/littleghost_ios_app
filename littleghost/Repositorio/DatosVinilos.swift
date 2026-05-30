//
//  DatosVinilos.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//
import Foundation
import SwiftUI
import Combine //

class EstadoJuego: ObservableObject {
    // offical story vinyls
    @Published var listaVinilos: [Vinilo] = [
        Vinilo(id: "debut", nombreAlbum: "Debut", nombreReino: "Countryside Realm", pistaTexto: "The bear hid the first album where it all started, a total acoustic & green vibe...", interactuable: false),
        Vinilo(id: "fearless", nombreAlbum: "Fearless", nombreReino: "Golden Valley", pistaTexto: "The bear hid the next album in a golden place... u lowkey gotta be Fearless to find it, fr!", interactuable: false),
        Vinilo(id: "speaknow", nombreAlbum: "Speak Now", nombreReino: "Enchanted Kingdom", pistaTexto: "Look for a magical spark. Once u find it, a purple aura is gonna envelop your screen...", interactuable: true),
        Vinilo(id: "red", nombreAlbum: "Red", nombreReino: "Autumn Cabin Fields", pistaTexto: "Watch out! This album is straight fire. K.W.B bear is watching closely and will jump scare u if u scan it...", interactuable: true),
        Vinilo(id: "1989", nombreAlbum: "1989", nombreReino: "Retro Neon City", pistaTexto: "The last vinyl is literally glowing in a city full of pop lights and floating confetti, iconic...", interactuable: true)
    ]
    
    // message historial
    @Published var mensajesChat: [MensajeChat] = [
        MensajeChat(remitente: "GA Star", texto: "Hey bestie! I'm GA Star, your glowing guide. K.W.B Bear stole the vinyls and hid them in my room... I mean, in different realms! Ask me for a 'clue' or 'where' to look to start.", esAlerta: false)
    ]
    
    // Variables de control de estados especiales (pa las dinamicas de las pistas)
    @Published var filtroMoradoActivo: Bool = false
    @Published var mostrarOsoEnojado: Bool = false
    @Published var toquesOso: Int = 0
    @Published var mostrarConfeti: Bool = false
    @Published var extrasEncontrados: Int = 0
    @Published var ubicacionActualSimulada: String = "📍 Location: Unknown (Scan a vinyl)"
    
    // aqui se procesa lo que el usuario escribe en elc hat
    func enviarMensajeUsuario(_ texto: String) {
        let nuevoMensaje = MensajeChat(remitente: "User", texto: texto, esAlerta: false)
        mensajesChat.append(nuevoMensaje)
        
        // Hack de respuesta inteligente simulada (i didnt had time para agregar la ai por mi procesador intel sorry)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let textoMinusculas = texto.lowercased()
            
            if textoMinusculas.contains("clue") || textoMinusculas.contains("where") || textoMinusculas.contains("hint") {
                // search for next vinyl
                if let siguienteVinilo = self.listaVinilos.first(where: { !$0.encontrado }) {
                    self.mensajesChat.append(MensajeChat(remitente: "GA Star", texto: siguienteVinilo.pistaTexto, esAlerta: false))
                } else {
                    self.mensajesChat.append(MensajeChat(remitente: "GA Star", texto: "OMG iconic! We recovered all the music. Go celebrate with Little Ghost!", esAlerta: false))
                }
            } else {
                self.mensajesChat.append(MensajeChat(remitente: "GA Star", texto: "Mmm, still analyzing the realm map. Remember to type 'clue' or 'hint' so I can crack K.W.B's riddles.", esAlerta: false))
            }
        }
    }
    
    // escaneo AR x special effects 4 each album
    func escanearViniloSimulado(id: String) {
        guard let index = listaVinilos.firstIndex(where: { $0.id == id }) else { return }
        
        // vinyl founded!
        listaVinilos[index].encontrado = true
        
        // actualizar ubicacion arriba
        ubicacionActualSimulada = "📍 Location: \(listaVinilos[index].nombreReino)"
        
        // special variations
        switch id {
        case "speaknow":
            filtroMoradoActivo = true
            mensajesChat.append(MensajeChat(remitente: "GA Star", texto: "✨ The realm just went full mystical mode! The purple filter purified the Speak Now data.", esAlerta: false))
            
        case "red":
            mostrarOsoEnojado = true
            toquesOso = 0
            mensajesChat.append(MensajeChat(remitente: "K.W.B", texto: "🐻 WHAT R U DOING IN MY SHED?! U WILL NEVER TAKE THIS ALBUM, PERIOD!", esAlerta: true))
            
        case "1989":
            mostrarConfeti = true
            extrasEncontrados += 1
            mensajesChat.append(MensajeChat(remitente: "GA Star", texto: "🎉 BOOM! Rhythm restored in the neon city. Look at that confetti and the floating notes, it's a whole vibe!", esAlerta: false))
            
        default:
            // (Debut y Fearless solo notifican exito estandar)
            mensajesChat.append(MensajeChat(remitente: "GA Star", texto: "🎵 Sick! \(listaVinilos[index].nombreAlbum) vinyl recovered successfully.", esAlerta: false))
        }
    }
}
