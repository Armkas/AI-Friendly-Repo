# Features/Map  (skeleton)

`Interface/MapController.swift` is the imperative surface (camera, follow-user,
route rendering) with its contract. `Presentation/` has a minimal SwiftUI
`MapScreen` + `MapScreenModel` that renders the user location and the active
route polyline.

Map renders state owned by Navigation; it computes nothing. If `NavigationService`
has no route, the screen shows the plain map + user location only.

See [`../../AI/domains/map.md`](../../AI/domains/map.md).
