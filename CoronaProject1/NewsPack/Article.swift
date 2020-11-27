import Foundation

struct Article : Codable {
    var articles: [List]

    init(articles: [List]? = []) {
        self.articles = articles!
    }

    private enum CodingKeys: String, CodingKey {
        case articles
    }
}

struct List: Codable {
    var author: String?
    var title: String
    var url: String
    var urlToImage: String?
    var content: String

    private enum CodingKeys: String, CodingKey {
            case author,
                 title,
                 url,
                 urlToImage,
                 content
        }

    init(author: String? = nil,
         title: String? = nil,
         url: String? = nil,
         urlToImage: String? = nil,
         content: String? = nil){
            self.author = author!
            self.title = title!
            self.url = url!
            self.urlToImage = urlToImage!
            self.content = content!
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try? container.decode(String.self, forKey: .author)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        urlToImage = try? container.decode(String.self, forKey: .urlToImage)
        content = try container.decode(String.self, forKey: .content)
    }
}

extension Article{
    private enum TopCodingKeys: String, CodingKey {
        case articles
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopCodingKeys.self)
        //articles = try container.decode([List].self, forKey: .articles)
        let meta  = try container.nestedContainer(keyedBy: TopCodingKeys.self,
                                                            forKey: .articles)

        var articleContainer = try meta.nestedUnkeyedContainer(forKey: .articles)

        var articles: [List] = []
        while !articleContainer.isAtEnd {
        let articleList = try articleContainer.decode(List.self)
           articles.append(articleList)
        }
        self.init(articles: articles)
    }
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
