//
//  ContentView.swift
//  URLShotner
//
//  Created by Sergei on 21.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = ""
    @StateObject var ViewModel = viewModel()
    
      var body: some View {
        NavigationView{
            ScrollView(.vertical){
               header()
                ForEach(ViewModel.models, id: \.self){ model in
                    VStack {
                        Text("https://1pt.co/"+model.short)
                        Text(model.long)
                    }
                    
                    .padding()
                    .onTapGesture {
                        guard let url = URL(string: "https://1pt.co/"+model.short) else{
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            .navigationTitle("SHORT URLS")
        }
    }
    
    @ViewBuilder
    func header() -> some View{
        VStack{
           Text("Enter URL to be shortened.")
            .bold()
            .font(.system(size: 24))
            .foregroundColor(.white)
            .padding()
            
            TextField("URL...", text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding()
            
            Button(
                action: {
                   //make api ca;;
                    guard !text.isEmpty else{
                        return
                    }
                    ViewModel.submit(urlString: text)
                    text = ""
                }
            , label: {
                Text("SUBMIT")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .cornerRadius(8, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
            })
        }
     
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.width)
        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
