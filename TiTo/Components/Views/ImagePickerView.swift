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
                    .frame(width: 100, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            } else {
                Image("produkt1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            Rectangle()
                .frame(width: 2, height: 80)
                .foregroundColor(Color("advertisment"))
            
            
            PhotosPicker(selection: $photoPickerViewModel.imageSelection, matching: .images) {
                
                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 70, height: 50)
            }
            Spacer()
        }
    }
}

#Preview {
    ImagePickerView()
        .environmentObject(PhotosPickerViewModel())
}
