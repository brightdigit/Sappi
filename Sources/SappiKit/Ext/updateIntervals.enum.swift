public typealias updateInterval = String
public enum updateIntervals: updateInterval {
    case atStart = "At start"
    case separator_1 = "separator_1"
    case oncePerDay = "Once per day"
    case oncePerWeek = "Once per week"
    case oncePerMonth = "Once per month"
    case separator_2 = "separator_2"
    case never = "Never"
}

extension updateIntervals: CaseIterable {}
