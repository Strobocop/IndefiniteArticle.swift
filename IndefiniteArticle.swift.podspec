#
# Be sure to run `pod lib lint IndefiniteArticle.swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IndefiniteArticle.swift'
  s.version          = '0.1.0'
  s.summary          = 'A String extension for providing indefinite articles'

  s.description      = <<-DESC
                        A String extension for providing indefinite articles (a|an)
                        for a given string.
                        For example:
                        *  `String.indefiniteArticle(for: "elipis") => @"an"`
                        *  `String.indefiniteArticle(for: "taco") => @"a"`
                        or you can call it on a given string:
                        * `"historic event".indefiniteArticle() => @"a"`
                        * `"800 lb gorilla".indefiniteArticle() => @"an"`
                       DESC

  s.homepage         = 'https://github.com/raymondhytang/IndefiniteArticle.swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Raymond Tang' => 'raymondhytang@gmail.com' }
  s.source           = { :git => 'https://github.com/raymondhytang/IndefiniteArticle.swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/raymondhytang'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.{swift}'

end
