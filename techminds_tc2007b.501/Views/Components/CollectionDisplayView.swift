//
//  CollectionDisplay.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 07/06/23.
//

import SwiftUI

struct CollectionDisplayView: ViewModelView {
    typealias ViewModel = CollectionViewModel
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationLink {
            StudentCollectionCardsView(viewModel: viewModel)
        } label: {
            Text(viewModel.collection.name)
                .typography(.title)
                .foregroundColor(Color(cgColor: viewModel.collection.color.cgColor))
                .colorInvert()
                .contrast(3.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(cgColor: viewModel.collection.color.cgColor))
                .cornerRadius(16)
            
        }
    }
}

struct CollectionDisplay_Previews: PreviewProvider {
    @StateObject static var viewModel = CollectionViewModel()
    static var previews: some View {
        CollectionDisplayView(viewModel: viewModel)
    }
}
