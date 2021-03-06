import Foundation
import RxSwift
#if !COCOAPODS
    import Moya
#endif

/// Extension for processing raw NSData generated by network access.
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {

    /// Filters out responses that don't fall within the given range, generating errors when others are encountered.
    public func filter(statusCodes: ClosedRange<Int>) -> Single<ElementType> {
        return flatMap { .just(try $0.filter(statusCodes: statusCodes)) }
    }

    public func filter(statusCode: Int) -> Single<ElementType> {
        return flatMap { .just(try $0.filter(statusCode: statusCode)) }
    }

    public func filterSuccessfulStatusCodes() -> Single<ElementType> {
        return flatMap { .just(try $0.filterSuccessfulStatusCodes()) }
    }

    public func filterSuccessfulStatusAndRedirectCodes() -> Single<ElementType> {
        return flatMap { .just(try $0.filterSuccessfulStatusAndRedirectCodes()) }
    }

    /// Maps data received from the signal into an Image. If the conversion fails, the signal errors.
    public func mapImage() -> Single<Image?> {
        return flatMap { .just(try $0.mapImage()) }
    }

    /// Maps data received from the signal into a JSON object. If the conversion fails, the signal errors.
    public func mapJSON(failsOnEmptyData: Bool = true) -> Single<Any> {
        return flatMap { .just(try $0.mapJSON(failsOnEmptyData: failsOnEmptyData)) }
    }

    /// Maps received data at key path into a String. If the conversion fails, the signal errors.
    public func mapString(atKeyPath keyPath: String? = nil) -> Single<String> {
        return flatMap { .just(try $0.mapString(atKeyPath: keyPath)) }
    }

    /// Maps received data at key path into a Decodable object. If the conversion fails, the signal errors.
    public func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> Single<D> {
        return flatMap { .just(try $0.map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)) }
    }
}
