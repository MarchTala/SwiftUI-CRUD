//
//  ContentView.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel;
    @State var isPresentedNewProject = false;
    @State var name = "";
    @State var description = "";
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.Id) { item in
                    NavigationLink(
                        destination: ProjectDetail(item: item),
                        label: {
                            VStack(alignment: .leading) {
                                Text(item.Name)
                                Text(item.Description).font(.caption).foregroundColor(.gray)
                            }
                        }
                    )
                }.onDelete(perform: deleteProject)
                
            }
            .listStyle(InsetListStyle())
            .refreshable {
                reload()
            }
            
            .navigationBarTitle("Projects")
            .navigationBarItems(trailing: plusButton)
            
            
        }.sheet(isPresented: $isPresentedNewProject, content: {
            NewProjectView(isPresented: $isPresentedNewProject, name: $name, description: $description);
        }).navigationViewStyle(.stack)
    }
    
    func reload() {
        print("Refreshing...");
        self.viewModel.fetchProjects();
        print("Refresh Done");
    }
    
    private func deleteProject(indexSet: IndexSet) {

        let id = indexSet.map { viewModel.items[$0].Id }

        DispatchQueue.main.async {
            let params: [String: Any] = ["Id": id[0]]
            print(params)

            print(indexSet)
            self.viewModel.items.remove(atOffsets: indexSet)
            self.viewModel.deleteProject(params: params)
//            self.viewModel.fetchProjects();
        }
    }
    
    var plusButton: some View {
        Button(action: {
            isPresentedNewProject.toggle()
        }, label: {
            Image(systemName: "plus");
        });
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
