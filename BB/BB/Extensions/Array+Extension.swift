import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dictionary = [Key:Element]()
        for element in self {
            dictionary[selectKey(element)] = element
        }
        return dictionary
    }
}
