//
//  ToDoListTableViewCell.swift
//  ToDoList
//
//  Created by Anton Makarov on 18.11.2022.
//

import SnapKit
import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    let textInCells = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    private func setupUI() {
        
        contentView.addSubview(textInCells)
        textInCells.textColor = .black
        textInCells.font = UIFont(name: "AppleSDGothicNeo-Light ", size: 16)
        textInCells.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
}

