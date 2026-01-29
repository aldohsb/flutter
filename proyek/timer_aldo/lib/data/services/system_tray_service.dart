import 'package:system_tray/system_tray.dart';

class SystemTrayService {
  final SystemTray _systemTray = SystemTray();
  final Menu _menu = Menu();
  
  Function()? onShow;
  Function()? onHide;
  Function()? onStatistics;
  Function()? onCategories;
  Function()? onSettings;
  Function()? onExit;
  Function()? onPauseResume;
  Function()? onReset;
  
  Future<void> init() async {
    // Initialize system tray with icon
    await _systemTray.initSystemTray(
      title: "Timer Aldo",
      iconPath: 'assets/icons/tray_icon.ico',
    );
    
    // Build menu
    await _buildMenu();
    
    // Set up click handlers
    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        onShow?.call();
      } else if (eventName == kSystemTrayEventRightClick) {
        _systemTray.popUpContextMenu();
      }
    });
  }
  
  Future<void> _buildMenu() async {
    await _menu.buildFrom([
      MenuItemLabel(
        label: 'Show Timer',
        onClicked: (menuItem) => onShow?.call(),
      ),
      MenuItemLabel(
        label: 'Hide Timer',
        onClicked: (menuItem) => onHide?.call(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Pause/Resume',
        onClicked: (menuItem) => onPauseResume?.call(),
      ),
      MenuItemLabel(
        label: 'Reset Timer',
        onClicked: (menuItem) => onReset?.call(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Statistics',
        onClicked: (menuItem) => onStatistics?.call(),
      ),
      MenuItemLabel(
        label: 'Categories',
        onClicked: (menuItem) => onCategories?.call(),
      ),
      MenuItemLabel(
        label: 'Settings',
        onClicked: (menuItem) => onSettings?.call(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Exit',
        onClicked: (menuItem) => onExit?.call(),
      ),
    ]);
    
    await _systemTray.setContextMenu(_menu);
  }
  
  Future<void> updateTooltip(String tooltip) async {
    await _systemTray.setToolTip(tooltip);
  }
  
  Future<void> updateTitle(String title) async {
    await _systemTray.setTitle(title);
  }
  
  Future<void> setIcon(String iconPath) async {
    await _systemTray.setImage(iconPath);
  }
  
  Future<void> rebuildMenu() async {
    await _buildMenu();
  }
  
  void dispose() {
    _systemTray.destroy();
  }
}
