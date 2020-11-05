import Foundation

struct Article: Codable {
    let author: String
    let title: String
    
    init(_ author: String , _ title: String) {
        self.author = author
        self.title = title
    }
    
    static let titleCell = [
        "Alberto Ruiz - 7 Elements (Original Mix)",
        "Dave Wincent - Red Eye (Original Mix)",
        "E-Spectro - End Station (Original Mix)",
        "Edna Ann - Phasma (Konstantin Yoodza Remix)",
        "Ilija Djokovic - Delusion (Original Mix)",
        "John Baptiste - Mycelium (Original Mix)",
        "Lane 8 - Fingerprint (Original Mix)",
        "Mac Vaughn - Pink Is My Favorite Color (Alex Stein Remix)",
        "Metodi Hristov, Gallya - Badmash (Original Mix)",
        "Veerus, Maxie Devine - Nightmare (Original Mix)"
    ]
    
    
    static let authorCell = [
        "Jacob ",
        "Charlie",
        "Thomas",
        "Harry",
        "Jack",
        "Leo",
        "Barney Jackson",
        "Dylan",
        "Max",
        "Tyler"
    ]
    
    static func getTitle() -> [Article] {
        var addTitleCell = [Article]()
        for titles in titleCell{
            addTitleCell.append(Article("", titles))
        }
        return addTitleCell
    }
    
    static func getAuthor() -> [Article] {
        var addAuthorCell = [Article]()
        for author in authorCell{
            addAuthorCell.append(Article(author, ""))
        }
        return addAuthorCell
    }
    
}


   
    
    

