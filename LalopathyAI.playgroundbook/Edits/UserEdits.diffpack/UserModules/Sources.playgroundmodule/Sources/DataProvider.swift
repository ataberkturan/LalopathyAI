
import Foundation

public class DataProvider {
    
    // Life Cycle.
    public init() {}
    
    /// Function of getting app data from JSON file.
    public func getData(dataName: String) -> [String] {
        // The data will be added to this array.
        var dataArray = [String]()
    
        // Getting the url of file.
        if let fileUrl = Bundle.main.url(forResource: "AppData", withExtension: "json") {
            do {
                // Get jSON data from file.
                let data = try Data(contentsOf: fileUrl)
                
                do {
                    // Getting all data from jSON file.
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let appData = json["AppData"] as? [String: Any] {
                            dataArray = appData[dataName]! as! [String]
                        }
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            } catch {
                print("Error: \(error)")
            }
    }
    
    return dataArray
    }
}
