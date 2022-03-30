//
//  MeView.swift
//  HotProspects
//
//  Created by Alexey Morozov on 20.03.2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name: String = "Anonymus"
    @State private var email: String = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: generateQrCode(from: "\(name)\n\(email)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                
                Form {
                    
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                    
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .font(.title)
                }
            }
            .navigationTitle("Your code")
        }
    }
    
    func generateQrCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgiImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgiImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
