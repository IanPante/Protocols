import UIKit
import Foundation

class Human: CustomStringConvertible, Equatable, Comparable, Codable {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    var description: String {
        return "My name is \(name), \(age) years old"
    }
    
    static func == (lhs: Human, rhs: Human) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
}

let ian = Human(name: "Ian", age: 24)
let fay = Human(name: "Fay", age: 23)

print(ian)
print(fay)

if ian != fay {
    print("Not the same person")
}

let humans = [ian, fay]

let sortedByAge = humans.sorted(by: <)

for human in sortedByAge {
    print(human)
}

let jsonEncoder = JSONEncoder()
if let jsonData = try? jsonEncoder.encode(ian),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}


class Workout: CustomStringConvertible, Equatable, Comparable, Codable {
    var distance: Double
    var time: Double
    var identifier: Int
    
    init(distance: Double, time: Double, identifier: Int) {
        self.distance = distance
        self.time = time
        self.identifier = identifier
    }
    
    var description: String {
        return "Completed \(distance)km workout in \(time) minutes."
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    static func < (lhs:Workout, rhs: Workout) -> Bool {
        return lhs.time < rhs.time
    }
    
}

let runOne = Workout(distance: 1, time: 5, identifier: 1)
let runTwo = Workout(distance: 3, time: 11, identifier: 2)
let runThree = Workout(distance: 5, time: 20, identifier: 3)
let runFour = Workout(distance: 10, time: 45, identifier: 4)
let runFive = Workout(distance: 15, time: 75, identifier: 5)

print(runOne)

if runOne != runTwo {
    print("Different workouts")
}

let workouts = [runFour, runTwo, runThree, runOne, runFive]
let sortedWorkout = workouts.sorted(by: >)

for workout in sortedWorkout {
    print(workout)
}

if let jsonData = try? jsonEncoder.encode(runFive),
   let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}

protocol Vehicle {
    var numberOfWheels: Int { get }
    
    func drive()
}

struct Car: Vehicle {
    let numberOfWheels: Int = 4
    
    func drive() {
        print ("Vroom vroom")
    }
    
}

let sedan = Car()
sedan.drive()

struct Bike: Vehicle {
    let numberOfWheels: Int = 2
    func drive() {
        print ("Begin pedaling!")
    }
}

let mtb = Bike()
mtb.drive()

protocol TypeWorkout {
    var distance: Double { get set }
    var time: Double { get set }

}

struct RunningWorkout: TypeWorkout {
    var distance: Double
    var time: Double
    
    func simpleWorkoutDescription(workout: TypeWorkout) {
        print("You went \(workout.distance) meters in \(workout.time) seconds.")
    }
}

struct SwimmingWorkout: TypeWorkout {
    var distance: Double
    var time: Double
    
    func simpleWorkoutDescription(workout: TypeWorkout) {
        print("You went \(workout.distance) meters in \(workout.time) seconds.")
    }
}

let jog = RunningWorkout(distance: 3000, time: 1200)
jog.simpleWorkoutDescription(workout: jog)

let freestyle = RunningWorkout(distance: 150, time: 180)
freestyle.simpleWorkoutDescription(workout: freestyle)

protocol HeartRateReceiverDelegate {
    func heartRateUpdated(to bpm: Int)
    
}

class HeartRateReceiver {
    var delegate: HeartRateReceiverDelegate?
    
    var currentHR: Int? {
        didSet {
            if let currentHR = currentHR {
                delegate?.heartRateUpdated(to: currentHR)
                print("The most recent heart rate reading is \(currentHR).")
            } else {
                print("Looks like we can't pick up a heart rate.")
            }
        }
    }

    func startHeartRateMonitoringExample() {
        for _ in 1...10 {
            let randomHR = 60 + Int(arc4random_uniform(UInt32(15)))
            currentHR = randomHR
            Thread.sleep(forTimeInterval: 2)
        }
    }
    
}

class HeartRateViewController: UIViewController, HeartRateReceiverDelegate {
    var heartRateLabel: UILabel = UILabel()
    
    func heartRateUpdated(to bpm: Int) {
        heartRateLabel.text = "The user has been shown a heart rate of \(bpm)."
        print("The user has been shown a heart rate of \(bpm).")
    }
}


let sampleHeartRate = HeartRateReceiver()

sampleHeartRate.startHeartRateMonitoringExample()

let sampleHeartRateView = HeartRateViewController()

sampleHeartRate.delegate = sampleHeartRateView

