//
//  ProjectDetail.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import SwiftUI

struct ProjectDetail: View {
    @EnvironmentObject var viewModel: ViewModel;
    @Environment(\.presentationMode) var presentationMode;
    let item: ProjectModel;
    @State var name = "";
    @State var description = "";
    
    
    var body: some View {
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
                .onAppear(perform: {
                    self.name = item.Name
                    self.description = item.Description
                })
        }
        
        .navigationBarTitle("Edit Project", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    
    var trailing: some View {
        Button(action: {
            
            if name != "" && description != "" {
                let params: [String: Any] = ["Id": item.Id, "Name": name, "Description": description, "WorkspaceVisibility": 1];
                viewModel.updateProject(params: params);
                viewModel.fetchProjects();
                presentationMode.wrappedValue.dismiss();
            }
                
        }, label: {
            Text("Save");
        });
    }
}

//struct ProjectDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetail()
//    }
//}
