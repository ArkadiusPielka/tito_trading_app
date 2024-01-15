//
//  ImagePickerView.swift
//  TiTo
//
//  Created by Arkadius Pielka on 15.01.24.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    
    @EnvironmentObject var photoPickerViewModel: PhotosPickerViewModel
    
    
    var body: some View {
        
        HStack(spacing: 16) {
            if let imageData = photoPickerViewModel.selectedImage {
                Image(uiImage: imageData)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            } else {
                Image("produkt1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            Rectangle()
                .frame(width: 2, height: 30)
                .foregroundColor(Color("advertisment"))
            
            
            PhotosPicker(selection: $photoPickerViewModel.imageSelection, matching: .images, preferredItemEncoding: .automatic) {
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 40, height: 30)
            }
            Spacer()
        }
    }
}

#Preview {
    ImagePickerView()
        .environmentObject(PhotosPickerViewModel())
}
