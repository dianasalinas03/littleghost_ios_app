//
//  CamaraSimuladaView.swift
//  littleghost
//
//  Created by Diana⭐ on 30/05/26.
//

import SwiftUI
import AVFoundation

struct CamaraSimuladaView: View {

    @ObservedObject var estado: EstadoJuego
    
    var body: some View {
        ZStack {
         
            CamaraEnVivoView()
                .ignoresSafeArea()
            
   
            LinearGradient(
                colors: [obtenerColorAmbiente().opacity(0.25), .black.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // reticula
            ViewfinderBorders()
                .stroke(obtenerColorAmbiente(), lineWidth: 2)
                .frame(width: 260, height: 260)
                .opacity(0.7)
            
            // speak nowwwww
            if estado.filtroMoradoActivo {
                Color.purple.opacity(0.35)
                    .ignoresSafeArea()
                    .blendMode(.colorBurn)
                    
                Text("✨ Speak Now filter activated✨")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(6)
                    .background(Capsule().fill(.white))
                    .offset(y: -100)
            }
            
            // (1989 Era)
            if estado.mostrarConfeti {
                Text("🎉 🎵 ⭐ 🎶 🎉 🎵")
                    .font(.system(size: 30))
                    .offset(y: -140)
            }
            
            // (Red Era x kwb)
            if estado.mostrarOsoEnojado {
                VStack(spacing: 12) {
                    Text("🐻")
                        .font(.system(size: 80))
                        .shadow(radius: 10)
                    
                    Text("K.W.B bear is trying to steal ur vinyl!")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        estado.toquesOso += 1
                        if estado.toquesOso >= 3 {
                            estado.mostrarOsoEnojado = false
                            estado.toquesOso = 0
                        }
                    }) {
                        Text("💥 take him down! (hits: \(estado.toquesOso)/3)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red.cornerRadius(8))
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .transition(.scale)
            }
            
            //  Geolocalizacion Interactiva
            VStack {
                Text(estado.ubicacionActualSimulada)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(.black.opacity(0.6)))
                    .padding(.top, 16)
                
                Spacer()
                
                // Dock Inferior: Selector de Vinilos
                VStack(alignment: .leading, spacing: 6) {
                    Text("Scan Vinyls (AR Simulator):")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.leading, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(estado.listaVinilos) { vinilo in
                                Button(action: {
                                    withAnimation {
                                        estado.escanearViniloSimulado(id: vinilo.id)
                                    }
                                }) {
                                    HStack {
                                        Text(vinilo.encontrado ? "✅" : "💿")
                                        Text(vinilo.nombreAlbum)
                                            .fontWeight(.medium)
                                    }
                                    .font(.footnote)
                                    .foregroundColor(vinilo.encontrado ? .green : .white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.15)))
                                }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
            }
        }
    }
    
    private func obtenerColorAmbiente() -> Color {
        if estado.filtroMoradoActivo { return .purple }
        if estado.mostrarOsoEnojado { return .red }
        if estado.mostrarConfeti { return .yellow }
        return .cyan
    }
}

// COMPONENTE INTERNO: ACCESO AL HARDWARE DE LA CAMARA TRASERA
struct CamaraEnVivoView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        let session = AVCaptureSession()
        session.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: backCamera) else {
            return view
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// Dibujo de las esquinas de la camara
struct ViewfinderBorders: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length: CGFloat = 30
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.minY))
        
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + length))
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - length))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - length, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.minX + length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - length))
        
        return path
    }
}
