Pod::Spec.new do |spec|
  spec.name         = "StoreKit2Manager"
  spec.version      = "1.1.1"
  spec.summary      = "一个简洁、易用的 StoreKit2 封装库，提供统一的接口来管理应用内购买"
  spec.description  = <<-DESC
  StoreKit2Manager 是一个基于 StoreKit 2 的封装库，提供了简洁易用的 API 来管理应用内购买。
  
  主要特性：
  - 配置驱动，易于集成
  - 支持协议回调和闭包回调两种方式
  - 自动监听交易状态变化
  - 完整的错误处理
  - 支持所有产品类型（消耗品、非消耗品、订阅等）
  - 线程安全，所有回调在主线程
  - 订阅产品国际化支持（标题、副标题、按钮文案）
  - 优惠代码兑换支持
  - 家庭共享检测
  DESC

  spec.homepage     = "https://github.com/ppswdev/StoreKit2Manager"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "ppswdev" => "xiaopin166@gmail.com" }
  spec.platforms = { :ios => "15.0" }
  
  spec.swift_version = "5.9"
  spec.source       = { :git => "https://github.com/ppswdev/StoreKit2Manager.git", :tag => "#{spec.version}" }
  
  spec.source_files = [
    "StoreKit2/StoreKit2Manager/StoreKitManager.swift",
    "StoreKit2/StoreKit2Manager/Models/**/*.swift",
    "StoreKit2/StoreKit2Manager/Protocols/**/*.swift",
    "StoreKit2/StoreKit2Manager/Internal/**/*.swift",
    "StoreKit2/StoreKit2Manager/Locals/**/*.swift",
    "StoreKit2/StoreKit2Manager/Converts/**/*.swift"
  ]
  
  spec.exclude_files = [
    "StoreKit2/StoreKit2Manager/Docs/**/*",
    
  ]
  
  spec.frameworks = "Foundation", "StoreKit", "Combine"
  
  spec.ios.frameworks = "UIKit"
  spec.osx.frameworks = "AppKit"
  
  spec.requires_arc = true
  
  spec.module_name = "StoreKit2Manager"
end
