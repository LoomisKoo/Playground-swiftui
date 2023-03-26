import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let poster: String
    let releaseDate: String
    let rating: String
    let description: String
}

class MockData {
    static let hotMovies = [
        Movie(title: "黑寡妇", poster: "film.fill", releaseDate: "2021-07-09", rating: "7.9", description: "女间谍红寡妇进行特训"),
        Movie(title: "绿巨人", poster: "bolt.fill", releaseDate: "2021-07-02", rating: "8.0", description: "布鲁斯获得超级力量"),
        Movie(title: "无双", poster: "suit.heart.fill", releaseDate: "2018-09-30", rating: "8.3", description: "周涌拜入武痴山庄门下"),
        Movie(title: "鹿鼎记", poster: "hare.fill", releaseDate: "2021-02-12", rating: "6.8", description: "小宝成为鹿鼎公"),
        Movie(title: "冰雪奇缘2", poster: "snow", releaseDate: "2019-11-22", rating: "7.5", description: "女王伊莎贝拉的冒险")
    ]
    
    static let favoriteMovies = [
        Movie(title: "流浪地球", poster: "globe", releaseDate: "2019-02-05", rating: "7.9", description: "地球撤离计划"),
        Movie(title: "复仇者联盟4", poster: "person.2.fill", releaseDate: "2019-04-24", rating: "8.3", description: "反抗灭霸的英雄们"),
        Movie(title: "大赢家", poster: "crown.fill", releaseDate: "2021-07-30", rating: "7.5", description: "“猫和老鼠”大战"),
        Movie(title: "刺杀小说家", poster: "book.closed.fill", releaseDate: "2017-08-08", rating: "7.4", description: "人生如小说，谁在操纵谁？"),
        Movie(title: "阿凡达", poster: "film.fill", releaseDate: "2009-12-16", rating: "8.6", description: "赤裸裸的绿色政治")
    ]
}
