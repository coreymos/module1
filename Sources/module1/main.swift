import Foundation

class Event {
    
    // id uses the built in function UUID to create a unique universal id
    // for each object of class. This way, unique events with the same name
    // can be told apart from each other.
    let id = UUID().uuidString

    // All of the properties of the class are given here with their respective type.
    let name: String
    let date: Date
    let dateString: String
    let daysUntil: Int
    
    // Properties are initialized.
    init(name: String, date: Date, daysUntil: Int) {
        self.name = name
        self.daysUntil = daysUntil
        self.date = date
        self.dateString = dateToString(self.date)
    }
}

struct EventTracker {
    // All events are stored within this collection
    var futureEvents: [Event] = []

    // This holds an integer count of how many events are in the collection.
    var eventCount: Int {
        get { futureEvents.count }
    }

    // A function to add events to the tracker.
    mutating func addEvent(_ event: Event) -> Bool {
        for x in 0..<eventCount {
            if event.id == futureEvents[x].id {
                return false
            }
        }
        futureEvents.append(event)
        return true
    }

    // A function to determine how many of each event there are that have the same name.
    func count(of name: String) -> Int {
        var count = 0
        for x in 0..<eventCount {
            if name == futureEvents[x].name {
                count += 1
            }
        }
        return count
    }
}

// Converts days to seconds.
func daysToSeconds(_ numDays: Int) -> Double {
    let msPerDay: Double = 60 * 60 * 24
    return Double(numDays) * msPerDay
}

// Provides a date type variable with the given amount of daysFromNow.
func futureDate(daysFromNow: Int) -> Date {
    Date(timeIntervalSinceNow: daysToSeconds(daysFromNow))
}

// Converts the Date type variable into a readable String.
func dateToString(_ aDate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: aDate)
}


let event1 = Event(name: "pizzaParty", date: futureDate(daysFromNow: 5), daysUntil: 5)
//print("Name:", event1.name, "Date:", event1.date, "Days until:", event1.daysUntil, "Date String:", event1.dateString, "ID:", event1.id)

var tracker: EventTracker = EventTracker()
tracker.addEvent(event1)

//print(tracker.eventCount)

var running = true

while running {
    print("Type one of the following numbers to access their command.")
    print("""
    1. Add an Event
    2. Show Total Event Count
    3. Display Soonest Event
    4. Exit Program
    """)
    var input = readLine()

    if input == "1" {
        print("Name: ")

        // If statements are used to unwrap the optional readLine variable into their respective
        // types which are String and Int for this particular part of the code.
        if var name:String = readLine() {
            print("Days from Now: ")
            if let typed = readLine() {
            if let num = Int(typed) {

                // Adds a new event object to the tracker with the given values
                tracker.addEvent(Event(name: name, date: futureDate(daysFromNow: num), daysUntil: num))
                }     
            }
        }
    }
    else if input == "2" {

        // Displays the event count from the EventTracker class.
        print("Event Count:", tracker.eventCount)
    }
    else if input == "3" {

        // Checks all of the events and calculates which one is the closest in days.
        var soonest = 10000
        for event in tracker.futureEvents {
            if event.daysUntil < soonest {
                soonest = event.daysUntil
            }
        }
        print("Days until soonest:", soonest)
    }
    else if input == "4" {

        // Exits the program
        running = false
    }
}


