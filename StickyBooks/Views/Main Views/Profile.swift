//
//  Profile.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-24.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("BGBeige").edgesIgnoringSafeArea(.all)
               
                
                .navigationTitle("Profile")
                
            }
            
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
