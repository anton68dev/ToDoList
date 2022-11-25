//
//  MainPresenter.swift
//  ToDoList
//
//  Created by Anton Makarov on 23.11.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func addTask(newTask: TaskModel)
    func deletetask(index: Int)
}

protocol MainViewPresenterProtocol: AnyObject {
    func addTask(task: String)
    func deletetask(index: Int)
}
 
class MainPresenter: MainViewPresenterProtocol {

    private weak var view: MainViewProtocol?
    
    func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    func addTask(task: String) {
        let task = TaskModel(task: task)
        self.view?.addTask(newTask: task)
    }
    
    func deletetask(index: Int) {
        self.view?.deletetask(index: index)
    }
}
