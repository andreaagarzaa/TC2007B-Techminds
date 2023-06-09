//
//  CardView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 08/06/23.
//

import SwiftUI

struct CardView: ViewModelView {
    typealias ViewModel = CardViewModel
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button {
        } label: {
            VStack(spacing: 32) {
                if let image = viewModel.cardImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                    
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color("primary lighter"))
                            .frame(maxWidth: .infinity)
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("primary"))
                            .frame(maxWidth: 128, maxHeight: 128)
                    }
                }
                Text(viewModel.card.name)
                    .typography(.title)
                    .foregroundColor(Color("primary lighter"))
            }
            .padding(EdgeInsets(top: 24, leading: 32, bottom: 24, trailing: 32))
            .background(Color("primary"))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

struct CardView_Previews: PreviewProvider {
    @StateObject static var viewModel = CardViewModel(card: Card(name: "Example card"))
    static var previews: some View {
        CardView(viewModel: viewModel)
    }
}