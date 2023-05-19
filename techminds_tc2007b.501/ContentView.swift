//
//  ContentView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 05/05/23.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [
            .font : UIFont(name: "Comfortaa", size: 48)!,
        ]
        navBarAppearance.titleTextAttributes = [
            .font : UIFont(name: "Comfortaa-SemiBold", size: 32)!,
        ]
        
        navBarAppearance.layoutMargins = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48)
    }
    
    var body: some View {
        NavigationView {
            SelectedCollectionView()
        }
        .navigationViewStyle(.stack)
        .toolbar {
            Button("< Regresar") {
                print("Regresar")
            }
            Button {
                print("Configuraciones")
            } label: {
                Image(systemName: "pencil.line")
                    .foregroundColor(Color("primary"))
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
