//
//  InventarioView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI

struct InventarioView: View {
    @ObservedObject var estado: EstadoJuego
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // 1. Cabecera Personalizada
            HStack {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Return to AR")
                    }
                    .foregroundColor(.yellow)
                }
                Spacer()
                Text("Vinyl Collection")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("Return AR").opacity(0).disabled(true)
            }
            .padding()
            .background(Color.black.opacity(0.5))
            
            // 2. Lista scrolleable de los Vinilos
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(estado.listaVinilos) { vinilo in
                        HStack(spacing: 16) {
                            // Icono del disco musical reflectivo
                            ZStack {
                                Circle()
                                    .fill(vinilo.encontrado ? Color.yellow.gradient : Color.gray.gradient)
                                    .frame(width: 55, height: 55)
                                
                                Image(systemName: "opticaldisc")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                            
                            // Textos informativos de las Eras de T.S.
                            VStack(alignment: .leading, spacing: 4) {
                                Text(vinilo.nombreAlbum)
                                    .font(.headline)
                                    .foregroundColor(vinilo.encontrado ? .white : .gray)
                                
                                Text(vinilo.nombreReino)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Badge indicador de estado de la misión
                            Text(vinilo.encontrado ? "✅ Founded" : "🔒 Lost")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(vinilo.encontrado ? .green : .orange)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Capsule().fill(Color.black.opacity(0.3)))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(vinilo.encontrado ? Color.white.opacity(0.08) : Color.white.opacity(0.02))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(vinilo.encontrado ? Color.yellow.opacity(0.3) : Color.clear, lineWidth: 1)
                        )
                    }
                }
                .padding()
            }
            
            // 3. Barra de estatus general de la entrega
            HStack {
                Spacer()
                Text("Progress: \(estado.listaVinilos.filter({$0.encontrado}).count) of 5 secured vinyls")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
