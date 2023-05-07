//
//  xibGenFileViper.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 12.02.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: Gen Swift Viper
    
    
    
    // MARK: - Configurator
    
    func xibGenFileViper_Configurator() -> String {
        
        let name_ = name.xibFilterName(type: .viper)
        
        return """
        //
        //  \(name_)Controller.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import UIKit
        
        struct \(name_)Configurator: Configurator {
          typealias View = \(name_)Controller
            
          static func configure() -> View {
            let vc = \(name_)Controller.instantiate() as! \(name_)Controller
            let presenter = \(name_)Presenter(with: vc)
            let interactor = \(name_)Interactor()
            interactor.delegate = presenter
            // let service = \(name_)Service()
            // service.apiClient = ApiClient(session: .shared)
            // interactor.service = service
            interactor.analyticService = AnalyticService()
            interactor.featureService = FeaturesService()
            interactor.userDefaultsService = UserDefaultsService.shared
            presenter.interactor  = interactor
            presenter.router = \(name_)Router(with: vc)
            presenter.didStart()
            vc.presenter  = presenter
            return  vc
          }
        }
        """
    }
    
    // MARK: - Controller
    
    func xibGenFileViper_Controller() -> String {
        
        let name_ = name.xibFilterName(type: .viper)
        
        let lowerName = name_.firstLowercase()
      
        return """
        //
        //  \(name_)Controller.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import UIKit
        
        protocol \(name_)ViewProtocol: Initialization {
          var navigationBarState: UINavigationController.State? { get set }
          var \(lowerName)State: \(name_)View.State? { get set }
          var \(lowerName)Handlers: \(name_)View.Handlers? { get set }
        }
        
        final class \(name_)Controller: StoryboardController {
          
          @IBOutlet weak var \(lowerName)View: \(name_)View!
          
          var \(lowerName)State: \(name_)View.State? {
            set { \(lowerName)View.state = newValue }
            get { \(lowerName)View.state }
          }

          var \(lowerName)Handlers: \(name_)View.Handlers? {
            set { \(lowerName)View.handlers = newValue ?? .init() }
            get { \(lowerName)View.handlers }
          }
          
          /// Presenter
          var presenter: \(name_)PresenterProtocol!
            
          override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
          }
        }

        // MARK: - Initialization impl
        extension \(name_)Controller: Initialization {
          
          func setup() {
            view.applying{
              $0.backgroundColor = .newBackground
            }
          }
            
          func align() {}
        }

        // MARK: - View Protocol
        extension \(name_)Controller: \(name_)ViewProtocol {}
        """
    }
    
    
    // MARK: - Presenter
    
    func xibGenFileViper_Presenter() -> String {
        
      
        let name_ = name.xibFilterName(type: .viper)
        
        let lowerName = name_.firstLowercase()
      
        return """
        //
        //  \(name_)Presenter.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import UIKit
        
        protocol \(name_)PresenterProtocol: PresenterProtocol {
          func didStart()
        }
        
        final class \(name_)Presenter {
            
          /// View
          private weak var view: \(name_)ViewProtocol!
          /// Interactor
          var interactor: \(name_)InteractorIn!
          /// Router
          var router: \(name_)RouterProtocol?
          var routerHandler: RouterProtocol? { router }
          
          //MARK: - Implementation
          required init(with view: \(name_)ViewProtocol) {
            self.view = view
          }
        }
        
        extension \(name_)Presenter: \(name_)PresenterProtocol {
          
          func didStart() {

            configureView()

            view.navigationBarState =
            .init(
              appearance: .init(
                navigationBarTransluent: true
              ),
              new: .init(
                title: "\(name_)"
              )
            )
            
            updateItems()
            
            view.\(lowerName)Handlers = .init(
              onItemAt: { [weak self] index in
                if index == 0 {
                }
              }
            )
          }
        
          func updateItems() {
        
            var tableItems: [TableAdapterItem] = []
            
            for i in 0..<15 {
              let item = TitleTextItem(title: "TEST \\(i)", subtitle: "subtitle subtitle")
              tableItems.append(item)
            }
        
            view.\(lowerName)State = .init(
              tableItems: tableItems
            )
          }
          
          private func configureView() {
            view.setup()
            view.align()
          }
        }

        extension \(name_)Presenter: \(name_)InteractorOut {}
        """
    }
    
    
    // MARK: - Interactor
    
    func xibGenFileViper_Interactor() -> String {
        
        let name_ = name.xibFilterName(type: .viper)
        
        return """
        //
        //  \(name_)Interactor.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import Foundation

        protocol \(name_)InteractorIn: InteractorIn {}

        protocol \(name_)InteractorOut: InteractorOut {}

        final class \(name_)Interactor: Interactor {
          
          /// Sign in interactor delegate (Sign in Presenter)
          weak var delegate: \(name_)InteractorOut?
          
          /// Authentication service
          var service: ApiService!
        }

        extension \(name_)Interactor: \(name_)InteractorIn {}
        """
    }
    
    
    // MARK: - Router
    
    func xibGenFileViper_Router() -> String {
        
        let name_ = name.xibFilterName(type: .viper)
        
        return """
        //
        //  \(name_)Router.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import Foundation
        
        protocol \(name_)RouterProtocol: RouterProtocol {
          func pushTo\(name_)()
        }
        
        final class \(name_)Router: Router {
          func pushTo\(name_)() {
            pushTo(\(name_)Configurator.configure())
          }
        }
        
        extension \(name_)Router: \(name_)RouterProtocol {}
        """
    }
    
  // MARK: - Service
  
  func xibGenFileViper_Service() -> String {
    
    let name_ = name.xibFilterName(type: .viper)
    
        return """
        //
        //  \(name_)Service.swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import Foundation
        
        protocol \(name_)ServiceProtocol {
        }
        
        class \(name_)Service: ApiService, \(name_)ServiceProtocol {
        }
        """
  }
    
    // MARK: - Localization
    
    func xibGenFileViper_Localization() -> String {
        
        let name_ = name.xibFilterName(type: .viper)
        let xmlName = name.xmlFilter()
      
        return """
        //
        //  \(name_).swift
        //  PlusBank
        //
        //  Created by mrustaa
        //
        
        import Foundation
        
        public enum \(name_) {
          /// Оформление заявки
          public static var enterTitle: String {
            return "\(xmlName)title".localize
          }
        }
        """
    }
  
  
  // MARK: - Storyboard
  
  func xibGenFileViper_Story() -> String {
    
    let name_ = name.xibFilterName(type: .viper)
    //let xmlName = name.xmlFilter()
    
    let lowerName = name_.firstLowercase()
    
    let vcID = xibId
    
    let sceneID = xibID()
    let vcContentID = xibID()
    
    let secondItem = xibID()
    let viewID = xibID()
    
    return """
    <?xml version="1.0" encoding="UTF-8"?>
    <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="17701" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
        <device id="retina4_7" orientation="portrait" appearance="light"/>
        <dependencies>
            <deployment identifier="iOS"/>
            <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="17703"/>
            <capability name="Safe area layout guides" minToolsVersion="9.0"/>
            <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
        </dependencies>
        <scenes>
            <!--\(name_)-->
            <scene sceneID="\(sceneID)">
                <objects>
                    <viewController storyboardIdentifier="\(name_)Controller" useStoryboardIdentifierAsRestorationIdentifier="YES" id="\(vcID)" customClass="\(name_)Controller" customModule="PlusBank" customModuleProvider="target" sceneMemberID="viewController">
                        <view key="view" contentMode="scaleToFill" id="\(vcContentID)">
                            <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                            <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                            <subviews>
                                <view clipsSubviews="YES" contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="\(viewID)" userLabel="View" customClass="\(name_)View" customModule="PlusBank" customModuleProvider="target">
                                    <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                                    <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
                                </view>
                            </subviews>
                            <viewLayoutGuide key="safeArea" id="\(secondItem)"/>
                            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
                            <constraints>
                                <constraint firstItem="\(viewID)" firstAttribute="top" secondItem="\(secondItem)" secondAttribute="top" id="\(xibID())"/>
                                <constraint firstItem="\(viewID)" firstAttribute="bottom" secondItem="\(secondItem)" secondAttribute="bottom" id="\(xibID())"/>
                                <constraint firstItem="\(viewID)" firstAttribute="leading" secondItem="\(secondItem)" secondAttribute="leading" id="\(xibID())"/>
                                <constraint firstItem="\(viewID)" firstAttribute="trailing" secondItem="\(secondItem)" secondAttribute="trailing" id="\(xibID())"/>
                            </constraints>
                        </view>
                        <connections>
                            <outlet property="\(lowerName)View" destination="\(viewID)" id="\(xibID())"/>
                        </connections>
                    </viewController>
                    <placeholder placeholderIdentifier="IBFirstResponder" id="\(xibID())" userLabel="First Responder" customClass="UIResponder" sceneMemberID="firstResponder"/>
                </objects>
                <point key="canvasLocation" x="130.40000000000001" y="80.50974512743629"/>
            </scene>
        </scenes>
    </document>
    """
  }

}
