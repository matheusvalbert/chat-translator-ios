source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'
use_frameworks!
workspace 'chattranslator'

def di
  pod 'Swinject'
end

def net
  pod 'Alamofire'
end

def fb
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseMessaging'
  pod 'GoogleSignIn'
end

target 'ChatTranslator' do
  project 'ChatTranslator/ChatTranslator'
  di
  fb
  net
end

target 'DataComponents' do
  project 'DataComponents/DataComponents'
  di
  fb
  net
  target 'DataComponentsTests' do
  end
end

target 'UIComponents' do
  project 'UIComponents/UIComponents'
  target 'UIComponentsTests' do
  end
end

target 'Login' do
  project 'Login/Login'
  di
  target 'LoginTests' do
  end
end

target 'Profile' do
  project 'Profile/Profile'
  di
  target 'ProfileTests' do
  end
end

target 'Friend' do
  project 'Friend/Friend'
  di
  target 'FriendTests' do
  end
end

target 'Chats' do
  project 'Chats/Chats' 
  di
  target 'ChatsTests' do
  end
end
