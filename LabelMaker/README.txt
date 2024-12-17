tutorial order: 9
tutorial at https://developer.apple.com/tutorials/develop-in-swift/present-common-controls-in-an-ornament

Reflect on the concepts:
Creating windows
Creating windows in visionOS lets you present content in separate windows that can be positioned independently in 3D space. This can be a useful way to convey information relevant to a specific location in space.
Ornaments
Ornaments are a window element unique to visionOS. They float in a plane parallel to the associated window and slightly in front of it along the z-axis. They move in tandem with the associated window, maintaining their relative position, and remain in place if the contents of the window scroll. This means the contents of an ornament are always available but don’t crowd or obscure the window’s contents.
It can make sense to hide an ornament at times, but in most cases an ornament should always be visible. It’s possible to display multiple ornaments, but you should always prioritize the overall visual balance of the window.

Topics and skills covered:
Using visionOS-specific window ornaments
Configuring windows with Codable data
Using @Environment to open new windows
Using custom SwiftUI buttons to assign colors