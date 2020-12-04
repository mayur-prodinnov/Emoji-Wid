//
//  emojibook_widget.swift
//  emojibook widget
//
//  Created by Red Phoenix on 04/12/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emojiDetails: EmojiProvider.random())
            entries.append(entry)
        }

        let timeline = Timeline(entries:
                                    entries, policy: .atEnd)
        completion(timeline)
    }
}

struct PlaceholderView : View {
  var body: some View {
    Text("Placeholder View")
  }
}
struct SimpleEntry: TimelineEntry {
    let date: Date
    public let emojiDetails: EmojiDetails
}

struct emojibook_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        EmojiWidgetView(emojiDetails: entry.emojiDetails)
      }
}

@main
struct emojibook_widget: Widget {
    let kind: String = "emojibook_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            emojibook_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Emoji")
            .description("Display a widget with an emoji that is updated randomly.")
            .supportedFamilies([.systemSmall])
    }
}

struct emojibook_widget_Previews: PreviewProvider {
    static var previews: some View {
        emojibook_widgetEntryView(entry: SimpleEntry(date: Date(), emojiDetails: EmojiProvider.random()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
