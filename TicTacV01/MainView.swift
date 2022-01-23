//
//  MainView.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 02/09/21.
//

import SwiftUI

struct MainView:View{
    
    let x = (UIScreen.main.bounds.width - 60)/3
    @State var moves:[String] = Array(repeating: "", count: 9)
    @State var isPlaying:Bool = false
    @State var GameOver:Bool = false
    @StateObject var AddWinnerVM:AddWinnerViewModel
    @StateObject var MatchWinnerListVM:MatchWinnerListViewModel
    @State var MoreINFO:Bool = false
    
    var body: some View{
        VStack{
//*******************************************************************************************************
//***                              Game History                                                       ***
//*******************************************************************************************************
            List{
                ForEach(MatchWinnerListVM.WinnerData, id: \.id){j in
                    if j.playerA {
                        Text("Player A Won")
                    }
                    if j.playerB{
                        Text("Player B Won")
                    }
                    if j.draw{
                        Text("Draw")
                    }
                }.onDelete(perform: delData)
            }
//*******************************************************************************************************
//***                              GAME GRID                                                          ***
//*******************************************************************************************************
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 3)) {
                ForEach(0...8, id: \.self) { i in
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .frame(width: x, height: x, alignment: .center)
                            .cornerRadius(10)
                            .padding(.vertical,10)
                            
                        
                        Text(moves[i])
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                        
                        
                    }.onTapGesture {
                        withAnimation(.linear(duration: 0.05)){
                            if moves[i] == "" {
                                moves[i] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    }
                }
            }
            
            HStack(spacing: 50){
                Button(action: {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                }, label: {
                    Text("Start Again")
                        .font(.system(size: 20))
                        .frame(width: 130, height: 50, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top,40)
                })
                Button(action: {
                    MoreINFO.toggle()
                }, label: {
                    Text("More Info")
                        .font(.system(size: 20))
                        .frame(width: 130, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top,40)
                }).sheet(isPresented: $MoreINFO, content: {
                    MoreInfoView()
                })
            }

            
        }.onChange(of: moves, perform: { value in
            CheckWinner()
            if isPlaying{
                MatchWinnerListVM.GetALLData()
            }
            
        })
        .alert(isPresented: $GameOver, content: {
            Alert(title: Text("Game Over"), message: Text(""), dismissButton: .destructive(Text("Play Again"), action: {
                moves.removeAll()
                moves = Array(repeating: "", count: 9)
                isPlaying = true
            })
            )
        })
    }
//*******************************************************************************************************
//***                             LOGIC                                                               ***
//*******************************************************************************************************
    
    //  LOGIC
    func CheckWinner(){
        if CheckMoves(player: "X"){
            AddWinnerVM.PlayerA = true
            AddWinnerVM.PlayerB = false
            AddWinnerVM.Draw = false
            GameOver.toggle()
            AddWinnerVM.SaveWinnerDetails()
            
            
        }
        
        else if CheckMoves(player: "O"){
            AddWinnerVM.PlayerA = false
            AddWinnerVM.PlayerB = true
            AddWinnerVM.Draw = false
            AddWinnerVM.SaveWinnerDetails()
            GameOver.toggle()
        }
        else{
            let status = moves.contains{ (value) -> Bool in
                return value == ""
            }
            
            if !status{
                AddWinnerVM.PlayerA = false
                AddWinnerVM.PlayerB = false
                AddWinnerVM.Draw = true
                AddWinnerVM.SaveWinnerDetails()
                GameOver.toggle()
            }
        }
    }
    //    CheckMoves
    func CheckMoves(player:String)->Bool{
        for i in stride(from: 0, to: 9, by: 3){
            if moves[i] == player && moves[i+1] == player && moves[i+2] == player{
                
                return true
            }
            for i in 0...2{
                if moves[i] == player && moves[i+3] == player && moves[i+6] == player{
                    return true
                }
            }
            if moves[2] == player && moves[4] == player && moves[6] == player{
                return true
            }
            if moves[0] == player && moves[4] == player && moves[8] == player{
                return true
            }
        }
        return false
    }
    
    func delData(at indexSet:IndexSet){
        indexSet.forEach { j in
            let addWinner = MatchWinnerListVM.WinnerData[j]
            MatchWinnerListVM.DelData(data: addWinner)
            MatchWinnerListVM.GetALLData()
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(AddWinnerVM: AddWinnerViewModel(), MatchWinnerListVM: MatchWinnerListViewModel())
            .preferredColorScheme(.dark)
    }
}
