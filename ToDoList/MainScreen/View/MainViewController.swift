//
//  MainViewController.swift
//  ToDoList
//
//  Created by Anton Makarov on 17.11.2022.
//

import SnapKit
import UIKit
import CoreData

class MainViewController: UIViewController {
    
    let label = UILabel()
    let buttonBackground = UIButton(type: .system)
    let buttonAddTask = UIButton(type: .system)
    let tableView = UITableView()
   
    
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

// MARK: - setupUI
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.text = "🗒ToDoList"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
        }
        
        view.addSubview(buttonBackground)
        buttonBackground.backgroundColor = .clear
        buttonBackground.tintColor = .black
        buttonBackground.setImage(UIImage(systemName: "paintbrush.fill"), for: .normal)
        buttonBackground.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        buttonBackground.addTarget(self, action: #selector(buttonBackgroundTapped), for: .touchUpInside)
        buttonBackground.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.right.equalToSuperview().inset(20)
        }
        
        view.addSubview(buttonAddTask)
        buttonAddTask.backgroundColor = .clear
        buttonAddTask.tintColor = .black
        buttonAddTask.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        buttonAddTask.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        buttonAddTask.addTarget(self, action: #selector(addTaskTapped), for: .touchUpInside)
        buttonAddTask.snp.makeConstraints { make in
            make.centerY.equalTo(label)
            make.right.equalTo(buttonBackground).inset(40)
        }
        
        view.addSubview(tableView)
        tableView.bounces = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: idToDoListTableViewCell)
        tableView.reloadData()
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    let idToDoListTableViewCell = "idToDoListTableViewCell"
    
    private let presenter: MainViewPresenterProtocol
    
    private var tasks = [TaskModel]()

//MARK: - funcTapped
    
    @objc private func buttonBackgroundTapped() {
       
        let backgroundColor = view.backgroundColor
        
        switch backgroundColor {
        case UIColor.white:
            view.backgroundColor = .yellow
            tableView.backgroundColor = .yellow
        case UIColor.yellow:
            view.backgroundColor = .cyan
            tableView.backgroundColor = .cyan
        case UIColor.cyan:
            view.backgroundColor = .orange
            tableView.backgroundColor = .orange
        case UIColor.orange:
            view.backgroundColor = .link
            tableView.backgroundColor = .link
        case UIColor.link:
            view.backgroundColor = .white
            tableView.backgroundColor = .white
        default: break
        }
    }

    @objc private func addTaskTapped() {
        
        let alertController = UIAlertController(title: "New task",
                                                message: "Enter new task",
                                                preferredStyle: .alert)
        
        let saveTask = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTask = textField?.text {
                self.presenter.addTask(task: newTask)
            }
        }
        
        alertController.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func addTask(newTask: TaskModel) {
        tasks.append(newTask)
        tableView.reloadData()
    }
    
    func deletetask(index: Int) {
        tasks.remove(at: index)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idToDoListTableViewCell, for: indexPath) as! ToDoListTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textInCells.text = tasks[indexPath.row].task
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else { return }
            self.presenter.deletetask(index: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

