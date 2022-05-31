import SwiftUI

class SwiftyOnAppearViewController: UIViewController {
    var delegate: SwiftyOnAppearViewDelegate? = nil

    override func viewDidLoad() {
        delegate?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        delegate?.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        delegate?.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        delegate?.viewDidLayoutSubviews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        delegate?.viewDidDisappear(animated)
    }

    override func viewWillLayoutSubviews() {
        delegate?.viewWillLayoutSubviews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        delegate?.viewWillDisappear(animated)
    }
}

protocol SwiftyOnAppearViewDelegate {
    func viewDidLoad()
    func viewDidAppear(_ animated: Bool)
    func viewWillAppear(_ animated: Bool)
    func viewDidLayoutSubviews()
    func viewDidDisappear(_ animated: Bool)
    func viewWillLayoutSubviews()
    func viewWillDisappear(_ animated: Bool)
}

struct SwiftyOnAppearView: UIViewControllerRepresentable {
    let viewDidLoad: (() -> ())?
    let viewDidAppear: ((_ animated: Bool) -> ())?
    let viewWillAppear: ((_ animated: Bool) -> ())?
    let viewDidLayoutSubviews: (() -> ())?
    let viewDidDisappear: ((_ animated: Bool) -> ())?
    let viewWillLayoutSubviews: (() -> ())?
    let viewWillDisappear: ((_ animated: Bool) -> ())?

    class Coordinator: NSObject, SwiftyOnAppearViewDelegate {
        var parent: SwiftyOnAppearView

        init(_ parent: SwiftyOnAppearView) {
            self.parent = parent
        }

        func viewDidLoad() {
            parent.viewDidLoad?()
        }

        func viewDidAppear(_ animated: Bool) {
            parent.viewDidAppear?(animated)
        }

        func viewWillAppear(_ animated: Bool) {
            parent.viewWillAppear?(animated)
        }

        func viewDidLayoutSubviews() {
            parent.viewDidLayoutSubviews?()
        }

        func viewDidDisappear(_ animated: Bool) {
            parent.viewDidDisappear?(animated)
        }

        func viewWillLayoutSubviews() {
            parent.viewWillLayoutSubviews?()
        }

        func viewWillDisappear(_ animated: Bool) {
            parent.viewWillDisappear?(animated)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> SwiftyOnAppearViewController {
        let controller = SwiftyOnAppearViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ nsViewController: SwiftyOnAppearViewController, context: Context) {

    }
}

struct SwiftyModifier: ViewModifier {
    let viewDidLoad: (() -> ())?
    let viewDidAppear: ((_ animated: Bool) -> ())?
    let viewWillAppear: ((_ animated: Bool) -> ())?
    let viewDidLayoutSubviews: (() -> ())?
    let viewDidDisappear: ((_ animated: Bool) -> ())?
    let viewWillLayoutSubviews: (() -> ())?
    let viewWillDisappear: ((_ animated: Bool) -> ())?

    func body(content: Content) -> some View {
        content
            .background(SwiftyOnAppearView(viewDidLoad: viewDidLoad, viewDidAppear: viewDidAppear, viewWillAppear: viewWillAppear, viewDidLayoutSubviews: viewDidLayoutSubviews, viewDidDisappear: viewDidDisappear, viewWillLayoutSubviews: viewWillLayoutSubviews, viewWillDisappear: viewWillDisappear))
    }
}

public extension View {
    func viewDidLoad(_ perform: @escaping () -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: perform, viewDidAppear: nil, viewWillAppear: nil, viewDidLayoutSubviews: nil, viewDidDisappear: nil, viewWillLayoutSubviews: nil, viewWillDisappear: nil))
    }

    func viewDidAppear(_ perform: @escaping (_ animated: Bool) -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: perform, viewWillAppear: nil, viewDidLayoutSubviews: nil, viewDidDisappear: nil, viewWillLayoutSubviews: nil, viewWillDisappear: nil))
    }

    func viewWillAppear(_ perform: @escaping (_ animated: Bool) -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: nil, viewWillAppear: perform, viewDidLayoutSubviews: nil, viewDidDisappear: nil, viewWillLayoutSubviews: nil, viewWillDisappear: nil))
    }

    func viewDidLayoutSubviews(_ perform: @escaping () -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: nil, viewWillAppear: nil, viewDidLayoutSubviews: perform, viewDidDisappear: nil, viewWillLayoutSubviews: nil, viewWillDisappear: nil))
    }

    func viewDidDisappear(_ perform: @escaping (_ animated: Bool) -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: nil, viewWillAppear: nil, viewDidLayoutSubviews: nil, viewDidDisappear: perform, viewWillLayoutSubviews: nil, viewWillDisappear: nil))
    }

    func viewWillLayoutSubviews(_ perform: @escaping () -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: nil, viewWillAppear: nil, viewDidLayoutSubviews: nil, viewDidDisappear: nil, viewWillLayoutSubviews: perform, viewWillDisappear: nil))
    }

    func viewWillDisappear(_ perform: @escaping (_ animated: Bool) -> ()) -> some View {
        self
            .modifier(SwiftyModifier(viewDidLoad: nil, viewDidAppear: nil, viewWillAppear: nil, viewDidLayoutSubviews: nil, viewDidDisappear: nil, viewWillLayoutSubviews: nil, viewWillDisappear: perform))
    }
}
