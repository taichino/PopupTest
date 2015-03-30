## PopupTest
Statusbar app sample for Mac (Yosemite or later)

![Screenshot](https://raw.githubusercontent.com/taichino/PopupTest/master/screenshot/screenshot.png)

## Steps
1. Add LSUIElement to Info.plist and set it YES
2. Create NSStatusItem in AppDelegate
3. Configure images and an action to NSStatusItem.button
4. Show NSPopover from the button action

#### Note
See header files of NSStatusItem and NSStatusBarButton for details. They don't show up in official documents for some reason.

## License
MIT
