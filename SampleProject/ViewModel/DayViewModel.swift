//
//  DayViewModel.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import Foundation
import UIKit

class DayViewModel {
    var sections: [DaySection] = [
        DaySection(title: "Saturday", isExpanded: false, details: []),
        DaySection(title: "Sunday", isExpanded: false, details: [])
    ]
    
    private let apiService = APIService()
    
    func fetchData(for section: Int, completion: @escaping (Bool) -> Void) {
        if section == 0 {
            apiService.fetchSponsors { result in
                switch result {
                case .success(let sponsorCategories):
                    let details = sponsorCategories.flatMap { $0.sponsors.map { DetailInfo(title: $0.title, time: nil, stage: "Sponsor", category: "Sponsors") } }
                    self.sections[section].details = details
                    completion(true)
                case .failure(let error):
                    print("Error fetching sponsors: \(error)")
                    completion(false)
                }
            }
        } else if section == 1 {
            apiService.fetchSeminars { result in
                switch result {
                case .success(let seminars):
                    
                    let details = seminars.map { DetailInfo(title: $0.name, time: $0.time, stage: $0.location.title, category: "Seminar") }
                    self.sections[section].details = details
                    completion(true)
                case .failure(let error):
                    print("Error fetching seminars: \(error)")
                    completion(false)
                }
            }
        }
    }
    
    func toggleSection(_ section: Int) {
        sections[section].isExpanded.toggle()
    }
}
