import Foundation

extension AppInformation { // swiftlint:disable:this extension_access_modifier
  // swiftlint:disable force_unwrapping line_length
  public static let youtube = AppInformation(
    name: "YouTube: Watch, Listen, Stream",
    seller: "Google LLC",
    iconURL: URL(
      string: "https://is3-ssl.mzstatic.com/image/thumb/Purple116/v4/d0/8d/34/d08d342b-c581-bc37-e6d5-79ba90a8d0de/logo_youtube_color-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png"
    )!,
    storeURL: URL(string: "https://apps.apple.com/us/app/youtube-watch-listen-stream/id544007664?uo=2")!
  )
  public static let facebook = AppInformation(
    name: "Facebook",
    seller: "Meta Platforms, Inc.",
    iconURL: URL(
      string: "https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/8b/f6/6f/8bf66f1e-9de5-583e-27b6-58f3180ccf6b/Icon-Production-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png"
    )!,
    storeURL: URL(string: "https://apps.apple.com/us/app/facebook/id284882215?uo=2")!
  )
  public static let tiktok = AppInformation(
    name: "TikTok",
    seller: "TikTok Ltd.",
    iconURL: URL(
      string: "https://is5-ssl.mzstatic.com/image/thumb/Purple126/v4/3f/68/f2/3f68f20b-fd7d-f518-0fd0-4d20a6e1c8d2/AppIcon_TikTok-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png"
    )!,
    storeURL: URL(string: "https://apps.apple.com/us/app/tiktok/id835599320?uo=2")!
  )
  public static let snapchat = AppInformation(
    name: "Snapchat",
    seller: "Snap, Inc.",
    iconURL: URL(
      string: "https://is2-ssl.mzstatic.com/image/thumb/Purple116/v4/a8/94/16/a8941680-17cb-e9ff-df64-2b3341608cf4/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png"
    )!,
    storeURL: URL(string: "https://apps.apple.com/us/app/snapchat/id447188370?uo=2")!
  )
  public static let zoom = AppInformation(
    name: "ZOOM Cloud Meetings",
    seller: "Zoom Video Communications, Inc.",
    iconURL: URL(
      string: "https://is5-ssl.mzstatic.com/image/thumb/Purple126/v4/e2/2d/57/e22d57ae-015e-1247-9d19-d421effdad91/AppIcon-0-1x_U007emarketing-0-9-0-85-220.png/100x100bb.png"
    )!,
    storeURL: URL(string: "https://apps.apple.com/us/app/zoom-cloud-meetings/id546505307?uo=2")!
  )
  // swiftlint:enable force_unwrapping line_length

  public static let previewContentList: [AppInformation] = [
    youtube,
    facebook,
    tiktok,
    snapchat,
    zoom,
  ]
}
