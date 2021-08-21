//
//  viewModel.swift
//  URLShotner
//
//  Created by Sergei on 21.08.2021.
//

import Foundation

struct Model: Hashable{
    let long: String
    let short: String
}

class viewModel: ObservableObject {
    
    @Published var models =  [Model]()
    
    
    func submit(urlString: String){
        guard URL(string: urlString) != nil else {
            return
        }
        
        //API Call
        guard let apiURL = URL(string: "https://api.1pt.co/addURL?long="+urlString.lowercased()) else{
            return
        }
        print(apiURL)
        let task = URLSession.shared.dataTask(with: apiURL) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do{
                let result = try JSONDecoder().decode(APIResponse.self,  from: data)
                let long = result.long
                let short = result.short
                DispatchQueue.main.async{
                    self?.models.append(.init(long: long, short: short))
                }
                
            }
            catch{
                print(error)
            }
            
            
        }
        task.resume()
    }
}


struct APIResponse: Codable{
    let status: Int
    let message: String
    let short: String
    let long: String
}
 
