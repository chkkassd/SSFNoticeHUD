//
//  SSFProgressHUD.swift
//  SSFProgressHUD
//
//  Created by PeterShi_CooTek on 2019/7/16.
//  Copyright © 2019 PeterShi_CooTek. All rights reserved.
//Read me：
//使用类簇的思想，对外提供统一的hud工厂方法，但会根据type生成不同的子类hud，将不同类型的hud实现分散入各个子类

import Foundation
import UIKit

///The content type of the HUD
/// - Enumations
///   - standardResult: show the operation result with image and info
///   - onlyTextResult: show the operation result with just text info
///   - standardIndicator: show the indicator and text during the operation
///   - onlyIndicator: just show the indicator during the operation
public enum NoticeContentType: Int {
    case standardResult
    case onlyTextResult
    case standardIndicator
    case onlyIndicator
    case TopSuccess
    case TopFail
}

///The abstract factory class . Initialize the notice hud by style
public class SSFNoticeHUD: UIWindow {
    static var allWindows = [UIWindow]()

    public var type: NoticeContentType {
        get {
            return NoticeContentType.standardResult
        }
    }
    
    public static func noticeHUD(type: NoticeContentType, text: String?, image: UIImage?, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        var hud: SSFNoticeHUD
        switch type {
        case .standardResult:
            hud = SSFStandardResultHUD(frame: CGRect(x: 0, y: 0, width: 160, height: 100), text: text, image: image)
        case .onlyTextResult:
            hud = SSFOnlyTextResultHUD(frame: CGRect(x: 0, y: 0, width: 200, height: 60), text: text)
        case .standardIndicator:
            hud = SSFStandardIndicatorHUD(frame: CGRect(x: 0, y: 0, width: 160, height: 110), text: text)
        case .onlyIndicator:
            hud = SSFOnlyIndicatorHUD(frame: CGRect(x: 0, y: 0, width: 160, height: 80))
        case .TopSuccess:
            hud = SSFTopHUD(frame: UIApplication.shared.statusBarFrame, topType: .TopSuccess, text: text)
        case .TopFail:
            hud = SSFTopHUD(frame: UIApplication.shared.statusBarFrame, topType: .TopFail, text: text)
        }
        //set hud
        if type == .TopSuccess || type == .TopFail {
            hud.windowLevel = .statusBar
        } else {
            let bounds = UIScreen.main.bounds
            hud.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            hud.windowLevel = .alert
        }
        hud.isHidden = false
        self.allWindows.append(hud)
        hud.appearAnimated {
            if autoClear {
                self.perform(#selector(SSFNoticeHUD.clearAllAnimated(hud:)), with: hud, afterDelay: delay)
            }
        }
        return hud
    }
    
    static public func clearAll() {
        self.cancelPreviousPerformRequests(withTarget: self)
        SSFNoticeHUD.allWindows.removeAll(keepingCapacity: false)
    }
    
    @objc static public func clearAllAnimated(hud: SSFNoticeHUD) {
        hud.disappearAnimated {
            self.clearAll()
        }
    }
    
    func appearAnimated(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func disappearAnimated(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

// MARK: SSFStandardResultHUD
///The standard result hud, show image and info
class SSFStandardResultHUD: SSFNoticeHUD {
    override var type: NoticeContentType {
        get {
            return .standardResult
        }
    }
    
    init(frame: CGRect, text: String?, image: UIImage?) {
        super.init(frame: frame)
        infoLabel.text = text
        alertImageView.image = image
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)
        self.addSubview(alertImageView)
        self.addSubview(infoLabel)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let margins = self.layoutMarginsGuide
        //layout backgroundView
        backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        //layout image
        alertImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        alertImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15).isActive = true
        alertImageView.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
        alertImageView.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        //layout info label
        infoLabel.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 8).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8).isActive = true
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 100))
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

// MARK: SSFOnlyTextResultHUD
///The onlyTextResult hud, just show text
class SSFOnlyTextResultHUD: SSFNoticeHUD {
    override var type: NoticeContentType {
        get {
            return .onlyTextResult
        }
    }
    
    init(frame: CGRect, text: String?) {
        super.init(frame: frame)
        infoLabel.text = text
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)
        self.addSubview(infoLabel)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let margins = self.layoutMarginsGuide
        //layout backgroundView
        backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        //layout info label
        infoLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8).isActive = true
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 100))
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
}

// MARK: SSFStandardIndicatorHUD
///The standardIndicator hud, show indicator and info
class SSFStandardIndicatorHUD: SSFNoticeHUD {
    override var type: NoticeContentType {
        get {
            return .standardIndicator
        }
    }
    
    init(frame: CGRect, text: String?) {
        super.init(frame: frame)
        infoLabel.text = text
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)
        self.addSubview(indicator)
        self.addSubview(infoLabel)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let margins = self.layoutMarginsGuide
        //layout backgroundView
        backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        //layout indicator
        indicator.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15.0).isActive = true
        //layout info label
        infoLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 8).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8).isActive = true
        
        indicator.startAnimating()
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 100))
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

// MARK: SSFOnlyIndicatorHUD
///The onlyIndicator hud, just show indicator
class SSFOnlyIndicatorHUD: SSFNoticeHUD {
    override var type: NoticeContentType {
        get {
            return .onlyIndicator
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.addSubview(backgroundView)
        self.addSubview(indicator)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let margins = self.layoutMarginsGuide
        //layout backgroundView
        backgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        //layout indicator
        indicator.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        
        indicator.startAnimating()
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 100))
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

// MARK: SSFTopHUD
///The Top hud, just show text, if success,backgroundView is green; if fail, backgroundView is red.
class SSFTopHUD: SSFNoticeHUD {
    override var type: NoticeContentType {
        get {
            return topType
        }
    }
    
    private var topType: NoticeContentType
    
    init(frame: CGRect, topType: NoticeContentType, text: String?) {
        self.topType = topType
        super.init(frame: frame)
        self.infoLabel.text = text
        configureView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(frame: CGRect) {
        self.backgroundColor = UIColor.clear
        if topType == .TopSuccess {
            backgroundView.backgroundColor = UIColor(red: 0x6a/0x100, green: 0xb4/0x100, blue: 0x9f/0x100, alpha: 1)
        } else if topType == .TopFail {
            backgroundView.backgroundColor = UIColor(red: 255/255.0, green: 115/255.0, blue: 130/255.0, alpha: 1)
        }
        self.addSubview(backgroundView)
        self.addSubview(infoLabel)
        backgroundView.frame = frame
        if frame.height > 20 {
            //iPhoneX以上机型
            infoLabel.frame = CGRect(x: frame.origin.x, y: frame.origin.y + 27.0, width: frame.width, height: frame.height - 27.0)
        } else {
           infoLabel.frame = frame
        }
    }
    
    override func appearAnimated(completionHandler: @escaping () -> Void) {
        let endFrame = UIApplication.shared.statusBarFrame
        let beginFrame = endFrame.offsetBy(dx: 0, dy: -endFrame.height)
        self.frame = beginFrame
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = endFrame
        }) { (finish) in
            if finish {
                completionHandler()
            }
        }
    }
    
    override func disappearAnimated(completionHandler: @escaping () -> Void) {
        let endFrame = self.frame.offsetBy(dx: 0, dy: -UIApplication.shared.statusBarFrame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = endFrame
            }) { (finish) in
                if finish {
                    completionHandler()
                }
        }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        view.backgroundColor = UIColor(red: 0x6a/0x100, green: 0xb4/0x100, blue: 0x9f/0x100, alpha: 1)
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        label.textAlignment = .center
        return label
    }()
}
