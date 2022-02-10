import SafariServices

extension UIViewController {
  public func openInternally(link url: URL) {
    let vc = SFSafariViewController(url: url)

    present(vc, animated: true)
  }

  public func openExternally(link url: URL) {
    UIApplication.shared.open(url, options: [:])
  }
}
