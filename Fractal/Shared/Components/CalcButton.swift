//
//  CalcButton.swift
//  Fractal
//
//  Created by sen on 11/4/22.
//

import SwiftUI

struct CalcButton: View {
    @State var text: String
    var inputString: String
    @Binding var labelText: String
    var body: some View {
        Button {
            labelText = labelText + text
        } label: {
            Text(text)
                
                
        }
    }
    
}


struct CalcButton_Previews: PreviewProvider {
    static var previews: some View {
        CalcButton(text: "1", inputString: "1", labelText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
