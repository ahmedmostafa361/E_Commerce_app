#!/usr/bin/env ruby
# Adds the ZakiratiWidget WidgetKit extension to the Flutter iOS project.
# Run once from the repository root on macOS:  ruby scripts/add_widget_target.rb
# Optional: APP_GROUP_ID=group.your.id ruby scripts/add_widget_target.rb

require 'xcodeproj'
require 'fileutils'

IOS_DIR      = File.expand_path('../ios', __dir__)
PROJECT_PATH = File.join(IOS_DIR, 'Runner.xcodeproj')
WIDGET_NAME  = 'ZakiratiWidget'
WIDGET_DIR   = File.join(IOS_DIR, WIDGET_NAME)
DEPLOYMENT   = '14.0'

project = Xcodeproj::Project.open(PROJECT_PATH)
runner  = project.targets.find { |t| t.name == 'Runner' } or abort('Runner target not found')

if project.targets.any? { |t| t.name == WIDGET_NAME }
  puts "#{WIDGET_NAME} already exists. Nothing to do."
  exit 0
end

app_bundle_id = runner.build_configurations.map { |c| c.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] }.compact.first
abort('PRODUCT_BUNDLE_IDENTIFIER not found on Runner') unless app_bundle_id
app_group = ENV.fetch('APP_GROUP_ID', "group.#{app_bundle_id}")
team_id   = runner.build_configurations.map { |c| c.build_settings['DEVELOPMENT_TEAM'] }.compact.first

puts "App bundle ID : #{app_bundle_id}"
puts "Widget ID     : #{app_bundle_id}.#{WIDGET_NAME}"
puts "App Group     : #{app_group}"

# ---------------------------------------------------------------------------
# 1. Widget source files
# ---------------------------------------------------------------------------
FileUtils.mkdir_p(WIDGET_DIR)

File.write(File.join(WIDGET_DIR, "#{WIDGET_NAME}.swift"), <<~SWIFT)
  import WidgetKit
  import SwiftUI

  // App Group shared with the Flutter app through home_widget.
  private let appGroupId = "#{app_group}"

  struct ZakiratiEntry: TimelineEntry {
      let date: Date
      let title: String
      let subtitle: String
  }

  struct ZakiratiProvider: TimelineProvider {
      let titleKey: String
      let subtitleKey: String
      let fallbackTitle: String

      func placeholder(in context: Context) -> ZakiratiEntry {
          ZakiratiEntry(date: Date(), title: fallbackTitle, subtitle: "")
      }

      func getSnapshot(in context: Context, completion: @escaping (ZakiratiEntry) -> Void) {
          completion(currentEntry())
      }

      func getTimeline(in context: Context, completion: @escaping (Timeline<ZakiratiEntry>) -> Void) {
          // The Flutter app requests reloads through home_widget.
          completion(Timeline(entries: [currentEntry()], policy: .never))
      }

      private func currentEntry() -> ZakiratiEntry {
          let defaults = UserDefaults(suiteName: appGroupId)
          return ZakiratiEntry(
              date: Date(),
              title: defaults?.string(forKey: titleKey) ?? fallbackTitle,
              subtitle: defaults?.string(forKey: subtitleKey) ?? ""
          )
      }
  }

  struct ZakiratiEntryView: View {
      let entry: ZakiratiEntry

      var body: some View {
          VStack(alignment: .leading, spacing: 4) {
              Text(entry.title).font(.headline).lineLimit(2)
              if !entry.subtitle.isEmpty {
                  Text(entry.subtitle).font(.subheadline).foregroundColor(.secondary).lineLimit(2)
              }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .widgetBackground()
      }
  }

  extension View {
      @ViewBuilder
      func widgetBackground() -> some View {
          if #available(iOS 17.0, *) {
              containerBackground(.fill.tertiary, for: .widget)
          } else {
              padding().background(Color(.systemBackground))
          }
      }
  }

  struct PrayerWidget: Widget {
      let kind = "PrayerWidget"

      var body: some WidgetConfiguration {
          StaticConfiguration(
              kind: kind,
              provider: ZakiratiProvider(titleKey: "prayer_title", subtitleKey: "prayer_subtitle", fallbackTitle: "Zakirati")
          ) { entry in
              ZakiratiEntryView(entry: entry)
          }
          .configurationDisplayName("Next prayer")
          .description("Shows the upcoming prayer time.")
          .supportedFamilies([.systemSmall, .systemMedium])
      }
  }

  struct ReminderWidget: Widget {
      let kind = "ReminderWidget"

      var body: some WidgetConfiguration {
          StaticConfiguration(
              kind: kind,
              provider: ZakiratiProvider(titleKey: "reminder_title", subtitleKey: "reminder_subtitle", fallbackTitle: "Zakirati")
          ) { entry in
              ZakiratiEntryView(entry: entry)
          }
          .configurationDisplayName("Next reminder")
          .description("Shows your next reminder.")
          .supportedFamilies([.systemSmall, .systemMedium])
      }
  }

  @main
  struct ZakiratiWidgetBundle: WidgetBundle {
      var body: some Widget {
          PrayerWidget()
          ReminderWidget()
      }
  }
SWIFT

File.write(File.join(WIDGET_DIR, 'Info.plist'), <<~'PLIST')
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleDisplayName</key>
    <string>Zakirati</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>XPC!</string>
    <key>CFBundleShortVersionString</key>
    <string>$(FLUTTER_BUILD_NAME)</string>
    <key>CFBundleVersion</key>
    <string>$(FLUTTER_BUILD_NUMBER)</string>
    <key>NSExtension</key>
    <dict>
      <key>NSExtensionPointIdentifier</key>
      <string>com.apple.widgetkit-extension</string>
    </dict>
  </dict>
  </plist>
PLIST

# Gives the widget the same FLUTTER_BUILD_NAME / FLUTTER_BUILD_NUMBER as the app.
File.write(File.join(WIDGET_DIR, 'Widget.xcconfig'), "#include \"../Flutter/Generated.xcconfig\"\n")

Xcodeproj::Plist.write_to_path(
  { 'com.apple.security.application-groups' => [app_group] },
  File.join(WIDGET_DIR, "#{WIDGET_NAME}.entitlements")
)

# ---------------------------------------------------------------------------
# 2. Widget target
# ---------------------------------------------------------------------------
widget = project.new_target(:app_extension, WIDGET_NAME, :ios, DEPLOYMENT, nil, :swift)

group        = project.main_group.new_group(WIDGET_NAME, WIDGET_NAME)
swift_ref    = group.new_reference("#{WIDGET_NAME}.swift")
xcconfig_ref = group.new_reference('Widget.xcconfig')
group.new_reference('Info.plist')
group.new_reference("#{WIDGET_NAME}.entitlements")
widget.add_file_references([swift_ref])

# Make sure the widget has every configuration Flutter uses (Debug, Release, Profile).
project.build_configurations.each do |config|
  widget.add_build_configuration(config.name, config.name == 'Debug' ? :debug : :release)
end

widget.build_configurations.each do |config|
  config.base_configuration_reference = xcconfig_ref
  s = config.build_settings
  s['PRODUCT_BUNDLE_IDENTIFIER']      = "#{app_bundle_id}.#{WIDGET_NAME}"
  s['PRODUCT_NAME']                   = '$(TARGET_NAME)'
  s['INFOPLIST_FILE']                 = "#{WIDGET_NAME}/Info.plist"
  s['GENERATE_INFOPLIST_FILE']        = 'NO'
  s['CODE_SIGN_ENTITLEMENTS']         = "#{WIDGET_NAME}/#{WIDGET_NAME}.entitlements"
  s['CODE_SIGN_STYLE']                = 'Automatic'
  s['DEVELOPMENT_TEAM']               = team_id if team_id
  s['IPHONEOS_DEPLOYMENT_TARGET']     = DEPLOYMENT
  s['SWIFT_VERSION']                  = '5.0'
  s['TARGETED_DEVICE_FAMILY']         = '1,2'
  s['SKIP_INSTALL']                   = 'YES'
  s['APPLICATION_EXTENSION_API_ONLY'] = 'YES'
  s['LD_RUNPATH_SEARCH_PATHS']        = ['$(inherited)', '@executable_path/Frameworks', '@executable_path/../../Frameworks']
end

# ---------------------------------------------------------------------------
# 3. Embed the widget in Runner
# ---------------------------------------------------------------------------
embed = runner.copy_files_build_phases.find { |p| p.name == 'Embed Foundation Extensions' } ||
        runner.new_copy_files_build_phase('Embed Foundation Extensions')
embed.symbol_dst_subfolder_spec = :plug_ins
build_file = embed.add_file_reference(widget.product_reference, true)
build_file.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
runner.add_dependency(widget)

# Place the embed phase before Flutter's "Thin Binary" script to avoid "Cycle inside Runner".
phases = runner.build_phases
phases.delete(embed)
thin_index = phases.index { |p| p.respond_to?(:name) && p.name == 'Thin Binary' }
thin_index ? phases.insert(thin_index, embed) : phases << embed

# ---------------------------------------------------------------------------
# 4. App Group on Runner
# ---------------------------------------------------------------------------
runner_ent_rel = runner.build_configurations.map { |c| c.build_settings['CODE_SIGN_ENTITLEMENTS'] }.compact.first
unless runner_ent_rel
  runner_ent_rel = 'Runner/Runner.entitlements'
  runner_group = project.main_group['Runner']
  unless runner_group.files.any? { |f| f.path == 'Runner.entitlements' }
    runner_group.new_reference('Runner.entitlements')
  end
end
runner.build_configurations.each { |c| c.build_settings['CODE_SIGN_ENTITLEMENTS'] ||= runner_ent_rel }

runner_ent_path = File.join(IOS_DIR, runner_ent_rel)
entitlements = File.exist?(runner_ent_path) ? Xcodeproj::Plist.read_from_path(runner_ent_path) : {}
app_groups = Array(entitlements['com.apple.security.application-groups'])
app_groups << app_group unless app_groups.include?(app_group)
entitlements['com.apple.security.application-groups'] = app_groups
Xcodeproj::Plist.write_to_path(entitlements, runner_ent_path)

project.save
puts "Done. #{WIDGET_NAME} target added and embedded in Runner."
