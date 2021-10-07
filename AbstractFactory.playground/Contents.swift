/// The Abstract Factory protocol declares a set of methods that return
/// different abstract products.
protocol AbstractCarFactory {

    func createSportsCar() -> AbstractSportsCar
    func createFamilyCar() -> AbstractFamilyCar
}

/// Concrete Factories produce a family of products that belong to a single
/// variant. The factory guarantees that resulting products are compatible.
class ConcreteMazdaFactory: AbstractCarFactory {
    
    func createSportsCar() -> AbstractSportsCar {
        ConcreteMazdaMX5()
    }
    
    func createFamilyCar() -> AbstractFamilyCar {
        ConcreteMazdaCX30()
    }
}

/// Each Concrete Factory has a corresponding product variant.
class ConcreteFordFactory: AbstractCarFactory {

    func createSportsCar() -> AbstractSportsCar {
        return ConcreteFordMustang()
    }

    func createFamilyCar() -> AbstractFamilyCar {
        return ConcreteFordMondeo()
    }
}

/// Each distinct product of a product family should have a base protocol. All
/// variants of the product must implement this protocol.
protocol AbstractSportsCar {

    func costOfCar() -> Double
}

/// Concrete Cars are created by corresponding Concrete Factories.
class ConcreteMazdaMX5: AbstractSportsCar {

    func costOfCar() -> Double {
        return 26960
    }
}

class ConcreteFordMustang: AbstractSportsCar {

    func costOfCar() -> Double {
        return 27205
    }
}

/// The base protocol of another product. All products can interact with each
/// other, but proper interaction is possible only between products of the same
/// concrete variant.
protocol AbstractFamilyCar {

    /// Car B is able to do its own thing...
    func costOfCar() -> Double

    /// ...but it also can collaborate with the CarA.
    ///
    /// The Abstract Factory makes sure that all products it creates are of the
    /// same variant and thus, compatible.
    func upgradeToSportsVehicle(collaborator: AbstractSportsCar) -> String
}

/// Concrete Cars are created by corresponding Concrete Factories.
class ConcreteMazdaCX30: AbstractFamilyCar {

    func costOfCar() -> Double {
        return 22050
    }

    /// This variant, Car B1, is only able to work correctly with the
    /// variant, Car A1. Nevertheless, it accepts any instance of
    /// AbstractCarA as an argument.
    func upgradeToSportsVehicle(collaborator: AbstractSportsCar) -> String {
        let result = collaborator.costOfCar()
        return "To upgrade it would to a sports car, it would cost $\(result - costOfCar())"
    }
}

class ConcreteFordMondeo: AbstractFamilyCar {

    func costOfCar() -> Double {
        return 22100
    }

    /// This variant, Car B2, is only able to work correctly with the
    /// variant, Car A2. Nevertheless, it accepts any instance of
    /// AbstractCarA as an argument.
    func upgradeToSportsVehicle(collaborator: AbstractSportsCar) -> String {
        let result = collaborator.costOfCar()
        return "To upgrade it would to a sports car, it would cost $\(result - costOfCar())"
    }
}

/// The client code works with factories and products only through abstract
/// types: AbstractFactory and AbstractCar. This lets you pass any factory
/// or product subclass to the client code without breaking it.
class Client {
  
    static func someClientCode(factory: AbstractCarFactory) {
        
        let productA = factory.createSportsCar()
        let productB = factory.createFamilyCar()

        print(productB.costOfCar())
        print(productB.upgradeToSportsVehicle(collaborator: productA))
    }

}

/// Let's see how it all works together.
class AbstractFactoryConceptual {

    func testAbstractFactoryConceptual() {

        /// The client code can work with any concrete factory class.

        print("Client: Testing client code with the first factory type:")
        Client.someClientCode(factory: ConcreteMazdaFactory())

        print("Client: Testing the same client code with the second factory type:")
        Client.someClientCode(factory: ConcreteFordFactory())
    }
}

AbstractFactoryConceptual().testAbstractFactoryConceptual()

