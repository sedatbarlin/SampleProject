//
//  CategoryViewController.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    private var categoryViewModel = CategoryViewModel()
    private var dayViewModel = DayViewModel()
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        return collectionView
    }()
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
                
                if let firstCell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCell {
                    firstCell.setSelected(true)
                }
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let category = categoryViewModel.categories[indexPath.item]
        cell.configure(with: category)
        
        let isSelected = indexPath == selectedIndexPath
        cell.setSelected(isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? CategoryCell {
            previousCell.setSelected(false)
        }
        
        selectedIndexPath = indexPath
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CategoryCell
        selectedCell?.setSelected(true)
        
        let selectedCategory = categoryViewModel.categories[indexPath.item]
        print("Selected Category: \(selectedCategory.title)")
        
    }
}
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dayViewModel.sections[section].isExpanded {
            return dayViewModel.sections[section].details.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = dayViewModel.sections[indexPath.section]
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.identifier, for: indexPath) as? DayCell else {
                return UITableViewCell()
            }
            cell.configure(with: section)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
                return UITableViewCell()
            }
            
            let detail = section.details[indexPath.row - 1] 
            cell.configure(with: detail)
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let section = indexPath.section
            
            if dayViewModel.sections[section].details.isEmpty {
                dayViewModel.fetchData(for: section) { success in
                    if success {
                        self.dayViewModel.toggleSection(section)
                        DispatchQueue.main.async {
                            tableView.reloadSections([section], with: .automatic)
                        }
                    }
                }
            } else {
                dayViewModel.toggleSection(section)
                tableView.reloadSections([section], with: .automatic)
            }
        }
    }
}
