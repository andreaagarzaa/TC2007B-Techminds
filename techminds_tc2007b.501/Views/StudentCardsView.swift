//
//  CardsView.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 19/05/23.
//

import SwiftUI

struct StudentCardsView: View {
    var body: some View {
        Grid {
            GridRow {
                CardButton(action: "", cardColor: "primary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardColor: "accent1 lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardColor: "accent2 lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "accent2 darker")
            }
            GridRow {
                CardButton(action: "", cardColor: "secondary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "secondary darker")
                
                CardButton(action: "", cardColor: "accent2 lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "accent2 darker")
                
                CardButton(action: "", cardColor: "secondary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "secondary darker")
            }
            GridRow {
                CardButton(action: "", cardColor: "accent1 lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "accent1 darker")
                
                CardButton(action: "", cardColor: "primary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "primary darker")
                
                CardButton(action: "", cardColor: "primary lighter", cardImage: "perro", cardTitle: "Perro", titleColor: "primary darker")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                    
                }
            }
        }
        .navigationTitle("Tarjetas")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCardsView()
    }
}