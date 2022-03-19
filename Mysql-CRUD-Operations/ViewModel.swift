//
//  ViewModel.swift
//  Mysql-CRUD-Operations
//
//  Created by March Tala on 3/19/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var items = [ProjectModel]();
    let prefixUrl = "http://taskboard-api:8888";
    
    init() {
        fetchProjects();
    }
    
    func fetchProjects() {
        guard let url = URL(string: "\(prefixUrl)/api/projects") else {
            print("URL Not Found");
            return;
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, error) in

            if error != nil {
                print("Error", error?.localizedDescription ?? "");
                return;
            }

            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.Projects;
                    }
                } else {
                    print("No Data Found.");
                }
            } catch let JsonError {
                print("Fetch json error 1:", JsonError.localizedDescription);
            }
        }.resume()
    }
    
    func createProject(params: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/api/add-project") else {
            print("URL Not Found");
            return;
        }
        
        let data = try! JSONSerialization.data(withJSONObject: params);
        
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.httpBody = data;
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("Error", error?.localizedDescription ?? "");
                return;
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result.Projects);
//                        self.items = result.Projects;
                        self.items.append(contentsOf: result.Projects)
                        
                    }
                } else {
                    print("No Data Found.");
                }
            } catch let JsonError {
                print("Fetch json error:", JsonError.localizedDescription);
            }
        }.resume()
    }
    
    func updateProject(params: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/api/update-project") else {
            print("URL Not Found");
            return;
        }
        
        let data = try! JSONSerialization.data(withJSONObject: params);
        
        var request = URLRequest(url: url);
        request.httpMethod = "PUT";
        request.httpBody = data;
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("Error", error?.localizedDescription ?? "");
                return;
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result);
                        self.fetchProjects();
                    }
                } else {
                    print("No Data Found.");
                } 
            } catch let JsonError {
                print("Fetch json error:", JsonError.localizedDescription);
            }
        }.resume()
    }
    
    //MARK: - DELETE
    func deleteProject(params: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/api/delete-project") else {
            print("URL Not Found");
            return;
        }
        
        let data = try! JSONSerialization.data(withJSONObject: params);
        
        var request = URLRequest(url: url);
        request.httpMethod = "DELETE";
        request.httpBody = data;
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");
        
        URLSession.shared.dataTask(with: request) { (data, res, error) in
            if error != nil {
                print("Error", error?.localizedDescription ?? "");
                return;
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result);
                        self.fetchProjects();
                    }
                } else {
                    print("No Data Found.");
                }
            } catch let JsonError {
                print("Fetch json error:", JsonError.localizedDescription);
            }
        }.resume()
    }
}
