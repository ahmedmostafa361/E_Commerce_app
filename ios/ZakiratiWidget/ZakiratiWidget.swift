import WidgetKit
import SwiftUI

// App Group shared with the Flutter app through home_widget.
private let appGroupId = "group.com.example.eCommerceFlutterApp"

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
