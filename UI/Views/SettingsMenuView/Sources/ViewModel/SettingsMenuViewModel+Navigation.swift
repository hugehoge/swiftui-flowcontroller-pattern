import Entities

extension SettingsMenuViewModel {
  enum Navigation: Hashable {
    case menu(row: SettingsMenu.Row)
  }
}
