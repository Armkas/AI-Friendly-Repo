import Foundation
import MapKit
import Observation

/// Screen state for `MapScreen`. Observes the active route from `NavigationService`
/// (via a closure supplied by App) and the location stream. Holds no routing or
/// speech logic.
@MainActor
@Observable
public final class MapScreenModel {

    public var cameraPosition: MapCameraPosition = .automatic
    public private(set) var route: Route?

    private let routes: AsyncStream<Route?>
    private var observation: Task<Void, Never>?

    public init(routes: AsyncStream<Route?>) {
        self.routes = routes
    }

    public func onAppear() {
        guard observation == nil else { return }
        observation = Task { [weak self] in
            for await route in self?.routes ?? AsyncStream { $0.finish() } {
                self?.route = route
            }
        }
    }
}
