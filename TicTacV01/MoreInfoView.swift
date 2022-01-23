//
//  MoreInfoView.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 02/09/21.
//

import SwiftUI

struct MoreInfoView: View {
    @State var ispressing:Bool = false
    var body: some View {
        VStack{
            Text("Made by")
            
            ZStack {
                
                Rectangle()
                    .frame(width: ispressing ? 300: 0, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .foregroundColor(.blue)
                
                Text(ispressing ? "Harsh": "")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 100, alignment: .center)
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 2, maximumDistance: 4) {
                        ispressing.toggle()
                }
                

            }


            
            Spacer()
        }.padding()
    }
}

struct MoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoView()
    }
}
