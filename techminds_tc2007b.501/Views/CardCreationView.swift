//
//  CardCreationView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import SwiftUI
import PhotosUI

struct CardCreationView: View {
    typealias ViewModel = CardCreationViewModel
    
    @State private var imageSelection: PhotosPickerItem?
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var incomplete = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 32){
            CardView(viewModel: viewModel)
            
            LabelledTextBox(label: "Nombre", placeholder: "Ingresa el nombre de la tarjeta", content: $viewModel.card.name)
            
            PhotosPicker(selection: $imageSelection) {
                Label("Seleccionar imagen", systemImage: "pencil")
            }
            .onChange(of: imageSelection) { _ in
                if let imageSelection {
                    imageSelection.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                Task {
                                    await MainActor.run {
                                        viewModel.cardImage = UIImage(data: data)
                                    }
                                }
                                
                            } else {
                                print("unsupported format")
                            }
                        case .failure(_):
                            print("failure retrieving image")
                        }
                    }
                } else {
                    print("empty")
                }
            }
            
            FilledButton(labelText: "Guardar cambios") {
                if viewModel.card.name == "" || imageSelection == nil{
                    incomplete = true
                } else {
                    viewModel.create()
                    dismiss()
                }
            }
            .popover(isPresented: $incomplete) {
                ZStack {
                    Color("primary lighter")
                        .scaleEffect(1.5)
                    Text("Datos insuficientes")
                        .typography(.callout)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("primary"))
                }
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}

struct CardCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CardCreationView()
    }
}
