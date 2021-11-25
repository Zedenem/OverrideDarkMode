//
/*! @copyright 2021 ___ORGANIZATIONNAME___ */

import UIKit
import SwiftUI

class ViewController: UIViewController {
  var label: UILabel = {
    let label = UILabel()
    label.textColor = .orange
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()

  func updateTextLabel() {
    switch UIScreen.main.traitCollection.userInterfaceStyle {
    case .dark: label.text = "System is dark"
    case .light: label.text = "System is light"
    default: label.text = "System is unknown"
    }
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(traitCollection)
    updateTextLabel()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(dynamicProvider: { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return .black
      case .light: return .white
      default: fatalError("Uh-oh")
      }
    })

    let swiftUIViewController = UIHostingController(rootView: SwiftUIView())

    let stackView = UIStackView(arrangedSubviews: [label, makeSegmentedControl(), swiftUIViewController.view])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    updateTextLabel()
  }

  func makeSegmentedControl() -> UISegmentedControl {
    let segmentedControl = UISegmentedControl(items: ["System", "Light", "Dark"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.backgroundColor = UIColor(dynamicProvider: { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return .white
      case .light, .unspecified: return .black
      @unknown default: fatalError("Uh-oh")
      }
    })
    let normalForegroundColor = UIColor(dynamicProvider: { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return .black
      case .light, .unspecified: return .white
      @unknown default: fatalError("Uh-oh")
      }
    })
    segmentedControl.setTitleTextAttributes([.foregroundColor: normalForegroundColor],
                                            for: .normal)
    let selectedForegroundColor = UIColor(dynamicProvider: { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return .white
      case .light, .unspecified: return .black
      @unknown default: fatalError("Uh-oh")
      }
    })
    segmentedControl.setTitleTextAttributes([.foregroundColor: selectedForegroundColor],
                                            for: .selected)

    segmentedControl.selectedSegmentTintColor = UIColor(dynamicProvider: { traitCollection in
      switch traitCollection.userInterfaceStyle {
      case .dark: return .blue
      case .light, .unspecified: return .green
      @unknown default: fatalError("Uh-oh")
      }
    })

    return segmentedControl
  }

  @objc func valueChanged(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0: SceneDelegate.shared?.window?.overrideUserInterfaceStyle = .unspecified
    case 1: SceneDelegate.shared?.window?.overrideUserInterfaceStyle = .light
    case 2: SceneDelegate.shared?.window?.overrideUserInterfaceStyle = .dark
    default: break
    }
  }
}
