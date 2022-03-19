//
//  NewProjectView.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import SwiftUI

struct NewProjectView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @Binding var name: String
    @Binding var description: String
    @State var isAlert = false;
     
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all);
                VStack(alignment: .leading) {
                    Text("Create new project")
                        .font(Font.system(size: 16, weight: .bold))
                    
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Write something...", text: $description)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No Data");
                        let message = Text("Name and Description are required!");
                        return Alert(title: title, message: message);
                    })
            }
            
            .navigationBarTitle("New Project", displayMode: .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    
    var leading: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel");
        });
    }
    
    var trailing: some View {
        Button(action: {
            if name != "" && description != "" {
                let params: [String: Any] = ["Name": name, "Description": description, "WorkspaceVisibility": 1];
                viewModel.createProject(params: params);
                
                self.name = "";
                self.description = "";
                isPresented.toggle();
            } else {
                isAlert.toggle();
            }
        }, label: {
            Text("Save");
        });
    }
}

//struct NewProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProjectView()
//    }
//}
