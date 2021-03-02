import Foundation

class SeasonModel {
    
    var episodes = [Episode]()
    
    var seasonNumbers: [String] {
        return [String](self.seasons().keys).sorted{ $0 < $1 }
    }
    
    func seasons() -> [String: [Episode]] {
        var newSeasons = [String: [Episode]]()
        
        for episode in episodes {
            var tempArray = [Episode]()
            var seasonNumber = episode.seasonNumber
            seasonNumber = seasonNumber.trimmingCharacters(in: .whitespaces)
            
            if let season = newSeasons[seasonNumber] {
                tempArray = season
                tempArray.append(episode)
                newSeasons[seasonNumber] = tempArray
            } else {
                newSeasons[seasonNumber] = [episode]
            }
        }
        return newSeasons
    }
    
    func seasonBy(seasonNumber: String) -> [Episode] {
        guard let season = seasons()[seasonNumber] else { return [] }
        return season
    }
    
}
