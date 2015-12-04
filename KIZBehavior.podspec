Pod::Spec.new do |s|

  s.name         = "KIZBehavior"
  s.version      = "0.0.1"
  s.summary      = "使用Storyboard 0代码集成的一些小功能"

  s.description  = <<-DESC
                   使用Storyboard 0代码集成的一些小功能。
                   DESC

  s.homepage     = "https://github.com/zziking/KIZBehavior"
  s.screenshots  = "http://7xjsf4.com1.z0.glb.clouddn.com/git_KIZBehavior_parallax_nav.gif"


  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "kingizz" => "admin@fuckipad.com" }

  s.platform     = :ios
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/zziking/KIZBehavior.git", :tag => "0.0.1" }
  s.source_files  = "KIZBehaviorDemo/Classes/**/*.{h,m}"

  s.requires_arc = true

end
