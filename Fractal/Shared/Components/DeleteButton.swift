//
//  DeleteButton.swift
//  Fractal
//
//  Created by sen on 11/4/22.
//

import SwiftUI

struct DeleteButton: View {
    @State var text: String
    var inputString: String
    @Binding var labelText: String
    var body: some View {
        Button {
            labelText = labelText + text
        } label: {
            Text(text)
                .foregroundColor(.red)
                
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(text: "Delete", inputString: "", labelText: .constant(""))
    }
}
