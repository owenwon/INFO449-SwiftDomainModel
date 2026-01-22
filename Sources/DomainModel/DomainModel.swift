struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String

    func convert (_ currencyName: String) -> Money {
        var tempAmount = Double(self.amount)

        // convert the current amount to USD
        switch currency {
        case "USD":
            break
        case "GBP":
            tempAmount = Double(self.amount) / 0.5
        case "EUR":
            tempAmount = Double(self.amount) / 1.5
        case "CAN":
            tempAmount = Double(self.amount) / 1.25
        default:
            print("Currency not available")
        }

        // convert the current amount from USD to currencyName
        switch currencyName {
        case "USD":
            break
        case "GBP":
            tempAmount = tempAmount * 0.5
        case "EUR":
            tempAmount = tempAmount * 1.5
        case "CAN":
            tempAmount = tempAmount * 1.25
        default:
            print("Currency not available")
        }

        let finalAmount = Int(tempAmount)
        return Money(amount: finalAmount, currency: currencyName)
    }

    func add (_ other: Money) -> Money {
        let convertedSelf = self.convert(other.currency)
        let newAmount = convertedSelf.amount + other.amount
        return Money(amount: newAmount, currency: convertedSelf.currency)
    }

    func subtract (_ other: Money) -> Money {
        let convertedSelf = self.convert(other.currency)
        let newAmount = convertedSelf.amount - other.amount
        return Money(amount: newAmount, currency: convertedSelf.currency)
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    var title: String
    var type: JobType
    
    init (title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let wage):
            return Int(wage * Double(hours))
        case .Salary(let salary):
            return salary
        }
    }
    
    func raise(byAmount amount: Double) {
        switch self.type {
        case .Hourly(let wage):
            let newWage = wage + amount
            self.type = .Hourly(newWage)
        case .Salary(let salary):
            let newSalary = Double(salary) + amount
            self.type = .Salary(Int(newSalary))
        }
    }
    
    func raise(byPercent percent: Double) {
        switch self.type {
        case .Hourly(let wage):
            let newWage = wage * (1 + percent)
            self.type = .Hourly(newWage)
        case .Salary(let salary):
            let newSalary = Double(salary) * (1 + percent)
            self.type = .Salary(Int(newSalary))
        }
    }
    
    
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    
    var job: Job? {
        didSet {
            if age < 16 {
                job = nil
            }
        }
    }
    var spouse: Person? {
        didSet {
            if age < 18 {
                spouse = nil
            }
        }
    }
    
    init (firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title ?? "nil") spouse:\(spouse?.firstName ?? "nil")]"
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
    
    init (spouse1: Person, spouse2: Person) {
        spouse1.spouse = nil
        spouse2.spouse = nil
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members = [spouse1, spouse2]
    }
    
    func haveChild (_ child: Person) -> Bool {
        let spouse1 = members[0]
        let spouse2 = members[1]
        if spouse1.age >= 21 || spouse2.age >= 21 {
            members.append(child)
            return true
        } else {
            return false
        }
    }
    
    func householdIncome () -> Int {
        var totalIncome = 0
        for member in members {
            if let job = member.job {
                totalIncome += job.calculateIncome(2000)
            }
        }
        return totalIncome
    }
}
