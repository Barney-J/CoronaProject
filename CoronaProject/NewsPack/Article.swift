import Foundation
import UIKit

struct Article: Codable {
    let author: String?
    let title: String
    let url: String?
    let urlToImage: String?
    let content: String?
    let publishedAt: String
}

