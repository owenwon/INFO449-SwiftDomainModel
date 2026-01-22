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

    func add ( other: Money) -> Money {
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
        case Salary(UInt)
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}
