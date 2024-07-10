//
//  MemberListView.swift
//  Trends
//
//  Created by mac on 2023/7/15.
//

import SwiftUI
import UIKit
struct MemberListView: View {
    @ObservedObject var manage = Manage()
    @State private var searchText = ""
    @State private var showCancelButton = false
    var body: some View {
        VStack{
            SearchBar(text: $searchText, showCancelButton: $showCancelButton)
                .padding(.top)
            
            List(manage.members) { item in
                MemberItemView(member: item) {
                    item.isFollow.toggle()
                }
            }
            .listStyle(.plain)
        }
        .onAppear(){
            manage.loadData()
        }
    }
}
extension MemberListView{
    class Manage:ObservableObject{
        @Published var members:[Member] = []
        
        func loadData(){
            members = Member.mocks(num: 20)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var showCancelButton: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 10)
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
            }
            .foregroundColor(.gray)
            .padding(.trailing, 10)
            .opacity(text == "" ? 0 : 1)
            
            if showCancelButton {
                Button("Cancel") {
//                    UIApplication.shared.endEditing(true)
                    self.text = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
