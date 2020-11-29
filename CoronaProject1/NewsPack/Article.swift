import Foundation
import UIKit


struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


// MARK: - Article
struct Article: Codable {
    let author: String?
    let title: String
    let url: String?
    let urlToImage: String?
    let content: String?

}

/*
 "articles":[
         "author": "Terrell Forney, Michelle Solomon",
         "title": "Superspreader event in Wynwood sign of the times as to why COVID-19 cases are rising - WPLG Local 10",
         "description": "COVID-19 cases are on the rise again and an infectious disease expert said South Florida is seeing a troubling trend.",
         "url": "https://www.local10.com/news/local/2020/11/16/superspreader-event-in-wynwood-sign-of-the-times-as-to-why-covid-19-cases-are-rising/",
         "urlToImage": "https://www.local10.com/resizer/iD_cQ_hfRxqESa43kfANjJhJv5c=/1600x900/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/d1vhqlrjc8h82r.cloudfront.net/11-16-2020/t_f85b328de30a46cea18095a89018bfae_name_image.jpg",
         "publishedAt": "2020-11-16T17:57:04Z",
         "content": "MIAMI, Fla. Hundreds of people were packed in side by side Saturday night at an outdoor concert in Wynwood. They were there to see Jamaican dance-hall artist Shenseea performing, but without any obvi… [+2845 chars]"
 */
