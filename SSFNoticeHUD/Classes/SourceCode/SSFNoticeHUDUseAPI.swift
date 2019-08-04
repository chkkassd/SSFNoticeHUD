//
//  SSFProgressUseAPI.swift
//  SSFProgressHUD
//
//  Created by PeterShi_CooTek on 2019/7/23.
//  Copyright © 2019 PeterShi_CooTek. All rights reserved.
//Read me:
//外部调用所有接口列表
//对UIResponder进行扩展，方便在所有的view，viewcontroller等类中直接使用self点语法调用

import Foundation
import UIKit

extension UIResponder {
    
    //MARK: Convenience Methods
    ///标准模式成功Toast（图片+文案）
    public func SSFNoticeSuccess(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        let successImage = SSFGraphics.getImage(type: .checkMark)
        return SSFNoticeHUD.noticeHUD(type: .standardResult, text: text, image: successImage, autoClear: autoClear, delay: delay)
    }

    ///标准模式失败Toast（图片+文案）
    public func SSFNoticeError(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        let errorImage = SSFGraphics.getImage(type: .cross)
        return SSFNoticeHUD.noticeHUD(type: .standardResult, text: text, image: errorImage, autoClear: autoClear, delay: delay)
    }

    ///标准模式提示信息Toast（图片+文案）
    public func SSFNoticeInfo(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        let infoImage = SSFGraphics.getImage(type: .info)
        return SSFNoticeHUD.noticeHUD(type: .standardResult, text: text, image: infoImage, autoClear: autoClear, delay: delay)
    }

    ///只有文案Toast
    public func SSFNoticeForOnlyText(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .onlyTextResult, text: text, image: nil, autoClear: autoClear, delay: delay)
    }

    ///标准模式加载Toast（菊花+文案）
    public func SSFNoticeForStandardLoading(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .standardIndicator, text: text, image: nil, autoClear: autoClear, delay: delay)
    }

    ///简易模式加载Toast（菊花）
    public func SSFNoticeForOnlyLoading(autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .onlyIndicator, text: nil, image: nil, autoClear: autoClear, delay: delay)
    }
    
    ///状态栏成功Toast（文案+绿背景）
    public func SSFNoticeTopSuccess(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .TopSuccess, text: text, image: nil, autoClear: autoClear, delay: delay)
    }
    
    ///状态栏失败Toast（文案+红背景）
    public func SSFNoticeTopError(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .TopFail, text: text, image: nil, autoClear: autoClear, delay: delay)
    }
    
    //MARK: Custom Methods
    ///标准模式自定义Toast（图片+文案）
    public func SSFNoticeForStandard(customImage: UIImage, text: String, autoClear: Bool, delay: Double) ->SSFNoticeHUD {
        return SSFNoticeHUD.noticeHUD(type: .standardResult, text: text, image: customImage, autoClear: autoClear, delay: delay)
    }
    
    //MARK: Clear hud
    //if you un auto clear, you can clear all hud manualy by this methdos
    public func SSFClearAll() {
        SSFNoticeHUD.clearAll()
    }
}
