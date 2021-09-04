//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 03.09.2021.
//

import Foundation
import Moya

struct WeatherApiResults<T: Decodable>: Decodable {
    let results: [T]
}

enum WeatherService {
  case getImage(abbreviation: String)
  case getCities(query: String)
  case getWeek(woeid: Int)
  case getDay(woeid: Int, date: String)
}

// MARK: - TargetType Protocol Implementation
extension WeatherService: TargetType {
  var baseURL: URL { return URL(string: "https://www.metaweather.com")! }
  var path: String {
    switch self {
    case .getImage(let abbreviation):
      return "/static/img/weather/\(abbreviation).svg"
    case .getWeek(let woeid):
      return "/api/location/\(woeid)/"
    case .getDay(let woeid, let date):
      return "/api/location/\(woeid)/\(date)/"
    case .getCities(let query):
      return "/api/location/search/"
    }
  }
  var method: Moya.Method {
    return .get
  }
  var task: Task {
    switch self {
    case .getCities(let query):
      return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
    default:
      return .requestPlain
    }
  }
  var sampleData: Data {
    return Data()
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }

  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}