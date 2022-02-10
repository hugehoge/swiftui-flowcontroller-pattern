public enum SettingsMenu {
  public enum Section: CaseIterable {
    case user
    case preferences
    case test
    case app

    public var title: String? {
      switch self {
      case .user:
        return nil

      case .preferences:
        return "Preferences"

      case .test:
        return "Test"

      case .app:
        return "App"
      }
    }

    public var rows: [Row] {
      switch self {
      case .user:
        return [.userName, .userNameSetting]

      case .preferences:
        return [.feedLanguageSetting]

      case .test:
        return [.keyboardTest, .toolbarTest, .pushTransitionTest, .modalTransitionTest]

      case .app:
        return [.licenses, .version]
      }
    }
  }

  public enum RowType {
    case user
    case transition
    case version
  }

  public enum Row {
    case userName
    case userNameSetting
    case feedLanguageSetting
    case keyboardTest
    case toolbarTest
    case pushTransitionTest
    case modalTransitionTest
    case licenses
    case version

    public var title: String? {
      switch self {
      case .userName:
        return nil

      case .userNameSetting:
        return "Edit"

      case .feedLanguageSetting:
        return "Feed language"

      case .keyboardTest:
        return "Keyboard"

      case .toolbarTest:
        return "Toolbar"

      case .pushTransitionTest:
        return "Push transition"

      case .modalTransitionTest:
        return "Modal transition"

      case .licenses:
        return "Licenses"

      case .version:
        return "Version"
      }
    }

    public var type: RowType {
      switch self {
      case .userName:
        return .user

      case .userNameSetting,
           .feedLanguageSetting,
           .keyboardTest,
           .toolbarTest,
           .pushTransitionTest,
           .modalTransitionTest,
           .licenses:
        return .transition

      case .version:
        return .version
      }
    }
  }
}
