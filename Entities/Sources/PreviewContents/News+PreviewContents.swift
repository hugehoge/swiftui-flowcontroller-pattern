import Foundation

extension News {
  // swiftlint:disable force_unwrapping line_length
  public static let appleServices = News(
    title: "Apple services enrich peoples’ lives throughout the year",
    category: "UPDATE",
    date: formatter.date(from: "2022-01-10T17:56:00.624Z")!,
    imageURL: URL(
      string: "https://www.apple.com/newsroom/images/product/apps/standard/2022/Apple_Apps-and-Services-Update_hero.jpg.og.jpg"
    )!,
    linkURL: URL(
      string: "https://www.apple.com/newsroom/2022/01/apple-services-enrich-peoples-lives-throughout-the-year/"
    )!
  )
  public static let appStoreAward = News(
    title: "App Store Awards honor the best apps and games of 2021",
    category: "UPDATE",
    date: formatter.date(from: "2021-12-02T07:58:16.134Z")!,
    imageURL: URL(
      string: "https://www.apple.com/newsroom/images/product/app-store/app-store-awards/Apple_App-Store-Awards-2021_hero_12022021.jpg.og.jpg"
    )!,
    linkURL: URL(
      string: "https://www.apple.com/newsroom/2021/12/app-store-awards-honor-the-best-apps-and-games-of-2021/"
    )!
  )
  public static let appleMusicAward = News(
    title: "Apple announces third annual Apple Music Award winners",
    category: "PRESS RELEASE",
    date: formatter.date(from: "2021-11-30T09:59:13.425Z")!,
    imageURL: URL(
      string: "https://www.apple.com/newsroom/images/product/apple-music/apple_music-awards_hero_11302021.jpg.og.jpg"
    )!,
    linkURL: URL(
      string: "https://www.apple.com/newsroom/2021/11/apple-announces-third-annual-apple-music-award-winners/"
    )!
  )
  public static let appleTheGrove = News(
    title: "The reimagined Apple The Grove now open in Los Angeles",
    category: "PHOTOS",
    date: formatter.date(from: "2021-11-20T01:36:36.974Z")!,
    imageURL: URL(
      string: "https://www.apple.com/newsroom/images/environments/stores/standard/Apple_The-Grove_11192021.jpg.og.jpg"
    )!,
    linkURL: URL(
      string: "https://www.apple.com/newsroom/2021/11/the-reimagined-apple-the-grove-now-open-in-los-angeles/"
    )!
  )
  public static let sharePlay = News(
    title: "SharePlay powers new ways to stay connected and share experiences in FaceTime",
    category: "UPDATE",
    date: formatter.date(from: "2021-11-18T14:57:31.226Z")!,
    imageURL: URL(
      string: "https://www.apple.com/newsroom/images/product/os/ios/standard/shareplay-november-18/Apple_SharePlay_Ted-Lasso_11182021.jpg.og.jpg"
    )!,
    linkURL: URL(
      string: "https://www.apple.com/newsroom/2021/11/shareplay-powers-new-ways-to-stay-connected-and-share-experiences-in-facetime/"
    )!
  )
  // swiftlint:enable force_unwrapping line_length

  public static let previewContentList: [News] = [
    appleServices,
    appStoreAward,
    appleMusicAward,
    appleTheGrove,
    sharePlay,
  ]

  private static let formatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)
    return formatter
  }()
}
